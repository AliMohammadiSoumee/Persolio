//
//  MyTopAlert.m
//  mactehrannew
//
//  Created by hAmidReza on 6/5/17.
//  Copyright © 2017 archibits. All rights reserved.
//

#import "MyTopAlert.h"
#import "Codebase.h"
//#import "MyShapeButton.h"
//#import "UIView+SDCAutoLayout.h"
//#import "Codebase_definitions.h"
//#import "MyShapeView.h"
//#import "_viewBase.h"

#define correspondingTopAlertObjectKey @"MyTopAlert"

@interface MyTopAlert_smallCap : _viewBase
{
	CAShapeLayer* shape;
}

@property (retain, nonatomic) UIColor* color;
@end

@implementation MyTopAlert_smallCap

-(void)initialize
{
	shape = [CAShapeLayer new];
	[self.layer addSublayer:shape];
	
}

-(void)layoutSubviews
{
	[super layoutSubviews];
	
	UIBezierPath* path = [UIBezierPath new];
	[path moveToPoint:CGPointMake(CGRectGetMinX(self.bounds), CGRectGetMidY(self.bounds))];
	[path addLineToPoint:CGPointMake(CGRectGetMaxX(self.bounds), CGRectGetMidY(self.bounds))];
	[path addLineToPoint:CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMaxY(self.bounds))];
	[path closePath];
	shape.path = path.CGPath;
}

-(void)setColor:(UIColor *)color
{
	shape.fillColor = color.CGColor;
}

-(UIColor *)color
{
	return [UIColor colorWithCGColor:shape.fillColor];
}

@end

#define kAppearanceAnimationDuration .4
#define kMyTopAlertDuration         5
#define kActionViewBottomMargin        20
#define kError_upperTirangleColor rgba(222, 94, 75, 1.000)
#define kError_lowerTirangleColor rgba(212, 90, 67, 1.000)
#define kWarning_upperTirangleColor rgba(253, 164, 46, 1.000)
#define kWarning_lowerTirangleColor rgba(243, 156, 18, 1.000)


@interface MyTopAlert ()
{
	CAShapeLayer* upperTriangle;
	CAShapeLayer* lowerTriangle;
	MyShapeButton* icon;
	NSTimer* dismissTimer;
}

@property (retain, nonatomic) UIView* contentView;
@property (retain, nonatomic) UIView* actionHolder;
@property (retain, nonatomic) UILabel* titleLabel;
@property (retain, nonatomic) UILabel* messageLabel;
@property (retain, nonatomic) MyTopAlert_smallCap* smallCap;

@property (weak, nonatomic) UIViewController* vcRef;

@property (retain, nonatomic) NSLayoutConstraint* heightCon;

-(void)configureWithType:(MyTopAlertType)type title:(NSString*)title message:(NSString*)message andVC:(UIViewController*)vc;

@end

@implementation MyTopAlert

