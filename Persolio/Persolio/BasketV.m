//
//  BasketV.m
//  Persolio
//
//  Created by Ali Soume`e on 5/14/1396 AP.
//  Copyright © 1396 Ali Soume`e. All rights reserved.
//

#import "BasketV.h"
#import "BasketCVC.h"

@interface BasketV()
{
    int num;
    UICollectionReusableView *headerV;
    NSArray *array;
}

@end

@implementation BasketV

- (void)prepareCollectionView {
    array = @[@"buy0.jpg", @"football0.jpg", @"friend0.jpg", @"park0.jpg", @"safar0.jpg", @"carting0.jpg", @"buy1.jpg", @"football1.jpg", @"friend1.jpg", @"park1.jpg", @"safar1.jpg", @"carting1.jpg"];

    
    num = 21;
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.minimumLineSpacing = 5;
    
    CGRect frame = CGRectMake(0, 0, self.bounds.size.width, ceil((double)num / 4) * ((self.bounds.size.width - 25) / 4 + layout.minimumLineSpacing + 10));
    
    _collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
    [self addSubview:_collectionView];
    _collectionView.scrollEnabled = NO;
    [_collectionView sdc_alignEdgesWithSuperview:UIRectEdgeAll];
    [_collectionView registerClass:BasketCVC.self forCellWithReuseIdentifier:@"BasketCVC"];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.contentInset = UIEdgeInsetsMake(0, 5, 10, 5);
    [_collectionView registerClass:UICollectionReusableView.self forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return num;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BasketCVC *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BasketCVC" forIndexPath:indexPath];
    cell.imageView.image = [UIImage imageNamed:[array objectAtIndex:indexPath.row % array.count]];
    return cell;
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (kind == UICollectionElementKindSectionHeader) {
        headerV = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        
        
        UIView *borderV = [UIView new];
        borderV.translatesAutoresizingMaskIntoConstraints = NO;
        borderV.clipsToBounds = YES;
        borderV.layer.cornerRadius = 15;
        borderV.layer.borderWidth = 1;
        borderV.layer.borderColor = [UIColor colorWithRed:182.0/255 green:182.0/255 blue:182.0/255 alpha:1].CGColor;
        [headerV addSubview:borderV];
        [borderV sdc_horizontallyCenterInSuperview];
        [borderV sdc_verticallyCenterInSuperview];
        [borderV sdc_pinHeight:30];
        [borderV sdc_pinWidth:250];
        
        
        UIButton *filterBtn = [UIButton new];
        UIButton *addBtn = [UIButton new];
        
        [filterBtn setTitle:@"Pix" forState:UIControlStateNormal];
//        UIControlEventTouchUpInside];
//        [filterBtn setTitleColor:[UIColor colorWithRed:182.0/255 green:182.0/255 blue:182.0/255 alpha:1] forState:UIControlStateNormal];
        [filterBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [addBtn setTitle:@"Events" forState:UIControlStateNormal];
        [addBtn setTitleColor:[UIColor colorWithRed:182.0/255 green:182.0/255 blue:182.0/255 alpha:1] forState:UIControlStateNormal];
        [addBtn addTarget:self action:@selector(addButtonTouched) forControlEvents:UIControlEventTouchUpInside];
        
        UIView *middle = [UIView new];
        middle.translatesAutoresizingMaskIntoConstraints = NO;
        [borderV addSubview:middle];
        middle.backgroundColor = [UIColor colorWithRed:182.0/255 green:182.0/255 blue:182.0/255 alpha:1];
        [middle sdc_alignEdgesWithSuperview:UIRectEdgeTop | UIRectEdgeBottom];
        [middle sdc_pinWidth:1];
        [middle sdc_horizontallyCenterInSuperview];
        
        [borderV addSubview:filterBtn];
        filterBtn.translatesAutoresizingMaskIntoConstraints = NO;
        [filterBtn sdc_alignEdgesWithSuperview:UIRectEdgeTop | UIRectEdgeBottom | UIRectEdgeLeft insets:UIEdgeInsetsMake(5, 10, -5, 0)];
        [filterBtn sdc_alignEdge:UIRectEdgeRight withEdge:UIRectEdgeLeft ofView:middle];
        
        [borderV addSubview:addBtn];
        addBtn.translatesAutoresizingMaskIntoConstraints = NO;
        [addBtn sdc_alignEdgesWithSuperview:UIRectEdgeTop | UIRectEdgeBottom | UIRectEdgeRight insets:UIEdgeInsetsMake(5, 0, -5, 0)];
        [addBtn sdc_alignEdge:UIRectEdgeLeft withEdge:UIRectEdgeRight ofView:middle];
        
        UIView *hairLineV = [UIView new];
        hairLineV.translatesAutoresizingMaskIntoConstraints = NO;
        hairLineV.backgroundColor = [UIColor lightGrayColor];
        [headerV addSubview:hairLineV];
        [hairLineV sdc_pinHeight:1];
        [hairLineV sdc_alignEdgesWithSuperview:UIRectEdgeAll ^ UIRectEdgeTop];
        
        return headerV;
    }
    return nil;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(self.bounds.size.width, 50);
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = (self.bounds.size.width - 25) / 4;
    return CGSizeMake(height, height);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 5.0;
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, 0, 0, 0);
}

- (void)addButtonTouched {
    if ([_delegate respondsToSelector:@selector(addButtonTouched)]) {
        [_delegate addButtonTouched];
    }
}

@end
