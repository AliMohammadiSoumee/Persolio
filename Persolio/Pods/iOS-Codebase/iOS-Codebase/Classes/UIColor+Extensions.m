//
//  UIColor+colorWithHex.m
//  macTehran
//
//  Created by Hamidreza Vaklian on 1/18/16.
//  Copyright © 2016 Hamidreza Vaklian. All rights reserved.
//

#import "UIColor+Extensions.h"

@implementation UIColor(Extensions)

-(rgb)get_rgb
{
	rgb result;
	[self getRed:&result.r green:&result.g blue:&result.b alpha:NULL];
	return result;
}

// takes @"#123456"
+ (UIColor *)colorWithHexString:(NSString *)str {
    if (!str || !str.length)
        return [UIColor blackColor];
    const char *cStr = [str cStringUsingEncoding:NSASCIIStringEncoding];
    long x = strtol(cStr+1, NULL, 16);
    return [UIColor colorWithHex:(UInt32)x];
}

// takes 0x123456
+ (UIColor *)colorWithHex:(UInt32)col {
    unsigned char r, g, b;
    b = col & 0xFF;
    g = (col >> 8) & 0xFF;
    r = (col >> 16) & 0xFF;
    return [UIColor colorWithRed:(float)r/255.0f green:(float)g/255.0f blue:(float)b/255.0f alpha:1];
}

-(bool)isBright
{
    CGFloat r,g,b;
    [self getRed:&r green:&g blue:&b alpha:nil];
    CGFloat l = (MAX(MAX(r,g), b) + MIN(MIN(r, g), b))/2;
    if (l >= .5)
        return true;
    else return false;
}

-(UIColor*)mixWithColor:(UIColor*)color mixAlpha:(BOOL)mixAlpha //a1 will be used if mixAlpha = false
{
	CGFloat r1;
	CGFloat r2;
	CGFloat g1;
	CGFloat g2;
	CGFloat b1;
	CGFloat b2;
	CGFloat a1;
	CGFloat a2;
	[self getRed:&r1 green:&g1 blue:&b1 alpha:&a1];
	[color getRed:&r2 green:&g2 blue:&b2 alpha:&a2];
	
	return [UIColor colorWithRed:(r1+r2)/2.0f green:(g1+g2)/2.0f blue:(b1+b2)/2.0f alpha:mixAlpha ? (a1+a2)/2.0f : a1];
}

@end
