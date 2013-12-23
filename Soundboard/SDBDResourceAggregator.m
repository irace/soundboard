//
//  SDBDSoundAggregator.m
//  Soundboard
//
//  Created by Bryan Irace on 10/28/13.
//  Copyright (c) 2013 Bryan Irace. All rights reserved.
//

#import "SDBDResourceAggregator.h"
#import "SDBDSound.h"

@implementation SDBDResourceAggregator

+ (NSArray *)resourcesInBundle:(NSBundle *)bundle withFileExtensions:(NSArray *)extensions {
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
        
        if ([extensions containsObject:fileType]) {
            NSString *fullFilePath = [bundle pathForResource:fileName ofType:fileType];
            
            [sounds addObject:[[SDBDSound alloc] initWithFilePath:fullFilePath name:fileName]];
        }
    }];
    
    return [[NSArray alloc] initWithArray:sounds];
}

@end
