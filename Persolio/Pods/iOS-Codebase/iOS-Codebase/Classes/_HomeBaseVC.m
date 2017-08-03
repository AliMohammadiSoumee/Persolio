//
//  _HomeBaseVC.m
//  mactehrannew
//
//  Created by hAmidReza on 4/30/17.
//  Copyright © 2017 archibits. All rights reserved.
//

#import "_HomeBaseVC.h"
#import "myLoadingView.h"
#import "Codebase.h"
#import "Codebase_definitions.h"
#import "helper.h"

#define kAnimationsDuration .3

@interface _HomeBaseVC_View : _viewBase
{
	UIView* contentView;
}

-(void)_addSubview:(UIView*)view;

@end

@implementation _HomeBaseVC_View

-(void)initialize
{
	contentView = [UIView new];
	contentView.backgroundColor = [UIColor clearColor];
	contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	[super addSubview:contentView];
}

-(void)addSubview:(UIView *)view
{
	[contentView addSubview:view];
	//	[self sendSubviewToBack:contentView];
}

-(void)_addSubview:(UIView*)view
{
	[super addSubview:view];
}
@end

@interface _HomeBaseVC ()
{
	UIView* loadingView;
	UIView* generalErrorView;
	NSLayoutConstraint* visualEffectViewHeightCon;
}

@end

@implementation _HomeBaseVC

-(void)loadView
{
	_HomeBaseVC_View* view = [_HomeBaseVC_View new];
	self.view = view;
}

-(instancetype)init
{
	self = [super init];
	if (self)
		[self _initialize];
	return self;
}

-(void)_initialize
{
	_hideVisualEffectViewOnLoading = YES;
	[self initialize];
}

-(void)initialize
{
	
}

-(UIVisualEffect*)effectForVisualEffectView
{
	return nil;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	
	NSAssert(self.navigationController, @"_HomeBaseVC: navigationController is nil. Are you calling configureWithDictionary before pushing or presenting this view controller?!?");
	
	self.automaticallyAdjustsScrollViewInsets = NO;
	self.view.backgroundColor = [UIColor whiteColor];
	
	UIVisualEffect* effect = [self effectForVisualEffectView];
	if (!effect)
		effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
	_visualEffectView = [[UIVisualEffectView alloc] initWithEffect:effect];
	_visualEffectView.translatesAutoresizingMaskIntoConstraints = NO;
	_HomeBaseVC_View* v = (_HomeBaseVC_View*)self.view;
	[v _addSubview:_visualEffectView];
	[_visualEffectView sdc_alignEdgesWithSuperview:UIRectEdgeAll ^ UIRectEdgeBottom];
	visualEffectViewHeightCon = [_visualEffectView sdc_pinHeight:[self NavBarBackDropViewHeight]];
	//
	if (self.navigationController.viewControllers.count > 1)
	{
		_defineWeakSelf;
		UIBarButtonItem* item = [helper shapeBarButtonWithConf:^(MyShapeButton *button) {
			button.shapeView.shapeDesc = k_iconLeftArrow();
			button.shapeMargins = UIEdgeInsetsMake(15, 15, 15, 15);
		} andCallback:^{
			[weakSelf.navigationController popViewControllerAnimated:YES];
		}];
		
		UIView* v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 30)];
		UIBarButtonItem* leftSpacer = [[UIBarButtonItem alloc] initWithCustomView:v];
		self.navigationItem.leftBarButtonItems = @[leftSpacer, item];
	}
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceOrientationDidChange:) name:UIDeviceOrientationDidChangeNotification object: nil];
}

- (void)deviceOrientationDidChange:(NSNotification *)notification {
	//	[self updateNavBarBackDropView:YES];
}

static UIView* (^loadingViewProviderBlock)(UIView* superview);
+(void)setLoadingViewProviderBlock:(UIView* (^)(UIView* superview))_loadingViewProviderBlock;
{
	loadingViewProviderBlock = _loadingViewProviderBlock;
}

