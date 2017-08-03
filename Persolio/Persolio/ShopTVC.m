//
//  ShopTVC.m
//  Persolio
//
//  Created by Ali Soume`e on 5/10/1396 AP.
//  Copyright © 1396 Ali Soume`e. All rights reserved.
//

#import "ShopTVC.h"
#import "ShopCVC.h"

@implementation ShopTVC 

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)prepare {
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ShopCVC *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ShopCVC" forIndexPath:indexPath];
    cell.imageView.image = [UIImage imageNamed:@"Karbin.png"];
    return cell;
}


@end
