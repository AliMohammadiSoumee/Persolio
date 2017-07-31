//
//  HyperCache.h
//  Aiywa2
//
//  Created by hAmidReza on 2/17/17.
//  Copyright © 2017 nizek. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
	HyperCacheItemTypeImage = 1,
	HyperCacheItemTypeData = 2,
} HyperCacheItemType;

typedef enum : NSUInteger {
	HyperCacheStatusInvalidURL = 0,
	HyperCacheStatusCacheFoundButFileError = 1 << 0,
	HyperCacheStatusReadFromCache = 1 << 1,
	HyperCacheStatusSuccess = 1 << 2,
	HyperCacheStatusFailure = 1 << 3,
	HyperCacheStatusDownloaded = 1 << 4,
	HyperCacheStatusCached = 1 << 4,
	HyperCacheStatusConnectionError = 1 << 5,
	HyperCacheStatusWillStartFetch = 1 << 6,
	HyperCacheStatusUsedFailoverImage = 1 << 7,
} HyperCacheStatus;

typedef enum : NSUInteger {
	HyperCachePolicyCache = 0,
	HyperCachePolicyDefault = HyperCachePolicyCache,
	HyperCachePolicyNoCache = 1,
} HyperCachePolicy;

typedef enum : NSUInteger {
	HyperCacheCancelModeKill,
	HyperCacheCancelModeCancelCallback,
} HyperCacheCancelMode;

@interface HyperCache : NSObject

+(void)purgeAllCache;
+(void)purgeSomeCache;

+(void)cancelTask:(NSDictionary*)taskDic mode:(HyperCacheCancelMode)cancelMode;
+(void)cancelTasksInGroup:(NSString*)group;

+(NSDictionary*)DownloadWithURL:(NSString*)url type:(HyperCacheItemType)type callback:(void (^)(HyperCacheStatus status, id obj))callback;
+(NSDictionary*)DownloadWithURL:(NSString*)url type:(HyperCacheItemType)type tag:(NSString*)tag callback:(void (^)(HyperCacheStatus status, id obj))callback;
+(NSDictionary*)DownloadWithURL:(NSString*)url type:(HyperCacheItemType)type ttl:(NSUInteger)ttl callback:(void (^)(HyperCacheStatus status, id obj))callback;
+(NSDictionary*)DownloadWithURL:(NSString*)url type:(HyperCacheItemType)type tag:(NSString*)tag ttl:(NSUInteger)ttl callback:(void (^)(HyperCacheStatus status, id obj))callback;
+(NSDictionary*)DownloadWithURL:(NSString*)url type:(HyperCacheItemType)type tag:(NSString*)tag priority:(float)priority group:(NSString*)group callback:(void (^)(HyperCacheStatus status, id obj))callback;
+(NSDictionary*)DownloadFileWithURL:(NSString*)url type:(HyperCacheItemType)type tag:(NSString*)tag callback:(void (^)(HyperCacheStatus status, id obj))callback;
+(NSDictionary*)DownloadFileWithURL:(NSString*)url type:(HyperCacheItemType)type tag:(NSString*)tag group:(NSString*)group callback:(void (^)(HyperCacheStatus status, id obj))callback;
+(NSDictionary*)DownloadWithURL:(NSString*)url type:(HyperCacheItemType)type tag:(NSString*)tag imagePreprocessorBlock:(UIImage* (^)(UIImage*))imagePreprocessorBlock callback:(void (^)(HyperCacheStatus status, id obj))callback;
+(NSDictionary*)DownloadWithURL:(NSString*)url type:(HyperCacheItemType)type tag:(NSString*)tag imagePreprocessorBlock:(UIImage* (^)(UIImage*))imagePreprocessorBlock priority:(float)priority callback:(void (^)(HyperCacheStatus status, id obj))callback;
+(NSDictionary*)DownloadWithURL:(NSString*)url type:(HyperCacheItemType)type tag:(NSString*)tag priority:(float)priority callback:(void (^)(HyperCacheStatus status, id obj))callback;
+(NSDictionary*)DownloadFileWithURL:(NSString*)url type:(HyperCacheItemType)type tag:(NSString*)tag priority:(float)priority callback:(void (^)(HyperCacheStatus status, id obj))callback;
+(NSDictionary*)DownloadWithURL:(NSString*)url type:(HyperCacheItemType)type tag:(NSString*)tag imagePreprocessorBlock:(UIImage* (^)(UIImage*))imagePreprocessorBlock priority:(float)priority group:(NSString*)group callback:(void (^)(HyperCacheStatus status, id obj))callback;
@end

@interface UIImageView (HyperCache)

-(NSDictionary*)HyperCacheSetImageWithURL:(NSString*)url cachedImage:(UIImage*)cachedImage callback:(void (^)(HyperCacheStatus status, id obj))callback;
-(NSDictionary*)HyperCacheSetImageWithURL:(NSString*)url cachedImage:(UIImage*)cachedImage failoverImage:(UIImage*)failoverImage callback:(void (^)(HyperCacheStatus status, id obj))callback;
-(NSDictionary*)HyperCacheSetImageWithURL:(NSString*)url callback:(void (^)(HyperCacheStatus status, id obj))callback;
-(NSDictionary*)HyperCacheSetImageWithURL:(NSString*)url;
-(NSDictionary*)HyperCacheSetImageWithURL:(NSString*)url placeHolderImage:(UIImage*)placeHolderImage;
-(NSDictionary*)HyperCacheSetImageWithURL:(NSString*)url placeHolderImage:(UIImage*)placeHolderImage animationBlock:(void (^)(UIImageView* imageView, UIImage* image))animationBlock;
//-(NSDictionary*)HyperCacheSetImageWithURL:(NSString*)url tag:(NSString*)tag callback:(void (^)(HyperCacheStatus status, id obj))callback;
-(NSDictionary*)HyperCacheSetImageWithURL:(NSString*)url preprocessBlock:(id (^) (id))preprocessBlock;
-(NSDictionary*)HyperCacheSetImageWithURL:(NSString*)url placeHolderImage:(UIImage*)placeHolderImage cachedImage:(UIImage*)cachedImage callback:(void (^)(HyperCacheStatus status, id obj))callback;
-(NSDictionary*)HyperCacheSetImageWithURL:(NSString*)url placeHolderImage:(UIImage*)placeHolderImage cachedImage:(UIImage*)cachedImage animationBlock:(void (^)(UIImageView* imageView, UIImage* image))animationBlock callback:(void (^)(HyperCacheStatus status, id obj))callback;
-(NSDictionary*)HyperCacheSetImageWithURL:(NSString*)url cachedImage:(UIImage*)cachedImage postProcessBlock:(id (^) (id))postprocessBlock callback:(void (^)(HyperCacheStatus status, id obj))callback;
@end



