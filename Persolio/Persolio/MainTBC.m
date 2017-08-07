//
//  MainTBC.m
//  Persolio
//
//  Created by Ali Soume`e on 5/3/1396 AP.
//  Copyright © 1396 Ali Soume`e. All rights reserved.
//

#import "MainTBC.h"
#import "BasketV.h"


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
    [self.tabBar setTintColor:RGBAColor(255, 255, 255, 1)];
}

- (void)prepareViewControllers {
    UINavigationController *testNavC = _vc_from_storyboard(@"TestLibrary", @"TestLibraryNavC");
    [self addChildViewController:testNavC];
    UITabBarItem *testLibraryItem = [UITabBarItem new];
    testLibraryItem.image = [[UIImage imageNamed:@"TestsButton"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    testLibraryItem.selectedImage = [[UIImage imageNamed:@"TestsButtonSelected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    testLibraryItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
    [testNavC setTabBarItem:testLibraryItem];
    
    UINavigationController *coWorkersNavC = _vc_from_storyboard(@"CowWorkers", @"CoWorkersNavC");
    [self addChildViewController:coWorkersNavC];
    UITabBarItem *coWorkersItem = [UITabBarItem new];
    coWorkersItem.image = [[UIImage imageNamed:@"coWorkerButton"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    coWorkersItem.selectedImage = [[UIImage imageNamed:@"coWorkerButtonSelected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    coWorkersItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
    [coWorkersNavC setTabBarItem:coWorkersItem];
    
    UINavigationController *creatNavC = _vc_from_storyboard(@"Create", @"CreateNavC");
    [self addChildViewController:creatNavC];
    UITabBarItem *creatItem = [UITabBarItem new];
    creatItem.tag = 10;
    creatItem.image = [[UIImage imageNamed:@"Edit-off"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    creatItem.selectedImage = [[UIImage imageNamed:@"Edit-on"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    creatItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
    [creatNavC setTabBarItem:creatItem];

    
    UINavigationController *shopNavC = _vc_from_storyboard(@"Shop", @"ShopNavC");
    [self addChildViewController:shopNavC];
    UITabBarItem *shopItem = [UITabBarItem new];
    shopItem.image = [[UIImage imageNamed:@"ShopButton"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    shopItem.selectedImage = [[UIImage imageNamed:@"ShopButtonSelected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    shopItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
    [shopNavC setTabBarItem:shopItem];
    
    UINavigationController *profileNavC = _vc_from_storyboard(@"Profile", @"ProfileNavC");
    [self addChildViewController:profileNavC];
    UITabBarItem *profileItem = [UITabBarItem new];
    profileItem.image = [[UIImage imageNamed:@"ProfileButton"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    profileItem.selectedImage = [[UIImage imageNamed:@"ProfileButtonSelected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    profileItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
    [profileNavC setTabBarItem:profileItem];
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    if (item.tag == 10) {
        self.tabBar.barTintColor = [UIColor blackColor];
        self.tabBar.translucent = NO;
    }
    else {
        self.tabBar.barTintColor = [UIColor whiteColor];
        self.tabBar.translucent = YES;
    }
}


@end
