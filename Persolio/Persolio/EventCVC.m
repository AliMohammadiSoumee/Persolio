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
        _title.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.80];
        _title.textAlignment = NSTextAlignmentCenter;
        _title.textColor = [UIColor colorWithRed:185.0/225 green:185.0/255 blue:120.0/255 alpha:1];
        _title.font = [UIFont fontWithName:@"IRANSansMobile-Medium" size:24];
        [self addSubview:_title];
        _title.translatesAutoresizingMaskIntoConstraints = NO;
        [_title sdc_alignEdgesWithSuperview:UIRectEdgeAll ^ UIRectEdgeTop];
        [_title sdc_pinHeight:self.bounds.size.height * 0.4];
    }
    return self;
}

@end
