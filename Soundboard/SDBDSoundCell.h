//
//  SDBDSoundCell.h
//  Soundboard
//
//  Created by Bryan Irace on 10/28/13.
//  Copyright (c) 2013 Bryan Irace. All rights reserved.
//

#import "SDBDSound.h"

@interface SDBDSoundCell : UICollectionViewCell

@property SDBDSound *sound;

- (instancetype)initWithFrame:(CGRect)frame;

@end
