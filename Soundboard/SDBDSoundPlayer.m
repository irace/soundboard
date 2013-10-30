//
//  SDBDSoundPlayer.m
//  Soundboard
//
//  Created by Bryan Irace on 10/28/13.
//  Copyright (c) 2013 Bryan Irace. All rights reserved.
//

#import "SDBDSoundPlayer.h"
#import <AudioToolbox/AudioToolbox.h>

#define SDBDSoundNotFound 0

@interface SDBDSoundPlayer()

@property (nonatomic) NSMutableDictionary *filePathsToSoundIDs;
@property (nonatomic) NSString *currentSoundFilePath;

@end

@implementation SDBDSoundPlayer

+ (instancetype)sharedInstance {
    static SDBDSoundPlayer *player;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        player = [[SDBDSoundPlayer alloc] init];
    });
    
    return player;
}

#pragma mark - NSObject

- (id)init {
    if (self = [super init]) {
        self.filePathsToSoundIDs = [[NSMutableDictionary alloc] init];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clearCache)
                                                     name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
    }
    
    return self;
}

#pragma mark - SDBDSoundPlayer

- (void)playSound:(NSString *)filePath {
    if (!self.playsSoundsConcurrently && self.currentSoundFilePath) {
        SDBDDisposeOfSound([self soundIDForFilePath:self.currentSoundFilePath]);
        
        [self.filePathsToSoundIDs removeObjectForKey:self.currentSoundFilePath];
    }
    
    self.currentSoundFilePath = filePath;
    
    SystemSoundID soundID = [self soundIDForFilePath:filePath];
    
    if (soundID == SDBDSoundNotFound) {
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:filePath], &soundID);
        self.filePathsToSoundIDs[filePath] = [NSNumber numberWithLong:soundID];
    }
    
    AudioServicesAddSystemSoundCompletion(soundID, NULL, NULL, completionCallback, (__bridge void *)(self));
    AudioServicesPlaySystemSound(soundID);
}

#pragma mark - Private

- (void)clearCache {
    for (NSString *filePath in [self.filePathsToSoundIDs allKeys]) {
        SDBDDisposeOfSound([self soundIDForFilePath:filePath]);
    }
    
    [self.filePathsToSoundIDs removeAllObjects];
    
    self.currentSoundFilePath = nil;
}

- (SystemSoundID)soundIDForFilePath:(NSString *)filePath {
    return [self.filePathsToSoundIDs[filePath] longValue];
}

static void SDBDDisposeOfSound(SystemSoundID soundID) {
    AudioServicesRemoveSystemSoundCompletion(soundID);
    AudioServicesDisposeSystemSoundID(soundID);
}

static void completionCallback (SystemSoundID soundID, void *object) {
    SDBDSoundPlayer *soundPlayer = (__bridge SDBDSoundPlayer *)object;
    soundPlayer.currentSoundFilePath = nil;
    
	AudioServicesRemoveSystemSoundCompletion(soundID);
}

#pragma mark - NSObject

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
