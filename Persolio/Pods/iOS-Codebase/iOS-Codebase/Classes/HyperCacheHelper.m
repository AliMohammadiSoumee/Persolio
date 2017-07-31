//
//  HyperCacheHelper.m
//  mactehrannew
//
//  Created by hAmidReza on 5/24/17.
//  Copyright © 2017 archibits. All rights reserved.
//

#import "HyperCacheHelper.h"

@implementation HyperCacheHelper

+ (BOOL) pathExistInDocumentsDIR:(NSString*) path
{
	BOOL isDIR;
	
	if (! [[NSFileManager defaultManager] fileExistsAtPath:[HyperCacheHelper pathInDocumentDIR:path] isDirectory:&isDIR] )
		return false; ////no file or directory exist with name: "images"
	else
		return true;
}

+ (NSString *)pathInDocumentDIR:(NSString*)path
{
	NSString *_path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
	return [_path stringByAppendingPathComponent:path];
}

@end
