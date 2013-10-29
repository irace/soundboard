//
//  SDBDAppDelegate.m
//  Soundboard
//
//  Created by Bryan Irace on 10/28/13.
//  Copyright (c) 2013 Bryan Irace. All rights reserved.
//

#import "SDBDAppDelegate.h"
#import "SDBDCollectionViewController.h"

@implementation SDBDAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.window.rootViewController = [[SDBDCollectionViewController alloc] initWithCollectionViewLayout:
                                      [[UICollectionViewFlowLayout alloc] init]];
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
