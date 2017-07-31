//
//  MyBoredredFlatButton.h
//  mactehrannew
//
//  Created by hAmidReza on 5/29/17.
//  Copyright © 2017 archibits. All rights reserved.
//

#import "_UIControlBase.h"

@interface MyFlatButton : _UIControlBase

@property (retain, nonatomic) UILabel* theTitleLabel;
@property (retain, nonatomic) NSNumber* disabled_alpha;


/**
 default: 140, 140, 140, 1.0f
 */
@property (retain, nonatomic) UIColor* borderColor;


/**
 default: 1.0f
 */
@property (assign, nonatomic) CGFloat borderWidth;


/**
 default: 3.0f
 */
@property (assign, nonatomic) CGFloat cornerRadius;

-(void)setEnabled:(BOOL)enabled animated:(BOOL)animated;

@end