-(void)showPageLoadingAnimated:(BOOL)animated completion:(void(^)())completion
{
	if (!loadingView)
	{
		if (_hideVisualEffectViewOnLoading)
			_visualEffectView.alpha = 0;
		
		//		self.navigationController.navigationBar.alpha = 0;
		if (_hideNavBarOnLoading)
			[self.navigationController setNavigationBarHidden:YES];
		
		loadingView = [UIView new];
		loadingView.backgroundColor = _loadingViewBackgroundColor ? _loadingViewBackgroundColor : [UIColor whiteColor];
		[loadingView setTranslatesAutoresizingMaskIntoConstraints:NO];
		[self.view insertSubview:loadingView belowSubview:_visualEffectView];
		[loadingView sdc_alignEdgesWithSuperview:UIRectEdgeAll];
		
		if (_putGradientWhenLoading)
		{
			GradientView* gradView = [GradientView new];
			gradView.colors = _loadingGradientColors ? _loadingGradientColors : @[rgba(0, 0, 0, .5), rgba(0, 0, 0, 0)];
			gradView.translatesAutoresizingMaskIntoConstraints = NO;
			[loadingView addSubview:gradView];
			[gradView sdc_alignSideEdgesWithSuperviewInset:0];
			[gradView sdc_alignTopEdgeWithSuperviewMargin:0];
			[gradView sdc_pinHeight:_loadingGradientHeight ? [_loadingGradientHeight floatValue] : 80];
		}
		
		if (loadingViewProviderBlock)
		{
			loadingViewProviderBlock(loadingView);
		}
		else
			
		{
			myLoadingView* loading = [[myLoadingView alloc] initWithFrame:CGRectMake(0, 0, 37, 37)];
			if (_loadingViewColor)
				loading.color = _loadingViewColor;
			[loading startAnimating];
			[loading setTranslatesAutoresizingMaskIntoConstraints:NO];
			[loadingView addSubview:loading];
			[loading sdc_centerInSuperview];
			[loading sdc_pinSize:CGSizeMake(37, 37)];
		}
	}
	
	if (animated)
	{
		//		loadingView.alpha = 0;
		
		if (_hideNavBarOnLoading)
			[self.navigationController setNavigationBarHidden:YES];
		[UIView animateWithDuration:kAnimationsDuration animations:^{
			loadingView.alpha = 1;
			
			if (_hideVisualEffectViewOnLoading)
				_visualEffectView.alpha = 0;
		} completion:^(BOOL finished) {
			if (completion)
				completion();
		}];
	}
	else
	{
		if (completion)
			completion();
	}
}

-(void)hidePageLoadingAnimated:(BOOL)animated completion:(void(^)())completion
{
	[self.navigationController setNavigationBarHidden:NO];
	[UIView animateWithDuration:animated ? kAnimationsDuration : 0 animations:^{
		loadingView.alpha = 0;
		_visualEffectView.alpha = 1;
	} completion:^(BOOL finished) {
		if (finished)
		{
			[loadingView removeFromSuperview];
			loadingView = nil;
			if (completion)
				completion();
		}
	}];
}

