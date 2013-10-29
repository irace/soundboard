//
//  SDBDSoundCell.m
//  Soundboard
//
//  Created by Bryan Irace on 10/28/13.
//  Copyright (c) 2013 Bryan Irace. All rights reserved.
//

#import "SDBDSoundCell.h"

static void * SDBDSoundCellKVOContext = &SDBDSoundCellKVOContext;
static CGFloat SDBDDevicePixelHeight;


@interface SDBDSoundCell()

@property UILabel *label;

@end


@implementation SDBDSoundCell

#pragma mark - UIView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            SDBDDevicePixelHeight = 1.0/[[UIScreen mainScreen] scale];
        });
        
        self.backgroundColor = [UIColor colorWithWhite:1 alpha:0.7];
        self.layer.borderColor = [UIColor colorWithWhite:0.5 alpha:0.7].CGColor;
        self.layer.borderWidth = SDBDDevicePixelHeight;
        
        self.label = [[UILabel alloc] init];
        self.label.translatesAutoresizingMaskIntoConstraints = NO;
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
        
        [self addConstraints:constraints];
        
        [self addObserver:self forKeyPath:@"sound" options:0 context:SDBDSoundCellKVOContext];
    }
    
    return self;
}

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    
    if (highlighted) {
        self.alpha = 0.8;
    }
    else {
        self.alpha = 1;
    }
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (object == self && context == SDBDSoundCellKVOContext) {
        self.label.text = self.sound.name;
        [self.label sizeToFit];
    }
    else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

@end
