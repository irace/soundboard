//
//  SDBDSoundPlayer.h
//  Soundboard
//
//  Created by Bryan Irace on 10/28/13.
//  Copyright (c) 2013 Bryan Irace. All rights reserved.
//

@interface SDBDSoundPlayer : NSObject

@property (nonatomic) BOOL playsSoundsConcurrently;

+ (instancetype)sharedInstance;

- (void)playSound:(NSString *)filePath;

@end
