//
//  ProfileVC.m
//  Persolio
//
//  Created by Ali Soume`e on 5/10/1396 AP.
//  Copyright © 1396 Ali Soume`e. All rights reserved.
//

#import "ProfileVC.h"
#import "EventV.h"

@interface ProfileVC () <UITabBarDelegate>

@property (nonatomic, strong)UITabBar *tabBar;
@property (nonatomic, retain) UITabBarItem *profileItem1;
@property (nonatomic, retain) UITabBarItem *profileItem2;
@property (nonatomic, retain) UITabBarItem *profileItem3;
@property (nonatomic, retain) UITabBarItem *profileItem4;
@property (weak, nonatomic) IBOutlet UIView *tabViewManagment;

@property (nonatomic, strong) EventV *eventV;

@end

@implementation ProfileVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self prepareTabBarV];
    [self addEventV];
}


- (void)prepareTabBarV {
    _tabBar = [UITabBar new];
    _tabBar.delegate = self;
    _tabBar.backgroundColor = [UIColor clearColor];
    _tabBar.translatesAutoresizingMaskIntoConstraints = NO;
    [_tabBarV addSubview:_tabBar];
    [_tabBar sdc_alignEdgesWithSuperview:UIRectEdgeAll];
    _tabBar.clipsToBounds = YES;
//    _tabBar.barTintColor = [UIColor colorWithRed:179/255 green:179/255 blue:179/255 alpha:1];
//    _tabBar.translucent = NO;
    _tabBar.tintColor = [UIColor colorWithRed:179/255 green:179/255 blue:179/255 alpha:1];
    
    _tabBar.layer.zPosition = -1;
    
    _profileItem1 = [UITabBarItem new];
    _profileItem1.image = [UIImage imageNamed:@"pix-off.png"];
    _profileItem1.selectedImage = [UIImage imageNamed:@"pix-on.png"];
    [_profileItem1 setImageInsets:UIEdgeInsetsMake(5, 0, -5, 0)];
    
    _profileItem2 = [UITabBarItem new];
    _profileItem2.image = [UIImage imageNamed:@"suggestion-off.png"];
    _profileItem2.selectedImage = [UIImage imageNamed:@"suggestion-on.png"];    [_profileItem2 setImageInsets:UIEdgeInsetsMake(5, 0, -5, 0)];
    
    _profileItem3 = [UITabBarItem new];
    _profileItem3.image = [UIImage imageNamed:@"cart-off.png"];
    _profileItem3.selectedImage = [UIImage imageNamed:@"cart-on.png"];    [_profileItem3 setImageInsets:UIEdgeInsetsMake(5, 0, -5, 0)];
    
    _profileItem4 = [UITabBarItem new];
    _profileItem4.image = [UIImage imageNamed:@"news-off.png"];
    _profileItem4.selectedImage = [UIImage imageNamed:@"news-on.png"];
    [_profileItem4 setImageInsets:UIEdgeInsetsMake(5, 0, -5, 0)];
    
    _tabBar.items = [NSArray arrayWithObjects:_profileItem1, _profileItem2, _profileItem3, _profileItem4, nil];
    [_tabBar setSelectedItem:[_tabBar
                              .items objectAtIndex:0]];
    
}



-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
//    [_scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width * item.tag , 0) animated:YES];
}


//-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
//    int page = scrollView.contentOffset.x / scrollView.frame.size.width;
//    [_tabBar setSelectedItem:[_tabBar.items objectAtIndex:page]];
//    
//}


- (void)addEventV {
    if (!_eventV) {
        _eventV = [EventV new];
    }
    _eventV.translatesAutoresizingMaskIntoConstraints = NO;
    [self.tabViewManagment addSubview:_eventV];
    [_eventV sdc_alignEdgesWithSuperview:UIRectEdgeAll];
    [self.view layoutIfNeeded];
    [_eventV prepareCollectionView];
}

@end
