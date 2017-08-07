//
//  TestCVL.m
//  Persolio
//
//  Created by Ali Soume`e on 5/3/1396 AP.
//  Copyright © 1396 Ali Soume`e. All rights reserved.
//

#import "TestCVL.h"

@interface TestCVL()
{
    CGFloat yPos;
    NSMutableDictionary *layoutAttributes;
    CGFloat width;
}
@end


@implementation TestCVL


- (void)prepareLayout {
    
    layoutAttributes = [NSMutableDictionary new];
    width = self.collectionView.bounds.size.width;
    CGFloat horSpace = 10, verSpace = 10;
    yPos = verSpace;
    
    CGFloat bigCellWidth = width - 2 * horSpace;
    CGFloat bigCellHeight = bigCellWidth * 0.85;
    CGFloat smallCellWidth = (width - 2 * horSpace - 5) / 2;
    
    CGFloat xPos0 = horSpace, xPos1 = horSpace, xPos2 = horSpace + 5 + smallCellWidth;
    
    for (int section = 0; section < self.collectionView.numberOfSections; section++) {
        for (int row = 0; row < [self.collectionView numberOfItemsInSection:section]; row++) {
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
            UICollectionViewLayoutAttributes *att = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
            
            CGRect frame = CGRectZero;
            
            if (row % 3 == 0) {
                frame = CGRectMake(xPos0, yPos, bigCellWidth, bigCellHeight);
                yPos += bigCellHeight + verSpace;
            }
            else if (row % 3 == 1) {
                frame = CGRectMake(xPos1, yPos, smallCellWidth, smallCellWidth);
                if (row == [self.collectionView numberOfItemsInSection:section] - 1)
                    yPos += smallCellWidth + verSpace;
            }
            else {
                frame = CGRectMake(xPos2, yPos, smallCellWidth, smallCellWidth);
                yPos += smallCellWidth + verSpace;
            }
            att.frame = frame;
            NSString *itemKey = [self layoutKeyForIndexPath:indexPath];
            layoutAttributes[itemKey] = att;
        }
    }
}



- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(NSString *objects, NSDictionary *bindings) {
        UICollectionViewLayoutAttributes *layoutAttribute = layoutAttributes[objects];
        return CGRectIntersectsRect(rect, [layoutAttribute frame]);
    }];
    NSArray *matchingKeys = [[layoutAttributes allKeys] filteredArrayUsingPredicate:predicate];
    return [layoutAttributes objectsForKeys:matchingKeys notFoundMarker:[NSNull null]];
}


- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    NSString *headerKey = [self layoutKeyForHeaderAtIndexPath:indexPath];
    return layoutAttributes[headerKey];
}


- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath: (NSIndexPath *)indexPath {
    NSString *key = [self layoutKeyForIndexPath:indexPath];
    return layoutAttributes[key];
}



- (NSString *)layoutKeyForIndexPath:(NSIndexPath *)indexPath {
    return [NSString stringWithFormat:@"%ld_%ld", (long)indexPath.section, (long)indexPath.row];
}


- (NSString *)layoutKeyForHeaderAtIndexPath:(NSIndexPath *)indexPath {
    return [NSString stringWithFormat:@"s_%ld_%ld", (long)indexPath.section, (long)indexPath.row];
}


- (CGSize)collectionViewContentSize {
    return CGSizeMake(width, yPos);
}

@end
