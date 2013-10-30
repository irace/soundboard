//
//  SDBDCollectionViewController.m
//  Soundboard
//
//  Created by Bryan Irace on 10/28/13.
//  Copyright (c) 2013 Bryan Irace. All rights reserved.
//

#import "SDBDCollectionViewController.h"
#import "SDBDSound.h"
#import "SDBDSoundAggregator.h"
#import "SDBDSoundCell.h"
#import "SDBDSoundPlayer.h"

static NSString * const SDBDSoundCellIdentifier = @"SDBDSoundCellIdentifier";

@interface SDBDCollectionViewController ()

@property NSArray *sounds;

@end

@implementation SDBDCollectionViewController

#pragma mark - NSObject

- (id)init {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 15;
    layout.itemSize = CGSizeMake(100, 100);
    
    if (self = [super initWithCollectionViewLayout:layout]) {
        self.sounds = [SDBDSoundAggregator soundsInBundle:[NSBundle mainBundle]];
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

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    SDBDSound *sound = self.sounds[indexPath.row];
    
    [[SDBDSoundPlayer sharedInstance] playSound:sound.filePath];
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
