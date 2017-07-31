//
//  NSObject+DataObject.m
//  SetarehShowNew
//
//  Created by hAmidReza on 8/21/1393 AP.
//  Copyright (c) 1393 setarehsho.ir. All rights reserved.
//

#import "NSObject+DataObject.h"
#import <objc/runtime.h>

static char const * const ObjectDataKey = "MyObjectDataKey";

@implementation NSObject (NSObjectAdditions)
@dynamic objectData;
-(id)objectData {
	return objc_getAssociatedObject(self,ObjectDataKey);
}
- (void)setObjectData:(id)newObjectData {
	objc_setAssociatedObject(self, ObjectDataKey, newObjectData, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(void)setDataObject:(id)obj forKey:(NSString*)key
{
	objc_setAssociatedObject(self, [key UTF8String], obj, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(id)dataObjectForKey:(NSString*)key
{
	return objc_getAssociatedObject(self, [key UTF8String]);
}
@end
