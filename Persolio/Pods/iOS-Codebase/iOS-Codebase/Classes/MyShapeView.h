//
//  MyShapeView.h
//  Prediscore
//
//  Created by Hamidreza Vaklian on 7/5/16.
//  Copyright © 2016 pxlmind. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyShapeView : UIView

-(instancetype)initWithShapeDesc:(NSArray*)desc andShapeTintColor:(UIColor*)shapeTintColor;
@property (retain, nonatomic) UIColor* shapeTintColor;
@property (retain, nonatomic) NSArray* shapeDesc;
@property (retain, nonatomic) UIBezierPath* path;

@property (retain, nonatomic) NSNumber* rotation; //degress

@property (retain, nonatomic) UIColor* shadowColor;
@property (assign, nonatomic) float shadowOpacity;
@property (assign, nonatomic) CGSize shadowOffset;
@property (assign, nonatomic) CGFloat shadowRadius;

@end
