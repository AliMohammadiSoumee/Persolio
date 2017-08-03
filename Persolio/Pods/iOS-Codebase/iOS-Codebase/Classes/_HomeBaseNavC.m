//
//  _HomeBaseNavC.m
//  Kababchi
//
//  Created by hAmidReza on 7/20/17.
//  Copyright © 2017 innovian. All rights reserved.
//

#import "_HomeBaseNavC.h"
#import "_HomeBaseNavBar.h"

@interface _HomeBaseNavC () <UINavigationControllerDelegate>

@end

@implementation _HomeBaseNavC

-(instancetype)initWithRootViewController:(UIViewController *)rootViewController
{
	self = [super initWithNavigationBarClass:[_HomeBaseNavBar class] toolbarClass:[UIToolbar class]];
	if (self)
	{
		self.delegate = self;
		self.viewControllers = @[rootViewController];
	}
	return self;
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
	return UIStatusBarStyleLightContent;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

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
