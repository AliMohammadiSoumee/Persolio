//
//  MyCollectionViewLayoutBase.h
//  Prediscore
//
//  Created by Hamidreza Vaklian on 7/31/16.
//  Copyright © 2016 pxlmind. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCollectionViewLayoutBase : UICollectionViewLayout

- (NSString *)layoutKeyForIndexPath:(NSIndexPath *)indexPath;
- (NSString *)layoutKeyForHeaderAtIndexPath:(NSIndexPath *)indexPath;

@property (retain, nonatomic) NSMutableDictionary *layoutAttributes;
@property (assign, nonatomic) CGSize contentSize;

@end
