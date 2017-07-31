//
//  MyBoredredFlatButton.m
//  mactehrannew
//
//  Created by hAmidReza on 5/29/17.
//  Copyright © 2017 archibits. All rights reserved.
//

#import "MyFlatButton.h"
#import "UIView+SDCAutoLayout.h"
#import "Codebase_definitions.h"

@interface MyFlatButton ()



@end

@implementation MyFlatButton

-(void)setEnabled:(BOOL)enabled
{
	[self setEnabled:enabled animated:NO];
}

-(void)setEnabled:(BOOL)enabled animated:(BOOL)animated
{
	super.enabled = enabled;
	
	[UIView animateWithDuration:animated ? .3 : 0 animations:^{
		
		
		if (_num_ok1(_disabled_alpha))
			self.alpha = enabled ? 1.0 : [_disabled_alpha floatValue];
		else
			self.alpha = enabled ? 1.0 : .6;
	}];
	self.userInteractionEnabled = enabled;
}

-(UILabel *)titleLabel
{
	NSAssert(false, @"MyFlatbutton: USE theTitleLabel instead of titleLabel");
	return nil;
}

-(void)initialize
{
	self.exclusiveTouch = YES;
	
	_theTitleLabel = [UILabel new];
	_theTitleLabel.textColor = RGBAColor(240, 240, 240, 1.0f);
	_theTitleLabel.font = [UIFont fontWithName:@"IRANSansMobile" size:16];
	_theTitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
	[self addSubview:_theTitleLabel];
	[_theTitleLabel sdc_horizontallyCenterInSuperview];
	[_theTitleLabel sdc_verticallyCenterInSuperviewWithOffset:1];
	
	self.layer.cornerRadius = 3;
	self.layer.borderColor = RGBAColor(140, 140, 140, 1).CGColor;
	self.layer.borderWidth = 1;
}

-(void)setBorderColor:(UIColor *)borderColor
{
	self.layer.borderColor = [borderColor CGColor];
}

-(UIColor *)borderColor
{
	return [UIColor colorWithCGColor:self.layer.borderColor];
}

-(void)setBorderWidth:(CGFloat)borderWidth
{
	self.layer.borderWidth = borderWidth;
}

-(CGFloat)borderWidth
{
	return self.layer.borderWidth;
}

-(void)setCornerRadius:(CGFloat)cornerRadius
{
	self.layer.cornerRadius = cornerRadius;
}

-(CGFloat)cornerRadius
{
	return self.layer.cornerRadius;
}

@end
