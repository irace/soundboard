//
//  SDBDCollectionViewController.m
//  Soundboard
//
//  Created by Bryan Irace on 10/28/13.
//  Copyright (c) 2013 Bryan Irace. All rights reserved.
//

#import "SDBDCollectionViewController.h"
#import "SDBDSound.h"
#import "SDBDSoundCell.h"
#import "SDBDSoundPlayer.h"

static NSString * const SDBDSoundCellIdentifier = @"SDBDSoundCellIdentifier";


@interface SDBDCollectionViewController ()

@property NSArray *sounds;

@end

@implementation SDBDCollectionViewController

- (id)init {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 15;
    layout.itemSize = CGSizeMake(100, 100);
    
    if (self = [super initWithCollectionViewLayout:layout]) {
        NSError *error = nil;
        NSArray *directoryContents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[[NSBundle mainBundle] resourcePath]
                                                                                         error:&error];
        
        if (error) {
            NSLog(@"Error reading contents of directory: %@ %@", error, [error userInfo]);
        }
        
        NSMutableArray *sounds = [[NSMutableArray alloc] init];
        
        [directoryContents enumerateObjectsUsingBlock:^(NSString *filePath, NSUInteger index, BOOL *stop) {
            if ([filePath hasSuffix:@".wav"]) {
                [sounds addObject:[[SDBDSound alloc] initWithFilePath:filePath]];
            }
        }];
        
        self.sounds = sounds;
    }
    
    return self;
}

#pragma mark - UICollectionViewController

- (id)initWithCollectionViewLayout:(UICollectionViewLayout *)layout {
    return [self init];
}

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.contentInset = UIEdgeInsetsMake(CGRectGetHeight([UIApplication sharedApplication].statusBarFrame), 0, 0, 0);
    
    [self.collectionView registerClass:[SDBDSoundCell class] forCellWithReuseIdentifier:SDBDSoundCellIdentifier];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
#warning - Figure out how to do this in Info.plist
    return UIStatusBarStyleLightContent;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    SDBDSound *sound = self.sounds[indexPath.row];
    NSArray *filePathComponents = [sound.filePath componentsSeparatedByString:@"."];
    
    [SDBDSoundPlayer playSound:[[NSBundle mainBundle] pathForResource:[filePathComponents firstObject]
                                                               ofType:[filePathComponents lastObject]]];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.sounds count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SDBDSoundCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:SDBDSoundCellIdentifier forIndexPath:indexPath];
    cell.sound = self.sounds[indexPath.row];

    return cell;
}

@end
