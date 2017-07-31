//
//  dottedHairline.m
//  Kababchi
//
//  Created by hAmidReza on 5/14/17.
//  Copyright © 2017 innovian. All rights reserved.
//

#import "DottedHairLine.h"
#import "Codebase_definitions.h"

@implementation DottedHairLine

static CGFloat const kDashedBorderWidth     = (2.0f);
static CGFloat const kDashedPhase           = (0.0f);
static CGFloat const kDashedLinesLength[]   = {6.0f, 6.0f};
static size_t const kDashedCount            = (2.0f);

-(void)initialize
{
	self.opaque = NO;
}

- (void)drawRect:(CGRect)rect
{
	[super drawRect:rect];
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	CGContextSetLineCap(context, kCGLineCapRound);
	
	if (_num_ok1(_borderWidth))
		CGContextSetLineWidth(context, [_borderWidth floatValue]);
	else
		CGContextSetLineWidth(context, kDashedBorderWidth);
	
	if (_color)
		CGContextSetStrokeColorWithColor(context, _color.CGColor);
	else
		CGContextSetStrokeColorWithColor(context, RGBAColor(0, 0, 0, .2).CGColor);
	
	if (_num_ok1(_length1) && _num_ok1(_length2))
	{
		CGFloat linesLength[] = {[_length1 floatValue], [_length2 floatValue]};
		CGContextSetLineDash(context, kDashedPhase, linesLength, kDashedCount);
	}
	else
		CGContextSetLineDash(context, kDashedPhase, kDashedLinesLength, kDashedCount);
	
	CGContextMoveToPoint(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
	CGContextAddLineToPoint(context, CGRectGetMaxX(rect), CGRectGetMinY(rect));
	
	CGContextStrokePath(context);
}

@end
