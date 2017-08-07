//
//  BasketCVC.m
//  Persolio
//
//  Created by Ali Soume`e on 5/14/1396 AP.
//  Copyright © 1396 Ali Soume`e. All rights reserved.
//

#import "BasketCVC.h"

@implementation BasketCVC

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
//        self.layer.cornerRadius = 30;
        self.backgroundColor = [UIColor blueColor];
        self.clipsToBounds = YES;
        
        
        _imageView = [UIImageView new];
        _imageView.clipsToBounds = YES;
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_imageView];
        [_imageView sdc_alignEdgesWithSuperview:UIRectEdgeAll];
        
//        _title = [UILabel new];
//        _title.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.80];
//        _title.textAlignment = NSTextAlignmentCenter;
//        _title.textColor = [UIColor colorWithRed:185.0/225 green:185.0/255 blue:120.0/255 alpha:1];
//        _title.text = @"TEST";
//        [_title setFont:[UIFont fontWithName:@"IRANSansMobile_Medium.ttf" size:24]];
//        [self addSubview:_title];
//        _title.translatesAutoresizingMaskIntoConstraints = NO;
//        [_title sdc_alignEdgesWithSuperview:UIRectEdgeAll ^ UIRectEdgeTop];
//        [_title sdc_pinHeight:self.bounds.size.height * 0.4];
    }
    return self;
}

@end
