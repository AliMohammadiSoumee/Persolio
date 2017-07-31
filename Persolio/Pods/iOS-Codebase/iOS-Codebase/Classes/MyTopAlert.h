//
//  MyTopAlert.h
//  mactehrannew
//
//  Created by hAmidReza on 6/5/17.
//  Copyright © 2017 archibits. All rights reserved.
//

#import "_viewBase.h"
typedef enum : NSUInteger {
	MyTopAlertTypeError,
	MyTopAlertTypeSuccess,
	MyTopAlertTypeInfo,
	MyTopAlertTypeWarning,
} MyTopAlertType;

@interface MyTopAlert : _viewBase

+(void)presentAlertType:(MyTopAlertType)type title:(NSString*)title message:(NSString*)message onViewController:(UIViewController*)vc alignWithTopOfView:(UIView*)alignTopWithView;
+(void)presentAlertType:(MyTopAlertType)type title:(NSString*)title message:(NSString*)message onViewController:(UIViewController*)vc alignWithTopOfView:(UIView*)alignTopWithView actionView:(UIView *)actionView;
+(void)presentAlertType:(MyTopAlertType)type title:(NSString*)title message:(NSString*)message onViewController:(UIViewController*)vc;
+(void)presentAlertType:(MyTopAlertType)type title:(NSString*)title message:(NSString*)message onViewController:(UIViewController*)vc actionView:(UIView*)actionView;

@end
