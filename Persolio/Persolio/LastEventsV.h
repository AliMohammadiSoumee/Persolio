//
//  LastEventsV.h
//  Persolio
//
//  Created by Ali Soume`e on 5/14/1396 AP.
//  Copyright © 1396 Ali Soume`e. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol LastEventsDelegate <NSObject>

- (void)eventsButtonToucehd;

@end


@interface LastEventsV : UIView <UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) id<LastEventsDelegate> delegate;

- (void)prepareCollectionView;


@end
