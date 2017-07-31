//
//  MyVector.m
//  MyVector
//
//  Created by hAmidReza on 6/25/17.
//  Copyright © 2017 innovian. All rights reserved.
//

//http://wwwimages.adobe.com/content/dam/Adobe/en/devnet/pdf/illustrator/scripting/illustrator_scripting_reference_javascript_cs5.pdf

#import "MyVector.h"
#import "MyLinearGradientLayer.h"
#import "MyRadialGradientLayer.h"

#define CGPointFromArray(x) CGPointMake([x[0] floatValue], [x[1] floatValue])
#define CGSizeFromArray(x) CGSizeMake([x[0] floatValue], [x[1] floatValue])
#define RGBAColor(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

@interface MyVector ()
{
	CALayer* mainLayer;
}
@property (retain, nonatomic) NSDictionary* vector;

@end

@implementation MyVector

-(instancetype)initWithVector:(NSDictionary*)vector
{
	self = [super init];
	if (self)
	{
		//		CGFloat f = [MyVector scaleToAspectFitRect:CGRectMake(0, 0, 50, 50) inRect:CGRectMake(100, 100, 200, 200)];
		mainLayer = [CALayer new];
		[self.layer addSublayer:mainLayer];
		_vector = vector;
		[self draw];
	}
	return self;
}

-(void)draw
{
	CGSize size = [self getArtboardSize];
	for (NSDictionary* pathDesc in _vector[@"group"]) {
		NSString* fillType = pathDesc[@"fill"][@"type"];
		if ([fillType isEqualToString:@"fill"])
		{
			CAShapeLayer* shapeLayer = [CAShapeLayer new];
			shapeLayer.path = [MyVector bezierPathWithDescArray:pathDesc[@"path"]].CGPath;
			[mainLayer addSublayer:shapeLayer];
			shapeLayer.fillColor = [MyVector UIColorFromArray:pathDesc[@"fill"][@"colors"]].CGColor;
			shapeLayer.zPosition = [pathDesc[@"zOrder"] floatValue];
			shapeLayer.opacity = [pathDesc[@"opacity"] floatValue];
			shapeLayer.compositingFilter = [self getBlendModeForPath:pathDesc];
			
		}
		else if ([fillType isEqualToString:@"linearGradient"])
		{
			CAShapeLayer* maskLayer = [CAShapeLayer new];
			maskLayer.path = [MyVector bezierPathWithDescArray:pathDesc[@"path"]].CGPath;
			MyLinearGradientLayer* gradLayer = [MyLinearGradientLayer new];
			gradLayer.frame = CGRectMake(0, 0, size.width, size.height);
			gradLayer.colors = [MyVector colorArrayFromArray:pathDesc[@"fill"][@"colors"]];
			gradLayer.locations = pathDesc[@"fill"][@"locations"];
			CGPoint actualStartPint = CGPointFromArray(pathDesc[@"fill"][@"startPoint"]);
			gradLayer.startPoint = CGPointMake(actualStartPint.x / size.width, actualStartPint.y / size.height);
			CGPoint actualEndPint = CGPointFromArray(pathDesc[@"fill"][@"endPoint"]);
			gradLayer.endPoint = CGPointMake(actualEndPint.x / size.width, actualEndPint.y / size.height);
			gradLayer.mask = maskLayer;
			[mainLayer addSublayer:gradLayer];
			gradLayer.zPosition = [pathDesc[@"zOrder"] floatValue];
			
			gradLayer.compositingFilter = [self getBlendModeForPath:pathDesc];
			
			
		}
		else if ([fillType isEqualToString:@"radialGradient"])
		{
			CAShapeLayer* maskLayer = [CAShapeLayer new];
			maskLayer.path = [MyVector bezierPathWithDescArray:pathDesc[@"path"]].CGPath;
			MyRadialGradientLayer* gradLayer = [MyRadialGradientLayer new];
			CGPoint actualCenterPiont = CGPointFromArray(pathDesc[@"fill"][@"center"]);
			gradLayer.centerPoint = CGPointMake(actualCenterPiont.x / size.width, actualCenterPiont.y / size.height);
			gradLayer.radius = [pathDesc[@"fill"][@"radius"] floatValue];
			gradLayer.locations = pathDesc[@"fill"][@"locations"];
			gradLayer.colors = [MyVector colorArrayFromArray:pathDesc[@"fill"][@"colors"]];
			gradLayer.frame = CGRectMake(0, 0, size.width, size.height);
			gradLayer.mask = maskLayer;
			[mainLayer addSublayer:gradLayer];
			gradLayer.zPosition = [pathDesc[@"zOrder"] floatValue];
			gradLayer.opacity = [pathDesc[@"opacity"] floatValue];
			
			gradLayer.compositingFilter = [self getBlendModeForPath:pathDesc];
		}
	}
}

