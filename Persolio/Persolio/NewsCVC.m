//
//  NewsCVC.m
//  Persolio
//
//  Created by Ali Soume`e on 5/14/1396 AP.
//  Copyright © 1396 Ali Soume`e. All rights reserved.
//

#import "NewsCVC.h"

@implementation NewsCVC

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.clipsToBounds = YES;
        
        _title = [UILabel new];
        _title.text = @"معمار";
        _title.backgroundColor = [UIColor clearColor];
        _title.textAlignment = NSTextAlignmentRight;
        _title.textColor = [UIColor redColor];
        _title.font = [UIFont fontWithName:@"IRANSansMobile-Bold" size:24];
        [self addSubview:_title];
        _title.translatesAutoresizingMaskIntoConstraints = NO;
        [_title sdc_alignEdgesWithSuperview:UIRectEdgeAll ^ UIRectEdgeBottom  insets:UIEdgeInsetsMake(10, 10, 0, -10)];
        
        _imageView = [UIImageView new];
        _imageView.backgroundColor = [UIColor greenColor];
        _imageView.clipsToBounds = YES;
        _imageView.layer.cornerRadius = 10;
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_imageView];
        [_imageView sdc_alignEdgesWithSuperview:UIRectEdgeRight | UIRectEdgeLeft insets:UIEdgeInsetsMake(0, 10, 0, -10)];
        [_imageView sdc_alignEdge:UIRectEdgeTop withEdge:UIRectEdgeBottom ofView:_title inset:0];
        [_imageView sdc_pinHeight:self.bounds.size.height * 0.6];
        
        _name = [UILabel new];
        _name.text = @"دکتر مرادی";
        _name.backgroundColor = [UIColor clearColor];
        _name.textAlignment = NSTextAlignmentLeft;
        _name.textColor = [UIColor redColor];
        _name.font = [UIFont fontWithName:@"IRANSansMobile-Bold" size:18];
        [self addSubview:_name];
        _name.translatesAutoresizingMaskIntoConstraints = NO;
        [_name sdc_alignEdgesWithSuperview:UIRectEdgeLeft | UIRectEdgeRight  insets:UIEdgeInsetsMake(0, 10, 0, -10)];
        [_name sdc_alignEdge:UIRectEdgeTop withEdge:UIRectEdgeBottom ofView:_imageView inset:10];
        
        _desc = [UILabel new];
        _desc.text = @"توضیحاتی درباره دکتر مرادی";
        _desc.backgroundColor = [UIColor clearColor];
        _desc.textAlignment = NSTextAlignmentRight;
        _desc.textColor = [UIColor blackColor];
        _desc.font = [UIFont fontWithName:@"IRANSansMobile-Bold" size:14];
        [self addSubview:_desc];
        _desc.translatesAutoresizingMaskIntoConstraints = NO;
        [_desc sdc_alignEdgesWithSuperview:UIRectEdgeLeft | UIRectEdgeRight insets:UIEdgeInsetsMake(0, 10, 0, -10)];
        [_desc sdc_alignEdge:UIRectEdgeTop withEdge:UIRectEdgeBottom ofView:_name inset:10];
        
    }
    return self;
}


@end
