//
//  MyCollectionViewLayoutBase.m
//  Prediscore
//
//  Created by Hamidreza Vaklian on 7/31/16.
//  Copyright © 2016 pxlmind. All rights reserved.
//

#import "MyCollectionViewLayoutBase.h"

@interface MyCollectionViewLayoutBase ()
{
	NSMutableDictionary* dicForLayoutAttributes;
	NSMutableArray* elementsInRectArray;
}

@end

@implementation MyCollectionViewLayoutBase

// just prevent from creating a NSMutableDictionary every time prepareLayout executes
-(NSMutableDictionary*)dicForLayoutAttributes
{
	if (!dicForLayoutAttributes)
		dicForLayoutAttributes = [NSMutableDictionary new];
	return dicForLayoutAttributes;
}

-(NSMutableArray*)elementsInRectArray
{
	if (!elementsInRectArray)
		elementsInRectArray = [NSMutableArray new];
	return elementsInRectArray;
}

- (NSString *)layoutKeyForIndexPath:(NSIndexPath *)indexPath
{
	return (NSString*)@( indexPath.section*100 + indexPath.row);
}

- (instancetype)init
{
	self = [super init];
	if (self) {
		[self initialize];
	}
	return self;
}

-(void)initialize
{
	
}

- (NSString *)layoutKeyForHeaderAtIndexPath:(NSIndexPath *)indexPath
{
	return [NSString stringWithFormat:@"s_%ld_%ld", indexPath.section, indexPath.row];
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath
{
	NSString *headerKey = [self layoutKeyForHeaderAtIndexPath:indexPath];
	return _layoutAttributes[headerKey];
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
	NSString *key = [self layoutKeyForIndexPath:indexPath];
	return _layoutAttributes[key];
}

- (CGSize)collectionViewContentSize
{
	return _contentSize;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
	NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(NSString *evaluatedObject, NSDictionary *bindings) {
		UICollectionViewLayoutAttributes *layoutAttribute = _layoutAttributes[evaluatedObject];
		return CGRectIntersectsRect(rect, [layoutAttribute frame]);
	}];
	
	NSArray *matchingKeys = [[_layoutAttributes allKeys] filteredArrayUsingPredicate:predicate];
	return [_layoutAttributes objectsForKeys:matchingKeys notFoundMarker:[NSNull null]];
}

-(id)attributesForItem:(NSInteger)item inSection:(NSInteger)section
{
	return [self attributesForItem:item inSection:section class:NULL];
}

-(id)attributesForItem:(NSInteger)item inSection:(NSInteger)section class:(Class)class
{
	
	NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item inSection:section];
	UICollectionViewLayoutAttributes *attributes;
	if (class == NULL)
		class = [UICollectionViewLayoutAttributes class];
	attributes = [class performSelector:@selector(layoutAttributesForCellWithIndexPath:) withObject:indexPath];
	attributes.indexPath = indexPath;
	NSString *key = [self layoutKeyForIndexPath:indexPath];
	self.layoutAttributes[key] = attributes;
	return attributes;
}

@end
