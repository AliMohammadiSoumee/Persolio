//
//  MyBouncyButton.m
//  mactehrannew
//
//  Created by hAmidReza on 5/29/17.
//  Copyright © 2017 archibits. All rights reserved.
//

#import "MyBouncyButton.h"
//#import "helper.h"
#import "Codebase.h"
#import <POP/pop.h>

@interface MyBouncyButton ()

@end

@implementation MyBouncyButton
-(instancetype)initWithShapeDesc:(NSArray *)desc andShapeTintColor:(UIColor *)shapeTintColor andButtonClick:(void (^)(BOOL on))buttonClick;
{
	self = [super initWithShapeDesc:desc andShapeTintColor:shapeTintColor andButtonClick:nil];
	if (self)
	{
		_bouncyButtonClick = buttonClick;
		_icon1 = desc;
		_shapeTintColor1 = shapeTintColor;
		_onOffBehavior = YES;
	}
	return self;
}

-(void)setBackgroundColor:(UIColor *)backgroundColor
{
	[super setBackgroundColor:backgroundColor];
	_backgroundColor1 = backgroundColor ? backgroundColor : [UIColor clearColor];
}

-(void)setOn:(BOOL)on animated:(BOOL)animated
{
	if (!_onOffBehavior)
		return;
	
	_on = on;
	
	[UIView animateWithDuration:animated ? .3 : 0 animations:^{
		[self refreshUI];
	}];
}

-(void)refreshUI
{
	if (_on)
	{
		[super setBackgroundColor:_backgroundColor2 ? _backgroundColor2 : _backgroundColor1];
		self.shapeView.shapeDesc = _icon2 ? _icon2 : _icon1;
		self.shapeView.shapeTintColor = _shapeTintColor2 ? _shapeTintColor2 : _shapeTintColor1;
	}
	else
	{
		[super setBackgroundColor:_backgroundColor1];
		self.shapeView.shapeDesc = _icon1;
		self.shapeView.shapeTintColor = _shapeTintColor1;
	}
}


-(void)setOn:(BOOL)on
{
	[self setOn:on animated:NO];
}

-(void)buttonTouch:(id)sender
{
	if (_canChangeToMode)
		if (!_canChangeToMode(_onOffBehavior ? !_on : false))
			return;
	
	[self pop_removeAllAnimations];
	POPSpringAnimation *springAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
	springAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(1, 1)];
	springAnimation.velocity = [NSValue valueWithCGPoint:CGPointMake(10, 10)];
	springAnimation.springBounciness = 20.0f;
	[self pop_addAnimation:springAnimation forKey:@"springAnimation"];
	
	if (_onOffBehavior)
	{
		[self setOn:!_on animated:YES];
		
		if (_bouncyButtonClick)
			_bouncyButtonClick(_on);
	}
	else
		_bouncyButtonClick(false);
}


-(void)setIcon2:(NSArray *)icon2
{
	_icon2 = icon2;
	[self refreshUI];
}

-(void)setBackgroundColor2:(UIColor *)backgroundColor2
{
	_backgroundColor2 = backgroundColor2;
	[self refreshUI];
}

-(void)setShapeTintColor2:(UIColor *)shapeTintColor2
{
	_shapeTintColor2 = shapeTintColor2;
	[self refreshUI];
}


-(void)setIcon1:(NSArray *)icon1
{
	_icon1 = icon1;
	[self refreshUI];
}

-(void)setBackgroundColor1:(UIColor *)backgroundColor1
{
	_backgroundColor1 = backgroundColor1;
	[self refreshUI];
}

-(void)setShapeTintColor1:(UIColor *)shapeTintColor1
{
	_shapeTintColor1 = shapeTintColor1;
	[self refreshUI];
}

@end
