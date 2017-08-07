//
//  CartV.m
//  Persolio
//
//  Created by Ali Soume`e on 5/16/1396 AP.
//  Copyright © 1396 Ali Soume`e. All rights reserved.
//

#import "CartV.h"
#import "CartCVC.h"
#import "CartCVC1.h"

@interface CartV()
{
    NSInteger num1;
    NSInteger num2;
    UICollectionReusableView *headerV;
    NSArray *array, *title, *bookArray;
}

@end


@implementation CartV


- (void)prepareCollectionView {
    
    array = @[@"buy0.jpg", @"football0.jpg", @"friend0.jpg", @"park0.jpg", @"safar0.jpg", @"carting0.jpg", @"buy1.jpg", @"football1.jpg", @"friend1.jpg", @"park1.jpg", @"safar1.jpg", @"carting1.jpg"];
    title = @[@"خرید", @"فوتبال", @"دوست", @"پارک", @"سفر", @"کارتینگ", @"خرید", @"فوتبال", @"دوست", @"پارک", @"سفر", @"کارتینگ"];

    bookArray = @[@"book0.jpg", @"book1.jpg", @"book2.jpg", @"book3.jpg"];
    
    num1 = 4;
    num2 = 21;
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.minimumLineSpacing = 10;
    
    CGRect frame = CGRectMake(0, 0, self.bounds.size.width, 1110);
    
    _collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
    [self addSubview:_collectionView];
    _collectionView.scrollEnabled = NO;
    [_collectionView sdc_alignEdgesWithSuperview:UIRectEdgeAll];
    [_collectionView registerClass:CartCVC.self forCellWithReuseIdentifier:@"CartCVC"];
    [_collectionView registerClass:CartCVC1.self forCellWithReuseIdentifier:@"CartCVC1"];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.contentInset = UIEdgeInsetsMake(0, 5, 10, 5);
    [_collectionView registerClass:UICollectionReusableView.self forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return num1;
    }
    else {
        return num2;
    }
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        CartCVC *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CartCVC" forIndexPath:indexPath];
        cell.imageView.image = [UIImage imageNamed:[bookArray objectAtIndex:(indexPath.row % bookArray.count)]];
        return cell;
    }
    else {
        CartCVC1 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CartCVC1" forIndexPath:indexPath];
        cell.imageView.image = [UIImage imageNamed:[array objectAtIndex:(indexPath.row % array.count)]];
        return cell;
    }
    
    
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (kind == UICollectionElementKindSectionHeader) {
        if (indexPath.section == 0) {
            headerV = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
            
            UIButton *filterBtn = [UIButton new];
            UIButton *addBtn = [UIButton new];
            
            [filterBtn setImage:[UIImage imageNamed:@"filter-off"] forState:UIControlStateNormal];
            [addBtn setImage:[UIImage imageNamed:@"plus-off"] forState:UIControlStateNormal];
            
            UIView *middle = [UIView new];
            middle.translatesAutoresizingMaskIntoConstraints = NO;
            [headerV addSubview:middle];
            [middle sdc_alignEdgesWithSuperview:UIRectEdgeTop];
            [middle sdc_pinHeight:40];
            [middle sdc_pinWidth:0];
            [middle sdc_horizontallyCenterInSuperview];
            
            [headerV addSubview:filterBtn];
            filterBtn.imageEdgeInsets = UIEdgeInsetsMake(7, 7, 7, 7);
            filterBtn.translatesAutoresizingMaskIntoConstraints = NO;
            [filterBtn sdc_alignEdgesWithSuperview:UIRectEdgeTop insets:UIEdgeInsetsMake(5, 0, 0, 0)];
            [filterBtn sdc_pinHeight:40];
            [filterBtn sdc_pinHeightWidthRatio:1 constant:0];
            [filterBtn sdc_alignEdge:UIRectEdgeRight withEdge:UIRectEdgeLeft ofView:middle inset:-30];
            
            [headerV addSubview:addBtn];
            addBtn.imageEdgeInsets = UIEdgeInsetsMake(7, 7, 7, 7);
            addBtn.translatesAutoresizingMaskIntoConstraints = NO;
            [addBtn sdc_alignEdgesWithSuperview:UIRectEdgeTop insets:UIEdgeInsetsMake(5, 0, 0, 0)];
            [addBtn sdc_pinHeight:40];
            [addBtn sdc_pinHeightWidthRatio:1 constant:0];
            [addBtn sdc_alignEdge:UIRectEdgeLeft withEdge:UIRectEdgeRight ofView:middle inset:30];
            
            UIView *hairLineV = [UIView new];
            hairLineV.translatesAutoresizingMaskIntoConstraints = NO;
            hairLineV.backgroundColor = [UIColor lightGrayColor];
            [headerV addSubview:hairLineV];
            [hairLineV sdc_pinHeight:1];
            [hairLineV sdc_alignEdgesWithSuperview:UIRectEdgeRight | UIRectEdgeLeft];
            [hairLineV sdc_alignEdge:UIRectEdgeTop withEdge:UIRectEdgeBottom ofView:middle inset:10];
            
            UILabel *desc = [UILabel new];
            desc.textAlignment = NSTextAlignmentCenter;
            desc.font = [UIFont fontWithName:@"IRANSansMobile-Medium" size:24];
            [headerV addSubview:desc];
            desc.translatesAutoresizingMaskIntoConstraints = NO;
            [desc sdc_alignEdgesWithSuperview:UIRectEdgeAll ^ UIRectEdgeTop];
            [desc sdc_alignEdge:UIRectEdgeTop withEdge:UIRectEdgeBottom ofView:hairLineV inset:20];
            desc.text = @"سفارش های من";
            
            return headerV;
        }
        
        
        else {
            headerV = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
            
            UILabel *desc = [UILabel new];
            desc.textAlignment = NSTextAlignmentCenter;
            desc.font = [UIFont fontWithName:@"IRANSansMobile-Medium" size:24];
            [headerV addSubview:desc];
            desc.translatesAutoresizingMaskIntoConstraints = NO;
            [desc sdc_alignEdgesWithSuperview:UIRectEdgeAll];
            desc.text = @"خرید های گذشته";
            
            return headerV;
        }
    }
    return nil;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section == 0)
        return CGSizeMake(self.bounds.size.width, 100);
    else
        return CGSizeMake(self.bounds.size.width, 50);
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return CGSizeMake(self.bounds.size.width - 10, 70);
    }
    else {
        CGFloat height = (self.bounds.size.width - 25) / 4 - 10;
        return CGSizeMake(height, height);
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    if (section == 0) {
        return 10;
    }
    else {
        return 5.0;
    }
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (section == 0)
        return UIEdgeInsetsMake(10, 0, 40, 0);
    else
        return UIEdgeInsetsMake(10, 10, 40, 10);
}
@end
