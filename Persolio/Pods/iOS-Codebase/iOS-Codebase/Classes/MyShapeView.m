//
//  MyShapeView.m
//  Prediscore
//
//  Created by Hamidreza Vaklian on 7/5/16.
//  Copyright © 2016 pxlmind. All rights reserved.
//

#import "MyShapeView.h"
#import "helper.h"
#import "Codebase_definitions.h"

@interface MyShapeView ()
{
    CAShapeLayer* shapeLayer;
}
@end

@implementation MyShapeView

-(instancetype)initWithShapeDesc:(NSArray*)desc andShapeTintColor:(UIColor*)shapeTintColor
{
    self = [super init];
    if (self)
    {
        _shapeDesc = desc;
        _shapeTintColor = shapeTintColor;
        [self initialize];
    }
    return self;
}

-(instancetype)init
{
    self = [super init];
    if (self)
    {
        [self initialize];
    }
    return self;
}

-(void)awakeFromNib
{
	[super awakeFromNib];
    [self initialize];
}

-(void)initialize
{
    shapeLayer = [CAShapeLayer new];
    shapeLayer.fillColor = _shapeTintColor ? _shapeTintColor.CGColor : [UIColor whiteColor].CGColor;
//    shapeLayer.strokeColor = [UIColor clearColor].CGColor;
//    shapeLayer.lineWidth = 0;
    self.userInteractionEnabled = NO;
    [self.layer addSublayer:shapeLayer];
	
	
}

-(void)setShadowColor:(UIColor *)shadowColor
{
	_shadowColor = shadowColor;
	shapeLayer.shadowColor = shadowColor.CGColor;
}

-(void)setShadowOpacity:(float)shadowOpacity
{
	_shadowOpacity = shadowOpacity;
	shapeLayer.shadowOpacity= shadowOpacity;
}

-(void)setShadowOffset:(CGSize)shadowOffset
{
	_shadowOffset = shadowOffset;
	shapeLayer.shadowOffset = shadowOffset;
}

-(void)setShadowRadius:(CGFloat)shadowRadius
{
	_shadowRadius = shadowRadius;
		shapeLayer.shadowRadius = shadowRadius;
}

-(void)setShapeTintColor:(UIColor *)shapeTintColor
{
    _shapeTintColor = shapeTintColor;
    shapeLayer.fillColor = _shapeTintColor ? _shapeTintColor.CGColor : [UIColor whiteColor].CGColor;
	[self setNeedsLayout];
}

-(void)setShapeDesc:(NSArray *)shapeDesc
{
    _shapeDesc = shapeDesc;
    [self setNeedsLayout];
}

-(void)setPath:(UIBezierPath *)path
{
    _path = path;
    _shapeDesc = nil;
    shapeLayer.path = path.CGPath;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    if (_shapeDesc)
	{
		if (_num_ok1(_rotation))
			shapeLayer.path = [MyShapeView path:[helper bezierPathWithDescArray:_shapeDesc andWidth:self.frame.size.width].CGPath rotatedByDegrees:[_rotation floatValue]];
		else
			shapeLayer.path = [helper bezierPathWithDescArray:_shapeDesc andWidth:self.frame.size.width].CGPath;
	}
}

+(CGPathRef)path:(CGPathRef)path rotatedByDegrees:(CGFloat)angle {
	
	CGRect bounds = CGPathGetBoundingBox(path); // might want to use CGPathGetPathBoundingBox
	CGPoint center = CGPointMake(CGRectGetMidX(bounds), CGRectGetMidY(bounds));
	CGAffineTransform transform = CGAffineTransformIdentity;
	transform = CGAffineTransformTranslate(transform, center.x, center.y);
	transform = CGAffineTransformRotate(transform, DEG2RAD(angle));
	transform = CGAffineTransformTranslate(transform, -center.x, -center.y);
	return CGPathCreateCopyByTransformingPath(path, &transform);
}

@end

