//
//  _HomeBaseVC.h
//  mactehrannew
//
//  Created by hAmidReza on 4/30/17.
//  Copyright © 2017 archibits. All rights reserved.
// salam chetori

#import <UIKit/UIKit.h>

@interface _HomeBaseVC : UIViewController

@property (retain, nonatomic) UIVisualEffectView* visualEffectView;
-(void)updateNavBarBackDropView:(bool)animated;
-(CGFloat)NavBarBackDropViewHeight;
-(void)initialize;
//-(void)startPageLoading;
//-(void)stopPageLoading;
-(void)_reloadPath:(NSString*)path callback:(void (^)(id))callback andError:(void (^)(NSError *))errorCallback;
//-(void)showGeneralErrorWithMessage:(NSString*)msg;
//-(void)dismissErrors;
-(void)reload;

@property (assign, nonatomic) bool manuallyHideLoadingViewOnSuccessfulReload;
@property (assign, nonatomic) bool noPageLoading;
@property (assign, nonatomic) bool reloadDone;


/**
 puts a dark gradient on top, so the navigation items will be visible even during the page loading. default: false.
 */
@property (assign, nonatomic) bool putGradientWhenLoading;

/**
 used if putGradientWhenLoading = true. the gradient height; default: 80
 */
@property (retain, nonatomic) NSNumber* loadingGradientHeight;


/**
 used if putGradientWhenLoading = true. array of uicolors for gradient view on page loading. (from top to bottom). default: @[rgba(0, 0, 0, .5), rgba(0, 0, 0, 0)];
 */
@property (retain, nonatomic) NSArray* loadingGradientColors;


/**
 default: false.
 */
@property (assign, nonatomic) bool hideNavBarOnLoading;

/**
 default: true. it will hide the top header visual effect view during the page loading.
 */
@property (assign, nonatomic) bool hideVisualEffectViewOnLoading;

/**
 when the page loading is shown, sets this backgroundcolor for it. default: white
 */
@property (retain, nonatomic) UIColor* loadingViewBackgroundColor;


/**
 override this method if you want other visual effects.
 default: [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]

 @return the desired visual effect e.g. [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]
 */
-(UIVisualEffect*)effectForVisualEffectView;

/**
 the color of the loading indicator. default: white
 */
@property (retain, nonatomic) UIColor* loadingViewColor;

-(void)hidePageLoadingAnimated:(BOOL)animated completion:(void(^)())completion;
-(void)showPageLoadingAnimated:(BOOL)animated completion:(void(^)())completion;


+(void)setLoadingViewProviderBlock:(UIView* (^)(UIView* superview))loadingViewProviderBlock;
@end
