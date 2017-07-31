//
//  HyperCacheHelper.h
//  mactehrannew
//
//  Created by hAmidReza on 5/24/17.
//  Copyright © 2017 archibits. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HyperCache.h"

#ifndef _strfmt
#define _strfmt(fmt,...) [NSString stringWithFormat:(fmt), ##__VA_ARGS__]
#endif

#ifndef _str_ok1
#define _str_ok1(str) (str && [str isKindOfClass:[NSString class]])
#endif

#ifndef _str_ok2
#define _str_ok2(str) (str && [str isKindOfClass:[NSString class]] && [str length] > 0)
#endif

#ifndef _threadingHelperMethods
static inline void _mainThread(dispatch_block_t block)
{
	if ([NSThread isMainThread]) {
		block();
	} else {
		dispatch_async(dispatch_get_main_queue(), block);
	}
}
#define _threadingHelperMethods
#endif

@interface HyperCacheHelper : NSObject

+ (BOOL) pathExistInDocumentsDIR:(NSString*) path;
+ (NSString *)pathInDocumentDIR:(NSString*)path;

@end
