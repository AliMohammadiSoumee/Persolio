//
//  _HomeBaseNavBar.m
//  Kababchi
//
//  Created by hAmidReza on 7/20/17.
//  Copyright © 2017 innovian. All rights reserved.
//

#import "_HomeBaseNavBar.h"

@implementation _HomeBaseNavBar

-(instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self)
	{
		[self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
		self.shadowImage = [UIImage new];
		self.translucent = YES;
		self.tintColor = [UIColor whiteColor];
		
//		self.titleTextAttributes = ;
		
		_leftButton = [[MyShapeButton alloc] initWithShapeDesc:nil andShapeTintColor:[UIColor whiteColor] andButtonClick:nil];
		_leftButton.shapeMargins = UIEdgeInsetsMake(11, 11, 11, 11);
		[self addSubview:_leftButton];
		
		_rightButton = [[MyShapeButton alloc] initWithShapeDesc:nil andShapeTintColor:[UIColor whiteColor] andButtonClick:nil];
		_rightButton.shapeMargins = UIEdgeInsetsMake(11, 11, 11, 11);
		[self addSubview:_rightButton];
	}
	return self;
}

-(void)setTheTitleTextAttributes:(NSDictionary *)theTitleTextAttributes
{
	self.titleTextAttributes = theTitleTextAttributes;
}

-(NSDictionary *)theTitleTextAttributes
{
	return self.titleTextAttributes;
}

//-(void)setTheDelegate:(id<_HomeBaseNavBarDelegate>)theDelegate
//{
//	_theDelegate = theDelegate;
//	if ([_theDelegate respondsToSelector:@selector(HomeBaseNavBarTitleTextAttributes)])
//		self.titleTextAttributes = [_theDelegate HomeBaseNavBarTitleTextAttributes];
//}

-(void)layoutSubviews
{
	[super layoutSubviews];
	
	_leftButton.frame = CGRectMake(0, 0, 44, 44);
	_rightButton.frame = CGRectMake(self.frame.size.width - 44, 0, 44, 44);
}

@end
