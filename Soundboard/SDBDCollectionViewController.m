//
//  SDBDCollectionViewController.m
//  Soundboard
//
//  Created by Bryan Irace on 10/28/13.
//  Copyright (c) 2013 Bryan Irace. All rights reserved.
//

#import "BRYSoundEffectPlayer.h"
#import "SDBDCollectionViewController.h"
#import "SDBDSound.h"
#import "SDBDResourceAggregator.h"
#import "SDBDSoundCell.h"

static CGFloat const CollectionLayoutMinLineSpacing = 15;
static CGFloat const CollectionLayoutItemSize = 100;
static NSString * const CellIdentifier = @"CellIdentifier";

@interface SDBDCollectionViewController ()

@property NSArray *sounds;

@end

@implementation SDBDCollectionViewController

#pragma mark - NSObject

- (id)init {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = CollectionLayoutMinLineSpacing;
    layout.itemSize = CGSizeMake(CollectionLayoutItemSize, CollectionLayoutItemSize);
    
    if (self = [super initWithCollectionViewLayout:layout]) {
        self.sounds = [SDBDResourceAggregator resourcesInBundle:[NSBundle mainBundle] withFileExtensions:@[@"wav", @"mp3", @"aif"]];
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
    
    [BRYSoundEffectPlayer sharedInstance].playsSoundsConcurrently = NO;
    
    self.collectionView.contentInset = UIEdgeInsetsMake(CGRectGetHeight([UIApplication sharedApplication].statusBarFrame), 0, 0, 0);
    [self.collectionView registerClass:[SDBDSoundCell class] forCellWithReuseIdentifier:CellIdentifier];
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    SDBDSound *sound = self.sounds[indexPath.row];
    
    [[BRYSoundEffectPlayer sharedInstance] playSound:sound.filePath];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.sounds count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SDBDSoundCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.sound = self.sounds[indexPath.row];

    return cell;
}

@end
