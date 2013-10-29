//
//  SDBDSound.h
//  Soundboard
//
//  Created by Bryan Irace on 10/28/13.
//  Copyright (c) 2013 Bryan Irace. All rights reserved.
//

@interface SDBDSound : NSObject

@property (copy, readonly) NSString *filePath;
@property (copy, readonly) NSString *name;

- (instancetype)initWithFilePath:(NSString *)filePath name:(NSString *)name;

@end