-(void)initialize
{
	self.clipsToBounds = YES;
	
	_heightCon = [self sdc_setMaximumHeight:0];
	
	_smallCap = [MyTopAlert_smallCap new];
	_smallCap.color = [UIColor greenColor];
	_smallCap.translatesAutoresizingMaskIntoConstraints = NO;
	[self addSubview:_smallCap];
	[_smallCap sdc_pinCubicSize:20];
	[_smallCap sdc_alignHorizontalCenterWithView:self];
	[_smallCap sdc_alignEdge:UIRectEdgeTop withEdge:UIRectEdgeBottom ofView:self inset:-20];
	
	_contentView = [UIView new];
	_contentView.translatesAutoresizingMaskIntoConstraints = NO;
	[self addSubview:_contentView];
	[_contentView sdc_alignEdgesWithSuperview:UIRectEdgeAll ^ UIRectEdgeBottom];
	[UIView sdc_priority:UILayoutPriorityDefaultLow block:^{
		[_contentView sdc_alignBottomEdgeWithSuperviewMargin:10];
	}];
	
	upperTriangle = [CAShapeLayer new];
	[_contentView.layer addSublayer:upperTriangle];
	
	lowerTriangle = [CAShapeLayer new];
	[_contentView.layer addSublayer:lowerTriangle];
	
	icon = [[MyShapeButton alloc] initWithShapeDesc:nil andShapeTintColor:[UIColor whiteColor] andButtonClick:nil];
	icon.setsCornerRadiusForShapeView = NO;
	icon.layer.cornerRadius = 40.0f;
	icon.shapeMargins = UIEdgeInsetsMake(25, 25, 25, 25);
	icon.layer.borderColor = [UIColor whiteColor].CGColor;
	icon.layer.borderWidth = 3;
	icon.translatesAutoresizingMaskIntoConstraints = NO;
	[_contentView addSubview:icon];
	[icon sdc_pinCubicSize:80];
	[icon sdc_alignTopEdgeWithSuperviewMargin:30];
	[icon sdc_horizontallyCenterInSuperview];
	
	_titleLabel = [UILabel new];
	_titleLabel.textColor = [UIColor whiteColor];
	_titleLabel.font = [UIFont fontWithName:@"IRANSansMobile-Bold" size:18];
	_titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
	[_contentView addSubview:_titleLabel];
	[_titleLabel sdc_alignEdge:UIRectEdgeTop withEdge:UIRectEdgeBottom ofView:icon inset:20];
	[_titleLabel sdc_horizontallyCenterInSuperview];
	
	_messageLabel = [UILabel new];
	_messageLabel.textColor = [UIColor whiteColor];
	_messageLabel.textAlignment = NSTextAlignmentCenter;
	_messageLabel.numberOfLines = 0;
	_messageLabel.font = [UIFont fontWithName:@"IRANSansMobile-Light" size:14];
	_messageLabel.translatesAutoresizingMaskIntoConstraints = NO;
	[_contentView addSubview:_messageLabel];
	[_messageLabel sdc_alignSideEdgesWithSuperviewInset:40];
	[_messageLabel sdc_alignEdge:UIRectEdgeTop withEdge:UIRectEdgeBottom ofView:_titleLabel inset:5];
	
	//	[_messageLabel sdc_alignBottomEdgeWithSuperviewMargin:25];
	
	_actionHolder = [UIView new];
	_actionHolder.translatesAutoresizingMaskIntoConstraints = NO;
	[_contentView addSubview:_actionHolder];
	[_actionHolder sdc_alignEdge:UIRectEdgeTop withEdge:UIRectEdgeBottom ofView:_messageLabel inset:10];
	[_actionHolder sdc_horizontallyCenterInSuperview];
	[_actionHolder sdc_alignBottomEdgeWithSuperviewMargin:0];
	
}

-(void)layoutSubviews
{
	[super layoutSubviews];
	
	UIBezierPath* path = [UIBezierPath new];
	[path moveToPoint:CGPointMake(CGRectGetMinX(_contentView.bounds), CGRectGetMinY(_contentView.bounds))];
	[path addLineToPoint:CGPointMake(CGRectGetMaxX(_contentView.bounds), CGRectGetMinY(_contentView.bounds))];
	[path addLineToPoint:CGPointMake(CGRectGetMinX(_contentView.bounds), CGRectGetMaxY(_contentView.bounds))];
	[path closePath];
	upperTriangle.path = path.CGPath;
	
	UIBezierPath* path2 = [UIBezierPath new];
	[path2 moveToPoint:CGPointMake(CGRectGetMaxX(_contentView.bounds), CGRectGetMinY(_contentView.bounds))];
	[path2 addLineToPoint:CGPointMake(CGRectGetMaxX(_contentView.bounds), CGRectGetMaxY(_contentView.bounds))];
	[path2 addLineToPoint:CGPointMake(CGRectGetMinX(_contentView.bounds), CGRectGetMaxY(_contentView.bounds))];
	[path2 closePath];
	lowerTriangle.path = path2.CGPath;
}

