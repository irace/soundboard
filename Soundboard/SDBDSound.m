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
@property (copy) NSString *name;

@end

@implementation SDBDSound

- (instancetype)initWithFilePath:(NSString *)filePath name:(NSString *)name {
    if (self = [super init]) {
        self.filePath = filePath;
        self.name = name;
    }
    
    return self;
}

@end
