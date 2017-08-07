//
//  CartCVC.m
//  Persolio
//
//  Created by Ali Soume`e on 5/16/1396 AP.
//  Copyright © 1396 Ali Soume`e. All rights reserved.
//

#import "CartCVC.h"

@implementation CartCVC



- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
//        self.layer.cornerRadius = 30;
        self.clipsToBounds = YES;
        
        
        _imageView = [UIImageView new];
        _imageView.clipsToBounds = YES;
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_imageView];
        [_imageView sdc_alignEdgesWithSuperview:UIRectEdgeTop | UIRectEdgeBottom | UIRectEdgeLeft insets:UIEdgeInsetsMake(5, 20, -5, 0)];
        [_imageView sdc_pinHeightWidthRatio:1 constant:0];
        _imageView.layer.cornerRadius = 30;
        _imageView.backgroundColor = [UIColor redColor];
        
        _desc = [UILabel new];
        _desc.textAlignment = NSTextAlignmentLeft;
        _desc.font = [UIFont fontWithName:@"IRANSansMobile-Light" size:15];
        [self addSubview:_desc];
        _desc.translatesAutoresizingMaskIntoConstraints = NO;
        [_desc sdc_alignEdgesWithSuperview:UIRectEdgeAll ^ UIRectEdgeLeft];
        [_desc sdc_alignEdge:UIRectEdgeLeft withEdge:UIRectEdgeRight ofView:_imageView inset:20];
        _desc.text = @"چگونه یک کتاب را سریع تر بخوانیم";
        
        UIView *line = [helper horizontalHairlineWithColor:[UIColor lightGrayColor]];
        [self addSubview:line];
        [line sdc_alignEdgesWithSuperview:UIRectEdgeAll ^ UIRectEdgeTop insets:UIEdgeInsetsMake(0, 40, 0, -40)];
    }
    return self;
}


@end
