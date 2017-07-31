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


@interface TestLibraryVC () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSArray <NSString*> *testNames;

@end

@implementation TestLibraryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _testNames = [NSArray arrayWithObjects:@"Test1", @"Test2", @"Test3", @"Test4", nil];
    
    
    [self prepareCollectionView];
    [self configNavBar];
    
}


- (void)configNavBar {
    //coneria
    
    self.navigationItem.title = [NSString stringWithFormat:@"Persolio"];
//    [self.navigationController.navigationBar setTitleTextAttributes:
//     @{NSForegroundColorAttributeName:[UIColor blackColor],
//       NSFontAttributeName:[UIFont fontWithName:@"mplus-1c-regular" size:21]}];
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
    dic[@"title"] = _testNames[index];
    dic[@"desc"] = @"a test that tells you \n your personality type";
    dic[@"tag"] = @(indexPath.row % 3);
    
    [cell prepareWithDic:dic];
    
    return cell;
}

@end
