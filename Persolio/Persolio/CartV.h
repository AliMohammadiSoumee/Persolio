//
//  CartV.h
//  Persolio
//
//  Created by Ali Soume`e on 5/16/1396 AP.
//  Copyright © 1396 Ali Soume`e. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CartV : UIView <UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;


- (void)prepareCollectionView;


@end
