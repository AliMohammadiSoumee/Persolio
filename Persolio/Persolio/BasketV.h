//
//  BasketV.h
//  Persolio
//
//  Created by Ali Soume`e on 5/14/1396 AP.
//  Copyright © 1396 Ali Soume`e. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BasketVDelegate <NSObject>

- (void)addButtonTouched;

@end


@interface BasketV : UIView <UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, weak) id<BasketVDelegate> delegate;

- (void)prepareCollectionView;

@end
