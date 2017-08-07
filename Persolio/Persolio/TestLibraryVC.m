//
//  TestLibraryVC.m
//  Persolio
//
//  Created by Ali Soume`e on 5/3/1396 AP.
//  Copyright © 1396 Ali Soume`e. All rights reserved.
//

#import "TestLibraryVC.h"
#import "TestCVC.h"
#import "TestCVL.h"
#import "TestVC.h"


@interface TestLibraryVC () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSArray <NSString*> *testNames;
@property (nonatomic, strong) NSArray <NSString*> *titles;

@end

@implementation TestLibraryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _testNames = [NSArray arrayWithObjects:@"Test1", @"Test2", @"Test3", @"Test4", nil];
    _titles = [NSArray arrayWithObjects:@"آزمون اول", @"آزمون دوم", @"آزمون سوم", @"آزمون چهارم", nil];
    
    
    [self prepareCollectionView];
    [self configNavBar];
    
}


- (void)configNavBar {
    //coneria
    
    self.navigationItem.title = [NSString stringWithFormat:@"Persolio"];
//    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Coneria" size:21]}];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor]}];
}


- (void)prepareCollectionView {
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    TestCVL *layout = [TestCVL new];
    self.collectionView.collectionViewLayout = layout;
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TestCVC *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"TestCVC" forIndexPath:indexPath];
    
    NSMutableDictionary *dic = [NSMutableDictionary new];
    NSInteger index = (indexPath.row) % _testNames.count;
    dic[@"image"] = _testNames[index];
    dic[@"title"] = _titles[index];
//    dic[@"desc"] = @" تستی برای ارزیابی مهارت ها و شخصیت شما و معرفی استعداد های شما در راستای پیشرفت.";
    dic[@"tag"] = @(indexPath.row % 3);
    
    [cell prepareWithDic:dic];
    
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    TestVC *vc = _vc_from_storyboard(@"TestLibrary", @"TestVC");
    [self.navigationController pushViewController:vc animated:YES];
}
@end
