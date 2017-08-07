//
//  CreateVC.m
//  Persolio
//
//  Created by Ali Soume`e on 5/15/1396 AP.
//  Copyright © 1396 Ali Soume`e. All rights reserved.
//

#import "CreateVC.h"
#import "CreateCVC.h"

@interface CreateVC () <UICollectionViewDelegate, UICollectionViewDataSource>
{
    NSArray *list;
    NSInteger selectedItem;
}
@end

@implementation CreateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configNavBar];
    
    list = [NSArray arrayWithObjects:@"Sketch.png", @"person.png", nil];
    selectedItem = 0;
    
    _collectionView.prefetchingEnabled = NO;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
}

- (void)configNavBar {
    self.navigationItem.title = [NSString stringWithFormat:@"Persolio"];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIColor lightGrayColor] forKey:NSForegroundColorAttributeName]];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithDisplayP3Red:0 green:0 blue:0 alpha:1];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleLightContent;
    
    UIBarButtonItem *menuBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu"] style:UIBarButtonItemStylePlain target:self action:@selector(menuButtonTouched)];
    menuBtn.imageInsets = UIEdgeInsetsMake(12, 12, 12, 12);
    self.navigationItem.rightBarButtonItem = menuBtn;
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor lightGrayColor];
}


- (void)menuButtonTouched {
    if (_menu.hidden) {
        _menu.hidden = false;
    }
    else {
        _menu.hidden = true;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CreateCVC *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CreateCVC" forIndexPath:indexPath];
    
    
    cell.borderImageView.image = nil;
    if (indexPath.row + 1 == [collectionView numberOfItemsInSection:indexPath.section]) {
        cell.imageView.image = [UIImage imageNamed:@"AddNew.png"];
    }
    else
        cell.imageView.image = [UIImage imageNamed:list[indexPath.row % list.count]];
    
    if (indexPath.row == selectedItem) {
        cell.borderImageView.image = [UIImage imageNamed:@"BorderImageV.png"];
    }
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row + 1 == [collectionView numberOfItemsInSection:indexPath.section]) {
        self.tabBarController.tabBar.barTintColor = [UIColor whiteColor];
        self.tabBarController.tabBar.translucent = YES;
        [self.tabBarController setSelectedIndex:4];
        return;
    }
    
    NSIndexPath *index = [NSIndexPath indexPathForItem:selectedItem inSection:0];
    CreateCVC *cell = (CreateCVC*)[collectionView cellForItemAtIndexPath:index];
    cell.borderImageView.image = nil;
    
    selectedItem = indexPath.row;
    
    index = [NSIndexPath indexPathForItem:selectedItem inSection:0];
    cell = (CreateCVC*)[collectionView cellForItemAtIndexPath:index];
    cell.borderImageView.image = [UIImage imageNamed:@"BorderImageV.png"];
    
    if (selectedItem % 2 == 0) {
        _imageView.image = [UIImage imageNamed:@"OutPutPhoto1"];
    }
    else {
        _imageView.image = [UIImage imageNamed:@"OutPutPhoto"];
    }
}

- (IBAction)GPFTouched:(id)sender {
    if (selectedItem % 2 == 0) {
        _imageView.image = [UIImage imageNamed:@"OutPutPhoto1"];
    }
    else {
        _imageView.image = [UIImage imageNamed:@"OutPutPhoto"];
    }    _menu.hidden = true;
    
    _faceMenuV.hidden = YES;
    _GPFMenuV.hidden = NO;
    
    _collectionView.hidden = NO;
    _faceBottomMenu.hidden = YES;
}
- (IBAction)faceCoverTouched:(id)sender {
    _imageView.image = [UIImage imageNamed:@"OutPutPhoto2"];
    _menu.hidden = true;
    
    _faceMenuV.hidden = NO;
    _GPFMenuV.hidden = YES;
    
    _collectionView.hidden = YES;
    _faceBottomMenu.hidden = NO;
}

@end
