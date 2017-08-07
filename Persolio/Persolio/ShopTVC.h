//
//  ShopTVC.h
//  Persolio
//
//  Created by Ali Soume`e on 5/10/1396 AP.
//  Copyright © 1396 Ali Soume`e. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopTVC : UITableViewCell <UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UILabel *titleLb;

@property (nonatomic, strong) NSArray *array;
@property (nonatomic, strong) NSString *title;

- (void)prepare;
@end
