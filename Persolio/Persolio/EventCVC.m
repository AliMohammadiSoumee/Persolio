//
//  EventCVC.m
//  Persolio
//
//  Created by Ali Soume`e on 5/12/1396 AP.
//  Copyright © 1396 Ali Soume`e. All rights reserved.
//

#import "EventCVC.h"

@implementation EventCVC




- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = 30;
        self.backgroundColor = [UIColor redColor];
        self.clipsToBounds = YES;
        
        
        _imageView = [UIImageView new];
        _imageView.clipsToBounds = YES;
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_imageView];
        [_imageView sdc_alignEdgesWithSuperview:UIRectEdgeAll];
        
        _title = [UILabel new];
    }
    return self;
}

@end
