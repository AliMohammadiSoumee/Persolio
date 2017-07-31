//
//  UIView+xsnapshot.m
//  Prediscore
//
//  Created by hAmidReza on 11/4/16.
//  Copyright © 2016 pxlmind. All rights reserved.
//

#import "UIView+xsnapshot.h"

@implementation UIView (xsnapshot)

-(UIImageView*)xsnapshotAfterScreenUpdates:(BOOL)after
{
	UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, [[UIScreen mainScreen] scale]);
	[self drawViewHierarchyInRect:CGRectMake(0, 0, self.bounds.size.width,  self.bounds.size.height) afterScreenUpdates:after];
	UIImage* snapshotImage = UIGraphicsGetImageFromCurrentImageContext();
	UIImageView* snapshot = [[UIImageView alloc] initWithFrame:self.bounds];
	snapshot.image = snapshotImage;
	return snapshot;
}


@end
