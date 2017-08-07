//
//  DetailsVC.m
//  Persolio
//
//  Created by Ali Soume`e on 5/15/1396 AP.
//  Copyright © 1396 Ali Soume`e. All rights reserved.
//

#import "DetailsVC.h"
#import "DetailsCVC.h"

@interface DetailsVC ()<UICollectionViewDelegate, UICollectionViewDataSource>
{
    NSArray *array;
}
@end

@implementation DetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    array = @[@"details0", @"details1", @"details2", @"details0", @"details1", @"details2", @"details0", @"details1", @"details2", @"details3"];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView setTransform:CGAffineTransformMakeScale(-1, 1)];
    
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DetailsCVC *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DetailsCVC" forIndexPath:indexPath];
    cell.imageView.image = [UIImage imageNamed:[array objectAtIndex:indexPath.row % array.count]];
    return cell;
}

@end
