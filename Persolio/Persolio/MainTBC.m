//
//  MainTBC.m
//  Persolio
//
//  Created by Ali Soume`e on 5/3/1396 AP.
//  Copyright © 1396 Ali Soume`e. All rights reserved.
//

#import "MainTBC.h"


@interface MainTBC ()

@end

@implementation MainTBC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self prepareTabBar];
    [self prepareViewControllers];
}


- (void)prepareTabBar {
    [self.tabBar setUnselectedItemTintColor:RGBAColor(165, 170, 180, 1)];
    [self.tabBar setBarTintColor:RGBAColor(255, 255, 255, 1)];
}

- (void)prepareViewControllers {
    UINavigationController *testNavC = _vc_from_storyboard(@"TestLibrary", @"TestLibraryNavC");
    [self addChildViewController:testNavC];
    
    UINavigationController *cowWorkersNavC = _vc_from_storyboard(@"CowWorkers", @"CowWorkersNavC");
    [self addChildViewController:cowWorkersNavC];
}


@end
