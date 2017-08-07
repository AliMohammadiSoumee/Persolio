//
//  CartCVC1.m
//  Persolio
//
//  Created by Ali Soume`e on 5/16/1396 AP.
//  Copyright © 1396 Ali Soume`e. All rights reserved.
//

#import "CartCVC1.h"

@implementation CartCVC1


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
//        self.layer.cornerRadius ;
        self.clipsToBounds = YES;
        
        
        _imageView = [UIImageView new];
        _imageView.clipsToBounds = YES;
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_imageView];
        _imageView.backgroundColor = [UIColor blackColor];
        [_imageView sdc_alignEdgesWithSuperview:UIRectEdgeTop | UIRectEdgeBottom | UIRectEdgeLeft insets:UIEdgeInsetsMake(0, 0, 0, 0)];
        [_imageView sdc_pinHeightWidthRatio:1 constant:0];
    }
    return self;
}


@end