-(void)showGeneralErrorWithMessage:(NSString*)msg animted:(BOOL)animated completion:(void(^)())completion
{
	if (!generalErrorView)
	{
		generalErrorView = [UIView new];
		generalErrorView.backgroundColor = [UIColor groupTableViewBackgroundColor];
		[generalErrorView setTranslatesAutoresizingMaskIntoConstraints:NO];
		//		[self.view addSubview:generalErrorView];
		[self.view insertSubview:generalErrorView belowSubview:_visualEffectView];
		[generalErrorView sdc_alignEdgesWithSuperview:UIRectEdgeAll];
		
		UIView* innerContent = [UIView new];
		innerContent.translatesAutoresizingMaskIntoConstraints = NO;
		[generalErrorView addSubview:innerContent];
		[innerContent sdc_alignSideEdgesWithSuperviewInset:0];
		[innerContent sdc_verticallyCenterInSuperview];
		
		MyShapeView* shapeView = [[MyShapeView alloc] initWithShapeDesc:k_iconExclam() andShapeTintColor:[UIColor lightGrayColor]];
		shapeView.translatesAutoresizingMaskIntoConstraints = NO;
		[innerContent addSubview:shapeView];
		[shapeView sdc_pinSize:CGSizeMake(70, 70)];
		[shapeView sdc_alignEdgesWithSuperview:UIRectEdgeTop];
		[shapeView sdc_horizontallyCenterInSuperview];
		
		UILabel* messageLabel = [UILabel new];
		messageLabel.translatesAutoresizingMaskIntoConstraints = NO;
		messageLabel.text = msg;
		messageLabel.textAlignment = NSTextAlignmentCenter;
		messageLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
		messageLabel.textColor = [UIColor grayColor];
		[innerContent addSubview:messageLabel];
		[messageLabel sdc_alignEdge:UIRectEdgeTop withEdge:UIRectEdgeBottom ofView:shapeView inset:10];
		[messageLabel sdc_horizontallyCenterInSuperview];
		
		_defineWeakSelf;
		
		MyShapeButton* retryButton = [[MyShapeButton alloc] initWithShapeDesc:k_iconRetry() andShapeTintColor:[UIColor grayColor] andButtonClick:^{
			[weakSelf reload];
		}];
		retryButton.shapeMargins = UIEdgeInsetsMake(12, 12, 12, 12);
		retryButton.translatesAutoresizingMaskIntoConstraints = NO;
		[innerContent addSubview:retryButton];
		[retryButton sdc_alignEdge:UIRectEdgeTop withEdge:UIRectEdgeBottom ofView:messageLabel inset:10];
		[retryButton sdc_horizontallyCenterInSuperview];
		[retryButton sdc_pinSize:CGSizeMake(50, 50)];
		[retryButton sdc_alignEdgesWithSuperview:UIRectEdgeBottom];
		
	}
	
	if (animated)
	{
		generalErrorView.alpha = 0;
		[UIView animateWithDuration:kAnimationsDuration animations:^{
			generalErrorView.alpha = 1;
		} completion:^(BOOL finished) {
			if (completion)
				completion();
		}];
	}
	else
	{
		if (completion)
			completion();
	}
}

-(void)hideGeneralErrorAnimated:(BOOL)animated completion:(void(^)())completion
{
	[UIView animateWithDuration:animated ? kAnimationsDuration : 0 animations:^{
		generalErrorView.alpha = 0;
	} completion:^(BOOL finished) {
		if (finished)
		{
			[generalErrorView removeFromSuperview];
			generalErrorView = nil;
			if (completion)
				completion();
		}
	}];
}

-(void)viewDidLayoutSubviews
{
	[super viewDidLayoutSubviews];
	[self updateNavBarBackDropView:NO];
}

-(void)updateNavBarBackDropView:(bool)animated
{
	[self.view layoutIfNeeded];
	visualEffectViewHeightCon.constant = [self NavBarBackDropViewHeight];
	
	
	if (animated)
		[UIView animateWithDuration:kAnimationsDuration animations:^{
			[self.view layoutIfNeeded];
		}];
}

-(void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	[self.view bringSubviewToFront:_visualEffectView];
}

-(CGFloat)NavBarBackDropViewHeight
{
	UIInterfaceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
	
	if (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
	{
		return 64;
	}
	else if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight)
	{
		return 44;
	}
	
	return 64;
}

-(void)reload
{
	NSAssert(false, @"you didn't override reload method [_homebasevc.m]");
}

-(void)_reloadPath:(NSString*)path callback:(void (^)(id))callback andError:(void (^)(NSError *))errorCallback
{
	_reloadDone = NO;
	
	if (!_noPageLoading)
	{
		[self hideGeneralErrorAnimated:YES completion:nil];
		[self showPageLoadingAnimated:NO completion:nil];
	}
	
	[[helper_connectivity serverGetWithPath:path completionHandler:^(long response_code, id obj) {
		
		NSLog(@"resp");
		
		if (!_noPageLoading)
		{
			if (!_manuallyHideLoadingViewOnSuccessfulReload)
				_mainThread(^{
					[self hidePageLoadingAnimated:YES completion:nil];
				});
		}
		
		if (response_code == 200)
		{
			_reloadDone = YES;
			callback(obj);
		}
		else
		{
			if (errorCallback)
				errorCallback(obj);
			else
			{
				if (!_noPageLoading)
				{
					_mainThread(^{
						[self showGeneralErrorWithMessage:@"error" animted:YES completion:nil];
					});
				}
			}
		}
		
	}] resume];
}

//-(void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
//{
////	NSLog(@"%@", NSStringFromCGSize(size));
//
//	[self updateNavBarBackDropView:YES];
//
//}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