-(NSString*)getBlendModeForPath:(NSDictionary*)pathDesc
{
	if ([pathDesc[@"mode"] isEqualToString:@"normal"])
		return nil;
	else if ([pathDesc[@"mode"] isEqualToString:@"multiply"])
		return @"multiplyBlendMode";
	else if ([pathDesc[@"mode"] isEqualToString:@"colorburn"])
		return @"ColorBurnBlendMode";
	else if ([pathDesc[@"mode"] isEqualToString:@"colorblend"])
		return @"ColorBlendMode";
	else if ([pathDesc[@"mode"] isEqualToString:@"colordodge"])
		return @"ColorDodgeBlendMode";
	else if ([pathDesc[@"mode"] isEqualToString:@"darken"])
		return @"DarkenBlendMode";
	else if ([pathDesc[@"mode"] isEqualToString:@"difference"])
		return @"differenceBlendMode";
	else if ([pathDesc[@"mode"] isEqualToString:@"exclusion"])
		return @"exclusionBlendMode";
	else if ([pathDesc[@"mode"] isEqualToString:@"hardlight"])
		return @"hardLightBlendMode";
	else if ([pathDesc[@"mode"] isEqualToString:@"hue"])
		return @"hueBlendMode";
	else if ([pathDesc[@"mode"] isEqualToString:@"lighten"])
		return @"lightenBlendMode";
	else if ([pathDesc[@"mode"] isEqualToString:@"luminosity"])
		return @"luminosityBlendMode";
	else if ([pathDesc[@"mode"] isEqualToString:@"overlay"])
		return @"overlayBlendMode";
	else if ([pathDesc[@"mode"] isEqualToString:@"saturationblend"])
		return @"saturationBlendMode";
	else if ([pathDesc[@"mode"] isEqualToString:@"screen"])
		return @"screenBlendMode";
	else if ([pathDesc[@"mode"] isEqualToString:@"softlight"])
		return @"softLightBlendMode";
	else
		return nil;
	
}

-(void)setFrame:(CGRect)frame
{
	[super setFrame:frame];
	
	
}

-(void)layoutSubviews
{
	[super layoutSubviews];
	
	CGRect frame = self.frame;
	
	CGSize artboardSize = [self getArtboardSize];
	CGRect originalRect = CGRectMake(0, 0, artboardSize.width, artboardSize.height);
	CGFloat scale = [MyVector scaleToAspectFitRect:originalRect inRect:frame];
	
	CAAnimation* anim = [self.layer animationForKey:@"bounds.size"];
	BOOL animated = anim ? true : false;
	
	if (animated)
	{
		CABasicAnimation* an = [CABasicAnimation animationWithKeyPath:@"transform"];
		an.timingFunction = anim.timingFunction;
		an.duration = anim.duration;
		an.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(scale, scale,  1)];
		an.fillMode = kCAFillModeForwards;
		an.removedOnCompletion = false;
		[mainLayer addAnimation:an forKey:@"transform"];
	}
	else
	{
		[CATransaction begin];
		[CATransaction setDisableActions: YES];
		mainLayer.affineTransform = CGAffineTransformScale(CGAffineTransformIdentity, scale, scale);
		[CATransaction commit];
	}
}

-(CGSize)getArtboardSize
{
	return CGSizeFromArray(_vector[@"size"]);
}

+(NSArray*)colorArrayFromArray:(NSArray*)arr
{
	NSMutableArray* result = [NSMutableArray new];
	for (NSArray* colorDesc in arr) {
		[result addObject:(id)RGBAColor([colorDesc[0] floatValue], [colorDesc[1] floatValue], [colorDesc[2] floatValue], [colorDesc[3] floatValue] / 100).CGColor];
	}
	
	return result;
}

+(UIBezierPath*)bezierPathWithDescArray:(NSArray*)array
{
	UIBezierPath* path = [UIBezierPath bezierPath];
	for (NSArray* arr in array) {
		NSString* cmd = arr[0];
		if ([cmd isEqualToString:@"m"]) //move to point
			[path moveToPoint:CGPointMake([arr[1] floatValue], [arr[2] floatValue])];
		else if ([cmd isEqualToString:@"l"]) //line
			[path addLineToPoint:CGPointMake([arr[1] floatValue], [arr[2] floatValue])];
		else if ([cmd isEqualToString:@"c"]) //curve
			[path addCurveToPoint:CGPointMake([arr[1] floatValue], [arr[2] floatValue]) controlPoint1:CGPointMake([arr[3] floatValue], [arr[4] floatValue]) controlPoint2:CGPointMake([arr[5] floatValue], [arr[6] floatValue])];
	}
	
	[path closePath];
	
	return path;
}

+(UIColor*)UIColorFromArray:(NSArray*)arr
{
	return RGBAColor([arr[0] floatValue], [arr[1] floatValue], [arr[2] floatValue], [arr[3] floatValue]/100);
}

+(CGFloat)scaleToAspectFitRect:(CGRect)rfit inRect:(CGRect)rtarget
{
	CGFloat s = CGRectGetWidth(rtarget) / CGRectGetWidth(rfit);
	if (CGRectGetHeight(rfit) * s <= CGRectGetHeight(rtarget)) {
		return s;
	}
	return CGRectGetHeight(rtarget) / CGRectGetHeight(rfit);
}

@end