-(void)configureWithType:(MyTopAlertType)type title:(NSString*)title message:(NSString*)message andVC:(UIViewController*)vc andActionView:(UIView*)action
{
	BOOL configTimer = YES;
	
	if ([vc dataObjectForKey:correspondingTopAlertObjectKey])
	{
		MyTopAlert* anotherAlert = [vc dataObjectForKey:correspondingTopAlertObjectKey];
		[anotherAlert hideAlertAnimated:YES];
		[_vcRef setDataObject:nil forKey:correspondingTopAlertObjectKey];
	}
	
	[vc setDataObject:self forKey:correspondingTopAlertObjectKey];
	
	if (type == MyTopAlertTypeError)
	{
		upperTriangle.fillColor = kError_upperTirangleColor.CGColor;
		lowerTriangle.fillColor = kError_lowerTirangleColor.CGColor;
		_smallCap.color = kError_lowerTirangleColor;
		
		_titleLabel.text = title;
		_messageLabel.text = message;
		_vcRef = vc;
		if (action)
		{
			action.translatesAutoresizingMaskIntoConstraints = NO;
			[_actionHolder addSubview:action];
			[action sdc_alignEdgesWithSuperview:UIRectEdgeAll insets:UIEdgeInsetsMake(0, 0, -kActionViewBottomMargin, 0)];
			configTimer = NO;
		}
		
		icon.shapeView.shapeDesc = __codebase_k_iconCrossHeavy();
	}
	else if (type == MyTopAlertTypeWarning)
	{
		upperTriangle.fillColor = kWarning_upperTirangleColor.CGColor;
		lowerTriangle.fillColor = kWarning_lowerTirangleColor.CGColor;
		_smallCap.color = kWarning_lowerTirangleColor;
		
		_titleLabel.text = title;
		_messageLabel.text = message;
		_vcRef = vc;
		if (action)
		{
			action.translatesAutoresizingMaskIntoConstraints = NO;
			[_actionHolder addSubview:action];
			[action sdc_alignEdgesWithSuperview:UIRectEdgeAll insets:UIEdgeInsetsMake(0, 0, -kActionViewBottomMargin, 0)];
			configTimer = NO;
			
		}
		
		icon.shapeView.shapeDesc = __codebase_k_iconWarning();
	}
	
	if (configTimer)
	{
		[NSTimer scheduledTimerWithTimeInterval:kMyTopAlertDuration repeats:NO block:^(NSTimer * _Nonnull timer) {
			[self hideAlertAnimated:YES];
			[_vcRef setDataObject:nil forKey:correspondingTopAlertObjectKey];
		}];
	}
}

-(void)hideAlertAnimated:(BOOL)animated
{
	_heightCon.constant = 0;
	[UIView animateWithDuration:animated ? kAppearanceAnimationDuration : 0 animations:^{
		[_vcRef.view layoutIfNeeded];
	} completion:^(BOOL finished) {
		[self removeFromSuperview];
	}];
}

-(void)showAlertAnimated:(BOOL)animated
{
	self.heightCon.constant = 10000;
	[UIView animateWithDuration:animated ? kAppearanceAnimationDuration : 0 animations:^{
		[_vcRef.view layoutIfNeeded];
	}];
}

+(void)presentAlertType:(MyTopAlertType)type title:(NSString*)title message:(NSString*)message onViewController:(UIViewController*)vc alignWithTopOfView:(UIView*)alignTopWithView
{
	[self presentAlertType:type title:title message:message onViewController:vc alignWithTopOfView:alignTopWithView actionView:nil];
}

+(void)presentAlertType:(MyTopAlertType)type title:(NSString*)title message:(NSString*)message onViewController:(UIViewController*)vc
{
	[self presentAlertType:type title:title message:message onViewController:vc actionView:nil];
}

+(void)presentAlertType:(MyTopAlertType)type title:(NSString*)title message:(NSString*)message onViewController:(UIViewController*)vc actionView:(UIView *)actionView
{
	[self presentAlertType:type title:title message:message onViewController:vc alignWithTopOfView:nil actionView:actionView];
}

+(void)presentAlertType:(MyTopAlertType)type title:(NSString*)title message:(NSString*)message onViewController:(UIViewController*)vc alignWithTopOfView:(UIView*)alignTopWithView actionView:(UIView *)actionView
{
	hapticNotiError;
	MyTopAlert* myTopAlert = [MyTopAlert new];
	[myTopAlert configureWithType:type title:title message:message andVC:vc andActionView:actionView];
	myTopAlert.translatesAutoresizingMaskIntoConstraints = NO;
	[vc.view addSubview:myTopAlert];
	[myTopAlert sdc_alignSideEdgesWithSuperviewInset:0];
	if (!alignTopWithView)
		[myTopAlert sdc_alignEdge:UIRectEdgeTop withEdge:UIRectEdgeTop ofView:vc.view];
	else
		[myTopAlert sdc_alignEdge:UIRectEdgeTop withEdge:UIRectEdgeTop ofView:alignTopWithView];
	[vc.view layoutIfNeeded];
	[myTopAlert showAlertAnimated:YES];
}

@end
