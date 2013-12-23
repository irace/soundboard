//
//  SDBDSoundAggregator.h
//  Soundboard
//
//  Created by Bryan Irace on 10/28/13.
//  Copyright (c) 2013 Bryan Irace. All rights reserved.
//

@interface SDBDResourceAggregator : NSObject

+ (NSArray *)resourcesInBundle:(NSBundle *)bundle withFileExtensions:(NSArray *)extensions;

@end
