//
//  MyBouncyButton.h
//  mactehrannew
//
//  Created by hAmidReza on 5/29/17.
//  Copyright © 2017 archibits. All rights reserved.
//

#import "MyShapeButton.h"

@interface MyBouncyButton : MyShapeButton


-(instancetype)initWithShapeDesc:(NSArray *)desc andShapeTintColor:(UIColor *)shapeTintColor andButtonClick:(void (^)(BOOL on))buttonClick;

@property (copy, nonatomic) void (^bouncyButtonClick)(BOOL);
@property (copy, nonatomic) BOOL (^canChangeToMode)(BOOL);

@property (assign, nonatomic) BOOL onOffBehavior; //default: true
@property (assign, nonatomic) BOOL on;

//off state
@property (retain, nonatomic) NSArray* icon1;
@property (retain, nonatomic) UIColor* shapeTintColor1;
@property (retain, nonatomic) UIColor* backgroundColor1;

//on state
@property (retain, nonatomic) NSArray* icon2;
@property (retain, nonatomic) UIColor* shapeTintColor2;
@property (retain, nonatomic) UIColor* backgroundColor2;

-(void)setOn:(BOOL)on animated:(BOOL)animated;

-(void)buttonTouch:(id)sender;

@end
