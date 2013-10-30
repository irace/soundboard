//
//  SDBDSoundAggregator.m
//  Soundboard
//
//  Created by Bryan Irace on 10/28/13.
//  Copyright (c) 2013 Bryan Irace. All rights reserved.
//

#import "SDBDSoundAggregator.h"
#import "SDBDSound.h"

@implementation SDBDSoundAggregator

static NSArray *SDBDSoundAggregatorSupportedFileTypes;

+ (NSArray *)soundsInBundle:(NSBundle *)bundle {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SDBDSoundAggregatorSupportedFileTypes = @[@"wav", @"mp3", @"aif"];
    });
    
    NSString *directoryPath = [bundle resourcePath];
    NSError *error = nil;
    NSArray *directoryContents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:directoryPath error:&error];
    
    if (error) {
        NSLog(@"Error reading contents of directory %@: %@ %@", directoryPath, error, [error userInfo]);
    }
    
    NSMutableArray *sounds = [[NSMutableArray alloc] init];
    
    [directoryContents enumerateObjectsUsingBlock:^(NSString *filePath, NSUInteger index, BOOL *stop) {
        NSArray *filePathComponents = [filePath componentsSeparatedByString:@"."];
        NSString *fileName = [filePathComponents firstObject];
        NSString *fileType = [filePathComponents lastObject];
        
        if ([SDBDSoundAggregatorSupportedFileTypes containsObject:fileType]) {
            NSString *fullFilePath = [bundle pathForResource:fileName ofType:fileType];
            
            [sounds addObject:[[SDBDSound alloc] initWithFilePath:fullFilePath name:fileName]];
        }
    }];
    
    return [[NSArray alloc] initWithArray:sounds];
}

@end
