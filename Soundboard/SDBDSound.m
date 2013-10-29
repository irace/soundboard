//
//  SDBDSound.m
//  Soundboard
//
//  Created by Bryan Irace on 10/28/13.
//  Copyright (c) 2013 Bryan Irace. All rights reserved.
//

#import "SDBDSound.h"

@interface SDBDSound()

@property (copy) NSString *filePath;

@end

@implementation SDBDSound

- (instancetype)initWithFilePath:(NSString *)filePath {
    if (self = [super init]) {
        self.filePath = filePath;
    }
    
    return self;
}

- (NSString *)name {
    return [[self.filePath componentsSeparatedByString:@"."] firstObject];
}

@end
