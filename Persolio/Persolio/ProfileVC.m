//
//  ProfileVC.m
//  Persolio
//
//  Created by Ali Soume`e on 5/10/1396 AP.
//  Copyright © 1396 Ali Soume`e. All rights reserved.
//

#import "ProfileVC.h"
#import "EventV.h"
#import "BasketV.h"
#import "LastEventsV.h"
#import "NewsV.h"
#import "DetailsVC.h"
#import "CartV.h"
#import "EditProfileVC.h"

@interface ProfileVC () <UITabBarDelegate, BasketVDelegate, LastEventsDelegate, UIViewControllerPreviewingDelegate>

@property (nonatomic, strong)UITabBar *tabBar;
@property (nonatomic, retain) UITabBarItem *profileItem1;
@property (nonatomic, retain) UITabBarItem *profileItem2;
@property (nonatomic, retain) UITabBarItem *profileItem3;
@property (nonatomic, retain) UITabBarItem *profileItem4;
@property (weak, nonatomic) IBOutlet UIView *tabViewManagment;

@property (nonatomic, strong) EventV *eventV;
@property (nonatomic, strong) BasketV *basketV;
@property (nonatomic, strong) LastEventsV *lastEventV;
@property (nonatomic, strong) NewsV *newsV;
@property (nonatomic, strong) DetailsVC *detailsVC;
@property (nonatomic, strong) CartV *cartV;

@end

@implementation ProfileVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self prepareTabBarV];
    [self addBasketV];
    [self configNavBar];
    
    [self registerForPreviewingWithDelegate:self sourceView:self.view];
    
}


- (void)configNavBar {
    self.navigationItem.title = [NSString stringWithFormat:@"Persolio"];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor]}];
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
    _profileItem1.tag = 1;
    _profileItem1.image = [UIImage imageNamed:@"pix-off.png"];
    _profileItem1.selectedImage = [UIImage imageNamed:@"pix-on.png"];
    [_profileItem1 setImageInsets:UIEdgeInsetsMake(5, 0, -5, 0)];
    
    _profileItem2 = [UITabBarItem new];
    _profileItem2.tag = 2;
    _profileItem2.image = [UIImage imageNamed:@"suggestion-off.png"];
    _profileItem2.selectedImage = [UIImage imageNamed:@"suggestion-on.png"];    [_profileItem2 setImageInsets:UIEdgeInsetsMake(5, 0, -5, 0)];
    
    _profileItem3 = [UITabBarItem new];
    _profileItem3.tag = 3;
    _profileItem3.image = [UIImage imageNamed:@"cart-off.png"];
    _profileItem3.selectedImage = [UIImage imageNamed:@"cart-on.png"];    [_profileItem3 setImageInsets:UIEdgeInsetsMake(5, 0, -5, 0)];
    
    _profileItem4 = [UITabBarItem new];
    _profileItem4.tag = 4;
    _profileItem4.image = [UIImage imageNamed:@"news-off.png"];
    _profileItem4.selectedImage = [UIImage imageNamed:@"news-on.png"];
    [_profileItem4 setImageInsets:UIEdgeInsetsMake(5, 0, -5, 0)];
    
    _tabBar.items = [NSArray arrayWithObjects:_profileItem1, _profileItem2, _profileItem3, _profileItem4, nil];
    [_tabBar setSelectedItem:[_tabBar
                              .items objectAtIndex:0]];
    
}



- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    if (item.tag == 1) {
        [self addBasketV];
    }
    else if (item.tag == 2) {
        [self addEventV];
    }
    else if (item.tag == 3) {
        [self addCartV];
    }
    else if (item.tag == 4) {
        [self addNewsV];
    }
}


- (void)addCartV {
    [self.tabViewManagment sdc_removeAllSubViews];
    if (!_cartV) {
        _cartV = [CartV new];
    }
    _cartV.translatesAutoresizingMaskIntoConstraints = NO;
    [self.tabViewManagment addSubview:_cartV];
    [_cartV sdc_alignEdgesWithSuperview:UIRectEdgeAll];
    [self.view layoutIfNeeded];
    [_cartV prepareCollectionView];
}


- (void)addEventV {
    [self.tabViewManagment sdc_removeAllSubViews];
    if (!_eventV) {
        _eventV = [EventV new];
    }
    _eventV.translatesAutoresizingMaskIntoConstraints = NO;
    [self.tabViewManagment addSubview:_eventV];
    [_eventV sdc_alignEdgesWithSuperview:UIRectEdgeAll];
    [self.view layoutIfNeeded];
    [_eventV prepareCollectionView];
}

- (void)addBasketV {
    [self.tabViewManagment sdc_removeAllSubViews];
    if (!_basketV) {
        _basketV = [BasketV new];
    }
    _basketV.delegate = self;
    _basketV.translatesAutoresizingMaskIntoConstraints = NO;
    [self.tabViewManagment addSubview:_basketV];
    [_basketV sdc_alignEdgesWithSuperview:UIRectEdgeAll];
    [self.view layoutIfNeeded];
    [_basketV prepareCollectionView];
}

- (void)addLastEventsV {
    [self.tabViewManagment sdc_removeAllSubViews];
    if (!_lastEventV) {
        _lastEventV = [LastEventsV new];
    }
    _lastEventV.delegate = self;
    _lastEventV.translatesAutoresizingMaskIntoConstraints = NO;
    [self.tabViewManagment addSubview:_lastEventV];
    [_lastEventV sdc_alignEdgesWithSuperview:UIRectEdgeAll];
    [self.view layoutIfNeeded];
    [_lastEventV prepareCollectionView];
}

- (void)addNewsV {
    [self.tabViewManagment sdc_removeAllSubViews];
    if (!_newsV) {
        _newsV = [NewsV new];
    }
    _newsV.translatesAutoresizingMaskIntoConstraints = NO;
    [self.tabViewManagment addSubview:_newsV];
    [_newsV sdc_alignEdgesWithSuperview:UIRectEdgeAll];
    [self.view layoutIfNeeded];
    [_newsV prepareCollectionView];
}

- (void)addButtonTouched {
    [self addLastEventsV];
}

- (void)eventsButtonToucehd {
    [self addBasketV];
}


- (UIViewController *)previewingContext:(id<UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location {
    _detailsVC = _vc_from_storyboard(@"Details", @"DetailsVC");
    return _detailsVC;
}

- (void)previewingContext:(id<UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit {
    [self showViewController:viewControllerToCommit sender:self];
}
- (IBAction)avatarImageViewTouched:(id)sender {
    EditProfileVC *vc = _vc_from_storyboard(@"Profile", @"EditProfileVC");
    [self.navigationController pushViewController:vc animated:YES];
}
@end
