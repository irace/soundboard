//
//  SDBDSoundPlayer.m
//  Soundboard
//
//  Created by Bryan Irace on 10/28/13.
//  Copyright (c) 2013 Bryan Irace. All rights reserved.
//

#import "SDBDSoundPlayer.h"
#import <AudioToolbox/AudioToolbox.h>

@implementation SDBDSoundPlayer

+ (void)playSound:(NSString *)filePath {
    SystemSoundID soundID;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:filePath], &soundID);
    AudioServicesPlaySystemSound(soundID);
}

// TODO: Cache sounds
// TODO: Stop a sound if another starts: http://www.iphonedevsdk.com/forum/iphone-sdk-development/4446-simple-sound-question.html

@end
