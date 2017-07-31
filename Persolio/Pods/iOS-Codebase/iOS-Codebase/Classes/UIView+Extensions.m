//
//  UIView+Extensions.m
//  Kababchi
//
//  Created by hAmidReza on 7/3/17.
//  Copyright © 2017 innovian. All rights reserved.
//

#import "UIView+Extensions.h"

@implementation UIView (Extensions)

-(id)getNearestVC
{
	UIView* nextView = self.superview;
	while (![nextView.nextResponder isKindOfClass:[UIViewController class]] && nextView != nil)
	{
		nextView = nextView.superview;
	}
	
	return nextView.nextResponder;
}

-(id)getNearestVCByClass:(NSString*)class_str
{
	UIView* nextView = self.superview;
	while (![nextView.nextResponder isKindOfClass:NSClassFromString(class_str)] && nextView != nil)
	{
		nextView = nextView.superview;
	}
	
	return nextView.nextResponder;
}

-(id)getNearestParentViewByClass:(NSString*)class_str
{
	UIView* parent = self.superview;
	while (![parent isKindOfClass:NSClassFromString(class_str)] && parent != nil)
		parent = parent.superview;
	
	return parent;
}

@end
