//
//  SDBDSoundCell.m
//  Soundboard
//
//  Created by Bryan Irace on 10/28/13.
//  Copyright (c) 2013 Bryan Irace. All rights reserved.
//

#import "SDBDSoundCell.h"

static NSString * const SoundKeyPath = @"sound";
static void * SDBDSoundCellKVOContext = &SDBDSoundCellKVOContext;
static CGFloat CellAlpha = 1.0;
static CGFloat CellHighlightedAlpha = 0.8;
static CGFloat CellBackgroundAlpha = 0.7;
static CGFloat CellBackgroundWhite = 1.0;
static CGFloat CellBorderWhite = 0.5;

static CGFloat DevicePixelHeight;

@interface SDBDSoundCell()

@property (nonatomic) UILabel *label;

@end


@implementation SDBDSoundCell

#pragma mark - UIView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            DevicePixelHeight = 1.0/[[UIScreen mainScreen] scale];
        });
        
        self.backgroundColor = [UIColor colorWithWhite:CellBackgroundWhite alpha:CellBackgroundAlpha];
        self.layer.borderColor = [UIColor colorWithWhite:CellBorderWhite alpha:CellBackgroundAlpha].CGColor;
        self.layer.borderWidth = DevicePixelHeight;
        
        self.label = [[UILabel alloc] init];
        self.label.translatesAutoresizingMaskIntoConstraints = NO;
        self.label.numberOfLines = 0;
        self.label.minimumScaleFactor = 0.5f;
        self.label.adjustsFontSizeToFitWidth = YES;
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.lineBreakMode = NSLineBreakByTruncatingMiddle;
        [self.contentView addSubview:self.label];
        
        NSMutableArray *constraints = [[NSMutableArray alloc] init];

        [constraints addObject:[NSLayoutConstraint constraintWithItem:self.label
                                                            attribute:NSLayoutAttributeCenterX
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:self.contentView
                                                            attribute:NSLayoutAttributeCenterX
                                                           multiplier:1.0
                                                             constant:0.0]];
        
        [constraints addObject:[NSLayoutConstraint constraintWithItem:self.label
                                                            attribute:NSLayoutAttributeCenterY
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:self.contentView
                                                            attribute:NSLayoutAttributeCenterY
                                                           multiplier:1.0
                                                             constant:0.0]];
        
        [constraints addObject:[NSLayoutConstraint constraintWithItem:self.label
                                                            attribute:NSLayoutAttributeWidth
                                                            relatedBy:NSLayoutRelationLessThanOrEqual
                                                               toItem:self.contentView
                                                            attribute:NSLayoutAttributeWidth
                                                           multiplier:1.0
                                                             constant:0.0]];
        
        [constraints addObject:[NSLayoutConstraint constraintWithItem:self.label
                                                            attribute:NSLayoutAttributeHeight
                                                            relatedBy:NSLayoutRelationLessThanOrEqual
                                                               toItem:self.contentView
                                                            attribute:NSLayoutAttributeHeight
                                                           multiplier:1.0
                                                             constant:0.0]];
        
        [self addConstraints:constraints];
        
        [self addObserver:self forKeyPath:SoundKeyPath options:0 context:SDBDSoundCellKVOContext];
    }
    
    return self;
}

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    
    if (highlighted) {
        self.alpha = CellHighlightedAlpha;
    }
    else {
        self.alpha = CellAlpha;
    }
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (object == self && context == SDBDSoundCellKVOContext) {
        self.label.text = self.sound.name;
        [self.contentView layoutIfNeeded];
    }
    else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark - NSObject

- (void)dealloc {
    [self removeObserver:self forKeyPath:SoundKeyPath context:SDBDSoundCellKVOContext];
}

@end
