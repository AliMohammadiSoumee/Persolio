//
//  HyperCache.m
//  Aiywa2
//
//  Created by hAmidReza on 2/17/17.
//  Copyright © 2017 nizek. All rights reserved.
//

#import "HyperCache.h"
#import "HyperCacheModel.h"
#import "HyperCacheHelper.h"
#import "Codebase_definitions.h"
#import "NSObject+md5.h"
#import "NSObject+dataobject.h"

typedef enum : NSUInteger {
	HyperCacheOptionsIsImageTask = 0,
	HyperCacheOptionsImageView = 1 << 0,
} HyperCacheOptions;

#define _taskDic_callbacks_key @"__callbacks"
#define _taskDic_linkedImageViews_key @"__linkedImageViews"

#define _general_cache_dir_name @"__all__"

//ANIMATION CONSTANTS
#define _setImage_default_animation_enabled	YES
#define _setImage_default_should_fade		YES
#define _setImage_default_should_enlarge	YES
#define _setImage_default_duration			.30f
#define _setImage_default_fade_fromValue	0.0f
#define _setImage_default_enlarge_fromValue 1.3

#define _callback_safe(status, obj) if(callback) callback(status, obj);

#define _default_task_priority	NSURLSessionTaskPriorityDefault

typedef enum : NSUInteger {
	HyperCacheCallbackModeDefault, //returns NSData; if the type is image, returns uiimage
	HyperCacheCallbackModeFile, //returns the path of the downloaded file
} HyperCacheCallbackMode;


@interface NSString (Paths)

- (NSString*)stringWithPathRelativeTo:(NSString*)anchorPath;

@end

@implementation NSString (Paths)

- (NSString*)stringWithPathRelativeTo:(NSString*)anchorPath {
	NSArray *pathComponents = [self pathComponents];
	NSArray *anchorComponents = [anchorPath pathComponents];
	
	NSInteger componentsInCommon = MIN([pathComponents count], [anchorComponents count]);
	for (NSInteger i = 0, n = componentsInCommon; i < n; i++) {
		if (![[pathComponents objectAtIndex:i] isEqualToString:[anchorComponents objectAtIndex:i]]) {
			componentsInCommon = i;
			break;
		}
	}
	
	NSUInteger numberOfParentComponents = [anchorComponents count] - componentsInCommon;
	NSUInteger numberOfPathComponents = [pathComponents count] - componentsInCommon;
	
	NSMutableArray *relativeComponents = [NSMutableArray arrayWithCapacity:
										  numberOfParentComponents + numberOfPathComponents];
	for (NSInteger i = 0; i < numberOfParentComponents; i++) {
		[relativeComponents addObject:@".."];
	}
	[relativeComponents addObjectsFromArray:
	 [pathComponents subarrayWithRange:NSMakeRange(componentsInCommon, numberOfPathComponents)]];
	return [NSString pathWithComponents:relativeComponents];
}

@end

@implementation HyperCache

static NSLock* ongoingTasksLock;
static NSLock* imageViewCallbacksLock;

+(void)load
{
	[super load];
	
	ongoingTasksLock = [NSLock new];
	imageViewCallbacksLock = [NSLock new];
}

+(NSMutableDictionary*)ongoingTasks
{
	static NSMutableDictionary* ongoingTasks;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		ongoingTasks = [NSMutableDictionary new];
	});
	//	NSLog(@"ongoingTasks===> %@", ongoingTasks);
	return ongoingTasks;
}

+(NSMutableDictionary*)imageViewCallbacks
{
	static NSMutableDictionary* imageViewCallbacks;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		imageViewCallbacks = [NSMutableDictionary new];
	});
	//	NSLog(@"imageViewCallbacks ===> %@", imageViewCallbacks);
	return imageViewCallbacks;
}

+(NSURLSession*)session
{
	static NSURLSession* session;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
		session = [NSURLSession sessionWithConfiguration:sessionConfig delegate:nil delegateQueue:nil];
	});
	return session;
}


+(NSDictionary*)DownloadWithURL:(NSString*)url type:(HyperCacheItemType)type callback:(void (^)(HyperCacheStatus status, id obj))callback
{
	//	return [HyperCache DownloadWithURL:url type:type options:nil callback:callback];
	
	return [HyperCache DownloadWithURL:url type:type isImageTask:NO imageView:nil preprocessBlock:nil postprocessBlock:nil callbackMode:HyperCacheCallbackModeDefault group:nil tag:nil ttl:0 cacheOptions:HyperCachePolicyDefault priority:NSURLSessionTaskPriorityDefault callback:callback];
}

+(NSDictionary*)DownloadWithURL:(NSString*)url type:(HyperCacheItemType)type tag:(NSString*)tag imagePreprocessorBlock:(UIImage* (^)(UIImage*))imagePreprocessorBlock priority:(float)priority group:(NSString*)group callback:(void (^)(HyperCacheStatus status, id obj))callback
{
	//	NSMutableDictionary* options = [NSMutableDictionary new];
	//	options[@"tag"] = _str_safe(tag);
	//	options[@"taskPriority"] = @(priority);
	//	options[@"group"] = group;
	//
	//	if (imagePreprocessorBlock)
	//		options[@"imagePreprocessBlock"] = imagePreprocessorBlock;
	//	return [HyperCache DownloadWithURL:url type:type options:options callback:callback];
	//
	return [HyperCache DownloadWithURL:url type:type isImageTask:NO imageView:nil preprocessBlock:imagePreprocessorBlock postprocessBlock:nil callbackMode:HyperCacheCallbackModeDefault group:group tag:tag ttl:0 cacheOptions:HyperCachePolicyDefault priority:priority callback:callback];
}

+(NSDictionary*)DownloadWithURL:(NSString*)url type:(HyperCacheItemType)type tag:(NSString*)tag imagePreprocessorBlock:(UIImage* (^)(UIImage*))imagePreprocessorBlock priority:(float)priority callback:(void (^)(HyperCacheStatus status, id obj))callback
{
	//	NSMutableDictionary* options = [NSMutableDictionary new];
	//	options[@"tag"] = _str_safe(tag);
	//	options[@"taskPriority"] = @(priority);
	//
	//	if (imagePreprocessorBlock)
	//		options[@"imagePreprocessBlock"] = imagePreprocessorBlock;
	//	return [HyperCache DownloadWithURL:url type:type options:options callback:callback];
	
	return [HyperCache DownloadWithURL:url type:type isImageTask:NO imageView:nil preprocessBlock:imagePreprocessorBlock postprocessBlock:nil callbackMode:HyperCacheCallbackModeDefault group:nil tag:tag ttl:0 cacheOptions:HyperCachePolicyDefault priority:priority callback:callback];
}


+(NSDictionary*)DownloadWithURL:(NSString*)url type:(HyperCacheItemType)type tag:(NSString*)tag imagePreprocessorBlock:(UIImage* (^)(UIImage*))imagePreprocessorBlock callback:(void (^)(HyperCacheStatus status, id obj))callback
{
	//	NSMutableDictionary* options = [NSMutableDictionary new];
	//	options[@"tag"] = _str_safe(tag);
	//
	//	if (imagePreprocessorBlock)
	//		options[@"imagePreprocessBlock"] = imagePreprocessorBlock;
	//	return [HyperCache DownloadWithURL:url type:type options:options callback:callback];
	
	
	return [HyperCache DownloadWithURL:url type:type isImageTask:NO imageView:nil preprocessBlock:imagePreprocessorBlock postprocessBlock:nil callbackMode:HyperCacheCallbackModeDefault group:nil tag:tag ttl:0 cacheOptions:HyperCachePolicyDefault priority:NSURLSessionTaskPriorityDefault callback:callback];
}

+(NSDictionary*)DownloadWithURL:(NSString*)url type:(HyperCacheItemType)type tag:(NSString*)tag callback:(void (^)(HyperCacheStatus status, id obj))callback
{
	//	return [HyperCache DownloadWithURL:url type:type options:@{@"tag":_str_safe(tag)} callback:callback];
	
	return [HyperCache DownloadWithURL:url type:type isImageTask:NO imageView:nil preprocessBlock:nil postprocessBlock:nil callbackMode:HyperCacheCallbackModeDefault group:nil tag:tag ttl:0 cacheOptions:HyperCachePolicyDefault priority:NSURLSessionTaskPriorityDefault callback:callback];
}

+(NSDictionary*)DownloadWithURL:(NSString*)url type:(HyperCacheItemType)type tag:(NSString*)tag priority:(float)priority callback:(void (^)(HyperCacheStatus status, id obj))callback
{
	//	NSMutableDictionary* options = [NSMutableDictionary new];
	//	options[@"taskPriority"] = @(priority);
	//	options[@"tag"] = _str_safe(tag);
	//	return [HyperCache DownloadWithURL:url type:type options:options callback:callback];
	
	
	return [HyperCache DownloadWithURL:url type:type isImageTask:NO imageView:nil preprocessBlock:nil postprocessBlock:nil callbackMode:HyperCacheCallbackModeDefault group:nil tag:tag ttl:0 cacheOptions:HyperCachePolicyDefault priority:priority callback:callback];
}

+(NSDictionary*)DownloadWithURL:(NSString*)url type:(HyperCacheItemType)type tag:(NSString*)tag priority:(float)priority group:(NSString*)group callback:(void (^)(HyperCacheStatus status, id obj))callback
{
	//	NSMutableDictionary* options = [NSMutableDictionary new];
	//	options[@"taskPriority"] = @(priority);
	//	options[@"tag"] = _str_safe(tag);
	//	options[@"group"] = group;
	//	return [HyperCache DownloadWithURL:url type:type options:options callback:callback];
	//
	return [HyperCache DownloadWithURL:url type:type isImageTask:NO imageView:nil preprocessBlock:nil postprocessBlock:nil callbackMode:HyperCacheCallbackModeDefault group:group tag:tag ttl:0 cacheOptions:HyperCachePolicyDefault priority:priority callback:callback];
}

+(NSDictionary*)DownloadFileWithURL:(NSString*)url type:(HyperCacheItemType)type tag:(NSString*)tag priority:(float)priority callback:(void (^)(HyperCacheStatus status, id obj))callback
{
	//	NSMutableDictionary* options = [NSMutableDictionary new];
	//	options[@"taskPriority"] = @(priority);
	//	options[@"tag"] = _str_safe(tag);
	//	options[@"callbackMode"] = @(HyperCacheCallbackModeFile);
	//	return [HyperCache DownloadWithURL:url type:type options:options callback:callback];
	
	return [HyperCache DownloadWithURL:url type:type isImageTask:NO imageView:nil preprocessBlock:nil postprocessBlock:nil callbackMode:HyperCacheCallbackModeFile group:nil tag:tag ttl:0 cacheOptions:HyperCachePolicyDefault priority:priority callback:callback];
}

+(NSDictionary*)DownloadFileWithURL:(NSString*)url type:(HyperCacheItemType)type tag:(NSString*)tag callback:(void (^)(HyperCacheStatus status, id obj))callback
{
	//	return [HyperCache DownloadWithURL:url type:type options:@{@"tag":_str_safe(tag), @"callbackMode": @(HyperCacheCallbackModeFile)} callback:callback];
	
	return [HyperCache DownloadWithURL:url type:type isImageTask:NO imageView:nil preprocessBlock:nil postprocessBlock:nil callbackMode:HyperCacheCallbackModeFile group:nil tag:tag ttl:0 cacheOptions:HyperCachePolicyDefault priority:NSURLSessionTaskPriorityDefault callback:callback];
}

+(NSDictionary*)DownloadFileWithURL:(NSString*)url type:(HyperCacheItemType)type tag:(NSString*)tag group:(NSString*)group callback:(void (^)(HyperCacheStatus status, id obj))callback
{
	//	NSMutableDictionary* options = [NSMutableDictionary new];
	//	options[@"tag"] = _str_safe(tag);
	//	options[@"callbackMode"] = @(HyperCacheCallbackModeFile);
	//	options[@"group"] = group;
	//	return [HyperCache DownloadWithURL:url type:type options:options callback:callback];
	
	return [HyperCache DownloadWithURL:url type:type isImageTask:NO imageView:nil preprocessBlock:nil postprocessBlock:nil callbackMode:HyperCacheCallbackModeFile group:group tag:tag ttl:0 cacheOptions:HyperCachePolicyDefault priority:NSURLSessionTaskPriorityDefault callback:callback];
}

+(NSDictionary*)DownloadWithURL:(NSString*)url type:(HyperCacheItemType)type ttl:(NSUInteger)ttl callback:(void (^)(HyperCacheStatus status, id obj))callback
{
	//	return [HyperCache DownloadWithURL:url type:type options:@{@"ttl":@(ttl)} callback:callback];
	
	return [HyperCache DownloadWithURL:url type:type isImageTask:NO imageView:nil preprocessBlock:nil postprocessBlock:nil callbackMode:HyperCacheCallbackModeDefault group:nil tag:nil ttl:ttl cacheOptions:HyperCachePolicyDefault priority:NSURLSessionTaskPriorityDefault callback:callback];
}

+(NSDictionary*)DownloadWithURL:(NSString*)url type:(HyperCacheItemType)type tag:(NSString*)tag ttl:(NSUInteger)ttl callback:(void (^)(HyperCacheStatus status, id obj))callback
{
	//	return [HyperCache DownloadWithURL:url type:type options:@{@"tag": _str_safe(tag), @"ttl":@(ttl)} callback:callback];
	
	return [HyperCache DownloadWithURL:url type:type isImageTask:NO imageView:nil preprocessBlock:nil postprocessBlock:nil callbackMode:HyperCacheCallbackModeDefault group:nil tag:tag ttl:ttl cacheOptions:HyperCachePolicyDefault priority:NSURLSessionTaskPriorityDefault callback:callback];
}

+(void)cancelTask:(NSDictionary*)taskDic mode:(HyperCacheCancelMode)cancelMode
{
	if (!taskDic)
		return;
	
	if (cancelMode == HyperCacheCancelModeKill)
	{
		[taskDic[_taskDic_callbacks_key] removeAllObjects];
		[taskDic[_taskDic_linkedImageViews_key] removeAllObjects];
		[taskDic[@"task"] cancel];
		[HyperCache removeTaskDicFromOngoings:taskDic];
	}
	else if (cancelMode == HyperCacheCancelModeCancelCallback)
	{
		[taskDic[_taskDic_callbacks_key] removeAllObjects];
		[taskDic[_taskDic_linkedImageViews_key] removeAllObjects];
	}
}

+(void)cancelTasksInGroup:(NSString*)group
{
	if (!_str_ok1(group))
		return;
	
	
	[ongoingTasksLock lock];
	NSArray* ongoingTasks = [[HyperCache ongoingTasks] allValues];
	[ongoingTasksLock unlock];
	
	for (NSMutableDictionary* taskDic in ongoingTasks)
		if ([taskDic[@"group"] isEqualToString:group])
		{
			[taskDic[_taskDic_callbacks_key] removeAllObjects];
			[taskDic[_taskDic_linkedImageViews_key] removeAllObjects];
			[taskDic[@"task"] cancel];
			[HyperCache removeTaskDicFromOngoings:taskDic];
		}
}


//THREAD SAFE
+(NSDictionary*)DownloadWithURL:(NSString*)url type:(HyperCacheItemType)type isImageTask:(BOOL)isImageTask imageView:(UIImageView*)imageView preprocessBlock:(id (^) (id))preprocessBlock postprocessBlock:(id (^) (id))postprocessBlock callbackMode:(HyperCacheCallbackMode)callbackMode group:(NSString*)group tag:(NSString*)tag ttl:(NSUInteger)ttl cacheOptions:(HyperCachePolicy)cacheOptions priority:(float)priority callback:(void (^)(HyperCacheStatus status, id obj))callback
{
	if (!_str_ok2(url))
	{
		_callback_safe(HyperCacheStatusFailure | HyperCacheStatusInvalidURL, nil);
		return nil;
	}
	
	//CHECK IF WE HAVE CACHED THIS FILE BEFORE
	NSDictionary* cacheItem = [HyperCacheModel cacheItemForURL:url];
	if (cacheItem)
	{
		// WE MUST DETACH THE IMAGEVIEW FROM IMAGEVIEWCALLBACKS TO AVOID REDUNDANT IMAGE SETTING
		if (isImageTask)
		{
			NSAssert(imageView, @"HyperCache: imageView is null. When imageTask is set to true; you have to provide imageView");
			[HyperCache detachImageViewFromImageViewCallbacks:imageView];
		}
		
		dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
			NSString* relativePath = cacheItem[@"path"];
			NSString* path = [NSHomeDirectory() stringByAppendingPathComponent:relativePath];
			
			if (callbackMode == HyperCacheCallbackModeDefault)
			{
				
				NSError* error;
				NSData* data = [NSData dataWithContentsOfFile:path options:NSDataReadingUncached error:&error];
				if (!error)
				{
					[HyperCacheModel updateLastAccessTimeWithID:[cacheItem[@"id"] unsignedIntegerValue]];
					if (type == HyperCacheItemTypeImage)
					{
						UIImage* image = [UIImage imageWithData:data];
						if (postprocessBlock)
							image = postprocessBlock(image);
						_callback_safe(HyperCacheStatusSuccess | HyperCacheStatusReadFromCache, image);
					}
					else if (type == HyperCacheItemTypeData)
					{
						_callback_safe(HyperCacheStatusSuccess | HyperCacheStatusReadFromCache, data);
					}
				}
				else
				{
					_callback_safe(HyperCacheStatusFailure | HyperCacheStatusCacheFoundButFileError, error);
					//					return nil;
				}
				
			}
			else if (callbackMode == HyperCacheCallbackModeFile)
			{
				_callback_safe(HyperCacheStatusSuccess | HyperCacheStatusReadFromCache, path);
			}
		});
		
		return nil;
	}
	else //NO CACHE FOUND FOR THE URL
	{
		NSMutableDictionary* possibleTaskDic = [HyperCache taskForURL:url];
		if (possibleTaskDic) // FOUND AN ONGOING TASK FOR THIS URL, ATTACH THE CALLBACK TO IT
		{
			if (isImageTask) // ATTACH TO IMAGEVIEWCALLBACKS
			{
				NSAssert(imageView, @"imageview is nil");
				[HyperCache attachImageView:imageView toTaskDictionary:possibleTaskDic];
				[HyperCache attachCallbackToImageViewCallbacks:imageView url:possibleTaskDic[@"url"] postprocessBlock:postprocessBlock callback:callback];
				return possibleTaskDic;
			}
			else // ATTACH TO ORDINARY CALLBACKS
			{
				[HyperCache attachCallback:callback toTaskDictionary:possibleTaskDic];
				return possibleTaskDic;
			}
		}
		else // NO CAHCE, NO ONGOING TASK: WE HAVE TO INITIATE THE TASK
		{
			NSMutableDictionary* taskDic = [HyperCache newTaskDicWithURL:url];
			[HyperCache addTaskDicToOngoings:taskDic withURL:url];
			
			//			NSString* possibleGroup = [HyperCache _options_group:options];
			//			if (group)
			//			{
			taskDic[@"group"] = group;
			//			}
			
			if (isImageTask) // ATTACH TO IMAGEVIEWCALLBACKS
			{
				NSAssert(imageView, @"imageview is nil");
				[HyperCache attachImageView:imageView toTaskDictionary:taskDic];
				[HyperCache attachCallbackToImageViewCallbacks:imageView url:taskDic[@"url"] postprocessBlock:postprocessBlock callback:callback];
			}
			else // ATTACH TO ORDINARY CALLBACKS
			{
				[HyperCache attachCallback:callback toTaskDictionary:taskDic];
			}
			
			NSURLSessionTask* task = [[HyperCache session] dataTaskWithURL:[NSURL URLWithString:url] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
				NSHTTPURLResponse* resp = (NSHTTPURLResponse*)response;
				if (resp.statusCode == 200 && data.length)
				{
					// EXECUTE CALLBACKS
					id resultObj = data;
					
					if (type == HyperCacheItemTypeImage)
						resultObj = [UIImage imageWithData:data];
					
					if (callbackMode == HyperCacheCallbackModeDefault)
					{
						if (preprocessBlock)
						{
							resultObj = preprocessBlock(resultObj);
							
							if (type == HyperCacheItemTypeImage)
							{
								NSAssert([resultObj isKindOfClass:[UIImage class]], @"HyperCache: image preprocessor block didn't return a valid UIImage* object");
								
								UIImage* theResultingImage = resultObj;
								data = UIImageJPEGRepresentation(theResultingImage, 1.0);
							}
							
						}
					}
					
					// WRITE TO DISK
					NSUInteger fileSize = data.length;
					
					NSString* path = [HyperCache determinePathForItemWithTag:tag ttl:ttl fileSize:fileSize url:url];
					
					
					BOOL cached = false;
					if (cacheOptions == HyperCachePolicyCache)
					{
						
						BOOL writtenSuccessfully = [data writeToFile:path atomically:YES];
						
						if (writtenSuccessfully)
						{
							NSString* relativePath = [path stringWithPathRelativeTo:NSHomeDirectory()];
							cached = [HyperCacheModel sync_insertNewCacheItemWithURL:url md5:[url MD5] type:type fileSize:data.length serverContentType:nil ttl:ttl tag:tag path:relativePath];
						}
					}
					
					if (callbackMode == HyperCacheCallbackModeDefault)
					{
						[HyperCache executeCallbacksForTaskWithDic:taskDic status:HyperCacheStatusSuccess | HyperCacheStatusDownloaded | (cached ? HyperCacheStatusCached : 0) andObj:resultObj];
						
						[HyperCache executeImageCallbacksForTaskWithDic:taskDic status:HyperCacheStatusSuccess | HyperCacheStatusDownloaded | (cached ? HyperCacheStatusCached : 0) andObj:resultObj];
					}
					else if (callbackMode == HyperCacheCallbackModeFile)
					{
						NSAssert(cacheOptions == HyperCachePolicyCache, @"HyperCache: <no cache> is not supported when using downloadfile...");
						
						[HyperCache executeCallbacksForTaskWithDic:taskDic status:HyperCacheStatusSuccess | HyperCacheStatusDownloaded | (cached ? HyperCacheStatusCached : 0) andObj:path];
					}
				}
				else
				{
					if (error.code == NSURLErrorCancelled)
					{
						// DO NOTHING
					}
					else if (error.code == NSURLErrorTimedOut)
					{
						NSLog(@"here!!!");
					}
					else
					{
						
						[HyperCache executeCallbacksForTaskWithDic:taskDic status:HyperCacheStatusFailure | HyperCacheStatusConnectionError andObj:error];
						
						[HyperCache executeImageCallbacksForTaskWithDic:taskDic status:HyperCacheStatusFailure | HyperCacheStatusConnectionError andObj:error];
					}
				}
				
				[HyperCache removeTaskDicFromOngoings:taskDic];
				
			}];
			
			taskDic[@"task"] = task;
			
			task.priority = priority;
			
			[task resume];
			
			return taskDic;
		}
	}
	
	return nil;
}

+(void)addTaskDicToOngoings:(NSDictionary*)taskDic withURL:(NSString*)url
{
	[ongoingTasksLock lock];
	[HyperCache ongoingTasks][url] = taskDic;
	[ongoingTasksLock unlock];
}

+(void)removeTaskDicFromOngoings:(NSDictionary*)taskDic
{
	[ongoingTasksLock lock];
	[[HyperCache ongoingTasks] removeObjectForKey:taskDic[@"url"]];
	[ongoingTasksLock unlock];
}

+(void)executeCallbacksForTaskWithDic:(NSDictionary*)taskDic status:(HyperCacheStatus)status andObj:(id)obj
{
	NSMutableArray* callbacks = taskDic[_taskDic_callbacks_key];
	for (void (^cb)(HyperCacheStatus status, id obj) in callbacks)
	{
		cb(status, obj);
	}
}

+(void)executeImageCallbacksForTaskWithDic:(NSDictionary*)taskDic status:(HyperCacheStatus)status andObj:(id)obj
{
	[imageViewCallbacksLock lock];
	NSMutableDictionary* imageViewCallbacks = [HyperCache imageViewCallbacks];
	NSMutableArray* linkedImageViews = taskDic[_taskDic_linkedImageViews_key];
	for (NSString* imageViewIdent in linkedImageViews) {
		if (imageViewCallbacks[imageViewIdent] && [imageViewCallbacks[imageViewIdent][@"url"] isEqualToString:taskDic[@"url"]])
		{
			void (^cb)(HyperCacheStatus status, id obj) = imageViewCallbacks[imageViewIdent][@"callback"];
			
			if (_block_ok(imageViewCallbacks[imageViewIdent][@"postprocessBlock"]) && _uiimage_ok(obj))
			{
				UIImage* (^postprocess)(UIImage*) = imageViewCallbacks[imageViewIdent][@"postprocessBlock"];
				obj = postprocess(obj);
			}
			
			cb(status, obj);
			[imageViewCallbacks removeObjectForKey:imageViewIdent];
		}
	}
	[imageViewCallbacksLock unlock];
}

// IT ALSO PREPARES THE DIRECTORY WHICH THE FILE WILL BE SAVED IN
+(NSString*)determinePathForItemWithTag:(NSString*)tag ttl:(NSUInteger)ttl fileSize:(NSUInteger)fileSize url:(NSString*)url
{
	//preserve extension for file mode
	NSString* filename = _strfmt(@"%@.%@", [url MD5], [url pathExtension]);
	
	if (_str_ok2(tag))
	{
		[HyperCache createDirectoryInCachesDIR:tag];
		NSString* destDIRPath = [HyperCache pathInCachesDIR:tag];
		NSString* path = [destDIRPath stringByAppendingPathComponent:filename];
		return path;
	}
	else
	{
		[HyperCache createDirectoryInCachesDIR:_general_cache_dir_name];
		NSString* destDIRPath = [HyperCache pathInCachesDIR:_general_cache_dir_name];
		NSString* path = [destDIRPath stringByAppendingPathComponent:filename];
		return path;
	}
}

+(NSMutableDictionary*)taskForURL:(NSString*)url
{
	[ongoingTasksLock lock];
	id result = [HyperCache ongoingTasks][url];
	[ongoingTasksLock unlock];
	return result;
}

+(void)attachCallback:(void (^)(HyperCacheStatus status, id obj))callback toTaskDictionary:(NSMutableDictionary*)taskDic
{
	NSMutableArray* callbacks =  taskDic[_taskDic_callbacks_key];
	[callbacks addObject:callback];
}

+(void)attachImageView:(UIImageView*)imageView toTaskDictionary:(NSMutableDictionary*)taskDic
{
	
	NSString* imageView_unique_ident = [HyperCache uniqueIdentForImageView:imageView];
	NSMutableArray* linkedImageViews =  taskDic[_taskDic_linkedImageViews_key];
	[linkedImageViews addObject:imageView_unique_ident];
}

//+(void)attachImageCallback:(void (^)(HyperCacheStatus status, id obj))callback imageView:(UIImageView*)imageView toTaskDictionary:(NSMutableDictionary*)taskDic
//{
//
//	NSString* imageView_unique_ident = [HyperCache uniqueIdentForImageView:imageView];
//	NSMutableArray* linkedImageViews =  taskDic[_taskDic_linkedImageViews_key];
//	[linkedImageViews addObject:imageView_unique_ident];
//}

+(NSMutableDictionary*)newTaskDicWithURL:(NSString*)url
{
	NSMutableDictionary* task = [NSMutableDictionary new];
	task[@"url"] = url;
	task[_taskDic_callbacks_key] = [NSMutableArray new];
	task[_taskDic_linkedImageViews_key] = [NSMutableArray new];
	return task;
}

//+(NSString*)_options_tag:(NSDictionary*)options
//{
//	if (_str_ok1(options[@"tag"]))
//		return options[@"tag"];
//	else
//		return nil;
//}
//
//+(UIImage* (^)(UIImage*))_options_imagePreprocessBlock:(NSDictionary*)options
//{
//	UIImage* (^result)(UIImage*) = options[@"imagePreprocessBlock"];
//	return result;
//}

//+(NSUInteger)_options_ttl:(NSDictionary*)options
//{
//	if (_dic_ok(options, @"ttl") && [options[@"ttl"] isKindOfClass:[NSNumber class]])
//		return [options[@"ttl"] unsignedIntegerValue];
//	else
//		return 0;
//}
//
//+(HyperCacheCallbackMode)_options_callbackMode:(NSDictionary*)options
//{
//	HyperCacheCallbackMode result = HyperCacheCallbackModeDefault;
//	if (_dic_ok(options, @"callbackMode"))
//		result = [options[@"callbackMode"] unsignedIntegerValue];
//
//	return result;
//}
//
//+(NSString*)_options_group:(NSDictionary*)options
//{
//	if (_str_ok1(options[@"group"]))
//		return options[@"group"];
//	else
//		return nil;
//}
//
//+(BOOL)_options_isImageTask:(NSDictionary*)options
//{
//	if (_dic_ok(options, @"isImageTask") && [options[@"isImageTask"] boolValue])
//		return YES;
//	else
//		return NO;
//}
//
//+(float)_options_taskPriority:(NSDictionary*)options
//{
//	if (_dic_ok(options, @"taskPriority"))
//		return [options[@"taskPriority"] floatValue];
//	else
//		return _default_task_priority;
//}
//
//+(HyperCachePolicy)_options_cachePolicy:(NSDictionary*)options
//{
//	if (_dic_ok(options, @"policy") && [options[@"policy"] isKindOfClass:[NSNumber class]])
//		return [options[@"policy"] unsignedIntegerValue];
//	else
//		return HyperCachePolicyCache;
//}
//
//+(UIImageView*)_options_imageView:(NSDictionary*)options
//{
//	if (_dic_ok(options, @"imageView") && [options[@"imageView"] isKindOfClass:[UIImageView class]])
//		return options[@"imageView"];
//	else
//		return nil;
//}

+(void)attachCallbackToImageViewCallbacks:(UIImageView*)imageView url:(NSString*)url postprocessBlock:(id (^) (id))postprocessBlock callback:(void (^)(HyperCacheStatus status, id obj))callback
{
	[imageViewCallbacksLock lock];
	NSMutableDictionary* imageViewCallbacks = [HyperCache imageViewCallbacks];
	id _postprocessBlock_obj = postprocessBlock;
	if (!_postprocessBlock_obj)
		_postprocessBlock_obj = [NSNull null];
	imageViewCallbacks[[HyperCache uniqueIdentForImageView:imageView]] = @{@"url": url, @"callback": callback, @"postprocessBlock": _postprocessBlock_obj};
	[imageViewCallbacksLock unlock];
}

+(void)detachImageViewFromImageViewCallbacks:(UIImageView*)imageView
{
	[imageViewCallbacksLock lock];
	NSMutableDictionary* imageViewCallbacks = [HyperCache imageViewCallbacks];
	[imageViewCallbacks removeObjectForKey:[HyperCache uniqueIdentForImageView:imageView]];
	[imageViewCallbacksLock unlock];
}

+(void)purgeAllCache
{
	NSMutableArray* allCacheItems = [HyperCacheModel allCacheItems];
	for (NSDictionary* cacheItem in allCacheItems)
	{
		NSString* relativePath = cacheItem[@"path"];
		NSString* path = [NSHomeDirectory() stringByAppendingPathComponent:relativePath];
		NSError* error;
		[[NSFileManager defaultManager] removeItemAtPath:path error:&error];
		if (!error)
		{
			[HyperCacheModel sync_deleteCacheItemWithID:[cacheItem[@"id"] unsignedIntegerValue]];
		}
		else
		{
			NSLog(@"HyperCache: purgeAllCache: could not remove item: %@ (error:%@)", path, error.localizedDescription);
		}
	}
}

+ (NSInteger)daysBetweenDate:(NSDate*)fromDateTime andDate:(NSDate*)toDateTime
{
	NSDate *fromDate;
	NSDate *toDate;
	
	NSCalendar *calendar = [NSCalendar currentCalendar];
	
	[calendar rangeOfUnit:NSCalendarUnitDay startDate:&fromDate
				 interval:NULL forDate:fromDateTime];
	[calendar rangeOfUnit:NSCalendarUnitDay startDate:&toDate
				 interval:NULL forDate:toDateTime];
	
	NSDateComponents *difference = [calendar components:NSCalendarUnitDay
											   fromDate:fromDate toDate:toDate options:0];
	
	return [difference day];
}

+(void)purgeSomeCache
{
	NSDate* dt = [NSDate date];
	
	NSMutableArray* allCacheItems = [HyperCacheModel allCacheItems];
	for (NSDictionary* cacheItem in allCacheItems)
	{
		if (([cacheItem[@"tag"] isEqualToString:@"feed_video"] || [cacheItem[@"tag"] isEqualToString:@"feed_image"]) &&
			[HyperCache daysBetweenDate:dt andDate:cacheItem[@"creationTime"]] > 2)
		{
			NSString* relativePath = cacheItem[@"path"];
			NSString* path = [NSHomeDirectory() stringByAppendingPathComponent:relativePath];
			NSError* error;
			[[NSFileManager defaultManager] removeItemAtPath:path error:&error];
			if (!error)
			{
				[HyperCacheModel deleteCacheItemWithID:[cacheItem[@"id"] unsignedIntegerValue]];
			}
			else
			{
				NSLog(@"HyperCache: purgeAllCache: could not remove item: %@ (error:%@)", path, error.localizedDescription);
			}
		}
	}
}



//////////////// file handlings
+(NSString*)pathInCachesDIR:(NSString*)path
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *cacheDirectory = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"HyperCache"];
	return [cacheDirectory stringByAppendingPathComponent:path];
}

+(BOOL)createDirectoryInCachesDIR:(NSString*)path
{
	return [[NSFileManager defaultManager] createDirectoryAtPath:[HyperCache pathInCachesDIR:path] withIntermediateDirectories:YES attributes:nil error:nil] ;
}

+(NSString*)uniqueIdentForImageView:(UIImageView*)imageView
{
	NSString* uniqueIdent = [imageView dataObjectForKey:@"_uniqueIdent"];
	if (!uniqueIdent)
	{
		uniqueIdent = _strfmt(@"%p", imageView);
		[imageView setDataObject:uniqueIdent forKey:@"_uniqueIdent"];
	}
	
	return uniqueIdent;
}

@end

@implementation UIImageView (HyperCache)

-(NSDictionary*)HyperCacheSetImageWithURL:(NSString*)url cachedImage:(UIImage*)cachedImage callback:(void (^)(HyperCacheStatus status, id obj))callback
{
	return [self HyperCacheSetImageWithURL:url cachedImage:cachedImage failoverImage:nil callback:callback];
}

-(NSDictionary*)HyperCacheSetImageWithURL:(NSString*)url placeHolderImage:(UIImage*)placeHolderImage cachedImage:(UIImage*)cachedImage callback:(void (^)(HyperCacheStatus status, id obj))callback
{
	return [self HyperCacheSetImageWithURL:url placeHolderImage:placeHolderImage cachedImage:cachedImage preprocessBlock:nil failoverImage:nil postProcessBlock:nil animationBlock:nil callback:callback];
}

-(NSDictionary*)HyperCacheSetImageWithURL:(NSString*)url placeHolderImage:(UIImage*)placeHolderImage cachedImage:(UIImage*)cachedImage animationBlock:(void (^)(UIImageView* imageView, UIImage* image))animationBlock callback:(void (^)(HyperCacheStatus status, id obj))callback
{
	return [self HyperCacheSetImageWithURL:url placeHolderImage:placeHolderImage cachedImage:cachedImage preprocessBlock:nil failoverImage:nil postProcessBlock:nil animationBlock:animationBlock callback:callback];
}

-(NSDictionary*)HyperCacheSetImageWithURL:(NSString*)url callback:(void (^)(HyperCacheStatus status, id obj))callback
{
	//	return [self HyperCacheSetImageWithURL:url withOptions:nil callback:callback];
	return [self HyperCacheSetImageWithURL:url cachedImage:nil failoverImage:nil callback:callback];
}


-(NSDictionary*)HyperCacheSetImageWithURL:(NSString*)url
{
	return [self HyperCacheSetImageWithURL:url cachedImage:nil failoverImage:nil callback:nil];
}

-(NSDictionary*)HyperCacheSetImageWithURL:(NSString*)url placeHolderImage:(UIImage*)placeHolderImage
{
	return [self HyperCacheSetImageWithURL:url placeHolderImage:placeHolderImage cachedImage:nil preprocessBlock:nil failoverImage:nil postProcessBlock:nil animationBlock:nil callback:nil];
}

-(NSDictionary*)HyperCacheSetImageWithURL:(NSString*)url placeHolderImage:(UIImage*)placeHolderImage animationBlock:(void (^)(UIImageView* imageView, UIImage* image))animationBlock
{
	return [self HyperCacheSetImageWithURL:url placeHolderImage:placeHolderImage cachedImage:nil preprocessBlock:nil failoverImage:nil postProcessBlock:nil animationBlock:animationBlock callback:nil];
}

-(NSDictionary*)HyperCacheSetImageWithURL:(NSString*)url preprocessBlock:(id (^) (id))preprocessBlock
{
	return [self HyperCacheSetImageWithURL:url placeHolderImage:nil cachedImage:nil preprocessBlock:preprocessBlock failoverImage:nil postProcessBlock:nil animationBlock:nil callback:nil];
}

-(NSDictionary*)HyperCacheSetImageWithURL:(NSString*)url cachedImage:(UIImage*)cachedImage postProcessBlock:(id (^) (id))postprocessBlock callback:(void (^)(HyperCacheStatus status, id obj))callback
{
	return [self HyperCacheSetImageWithURL:url placeHolderImage:nil cachedImage:cachedImage preprocessBlock:nil failoverImage:nil postProcessBlock:postprocessBlock animationBlock:nil callback:callback];
}

-(NSDictionary*)HyperCacheSetImageWithURL:(NSString*)url cachedImage:(UIImage*)cachedImage failoverImage:(UIImage*)failoverImage callback:(void (^)(HyperCacheStatus status, id obj))callback
{
	return [self HyperCacheSetImageWithURL:url placeHolderImage:nil cachedImage:cachedImage preprocessBlock:nil failoverImage:failoverImage postProcessBlock:nil animationBlock:nil callback:callback];
}

-(NSDictionary*)HyperCacheSetImageWithURL:(NSString*)url placeHolderImage:(UIImage*)placeHolderImage cachedImage:(UIImage*)cachedImage preprocessBlock:(id (^) (id))preprocessBlock failoverImage:(UIImage*)failoverImage postProcessBlock:(id (^) (id))postprocessBlock animationBlock:(void (^)(UIImageView* imageView, UIImage* image))animationBlock callback:(void (^)(HyperCacheStatus status, id obj))callback
{
	if (cachedImage)
		self.image = cachedImage;
	else
		self.image = placeHolderImage;
	
	if (cachedImage)
	{
		if (postprocessBlock)
			cachedImage = postprocessBlock(cachedImage);
		_mainThread(^{
			self.image = cachedImage;
		});
		[HyperCache detachImageViewFromImageViewCallbacks:self];
		return nil;
	}
	
	if (!_str_ok2(url))
	{
		if (failoverImage)
			_mainThread(^{
				self.image = failoverImage;
			});
		else
			_mainThread(^{
				self.image = nil;
			});
		[HyperCache detachImageViewFromImageViewCallbacks:self];
		return nil;
	}
	
	if (callback)
		callback(HyperCacheStatusWillStartFetch, nil);
	
	return [HyperCache DownloadWithURL:url type:HyperCacheItemTypeImage isImageTask:YES imageView:self preprocessBlock:preprocessBlock postprocessBlock:postprocessBlock callbackMode:HyperCacheCallbackModeDefault group:nil tag:nil ttl:0 cacheOptions:HyperCachePolicyDefault priority:NSURLSessionTaskPriorityDefault callback:^(HyperCacheStatus status, id obj) {
		
		if ((status & HyperCacheStatusSuccess) == HyperCacheStatusSuccess && [obj isKindOfClass:[UIImage class]])
		{
			if (status & HyperCacheStatusReadFromCache) //no animation if it was cached
			{
				_mainThread(^{
					self.image = obj;
				});
			}
			else if (status & HyperCacheStatusCached) //perform animation only if its just downloaded
			{
				if (animationBlock)
					_mainThread(^{
						animationBlock(self, obj);
					});
				else
					[self _threadSafeSetImage:obj andOptions:nil isFailoverImage:NO];
				
			}
			_callback_safe(status, obj);
		}
		else
		{
			if (failoverImage)
			{
				[self _threadSafeSetImage:failoverImage andOptions:nil isFailoverImage:YES];
			}
			
			_callback_safe(HyperCacheStatusFailure | HyperCacheStatusConnectionError | HyperCacheStatusUsedFailoverImage, failoverImage);
		}
		
		
	}];
}

-(void)_threadSafeSetImage:(UIImage*)image andOptions:(NSDictionary*)options isFailoverImage:(BOOL)isFailoverImage
{
	BOOL animation_enabled = _setImage_default_animation_enabled;
	float animation_duration = _setImage_default_duration;
	BOOL shouldFade = _setImage_default_should_fade;
	float fade_from = _setImage_default_fade_fromValue;
	BOOL shouldEnlarge = _setImage_default_should_enlarge;
	float enlarge_from = _setImage_default_enlarge_fromValue;
	
	// NO ELARGEMENT ANIMATION FOR FAILED IMAGE DOWNLOADS
	if (isFailoverImage)
	{
		shouldEnlarge = NO;
	}
	
	if (options[@"animation"])
	{
		if (options[@"animation"][@"enabled"])
			animation_enabled = [options[@"animation"][@"enabled"] boolValue];
		
		if (options[@"animation"][@"duration"])
			animation_duration = [options[@"animation"][@"duration"] floatValue];
		
		if (options[@"animation"][@"shouldFade"])
			shouldFade = [options[@"animation"][@"shouldFade"] boolValue];
		
		if (options[@"animation"][@"fadeFrom"])
			fade_from = [options[@"animation"][@"fadeFrom"] floatValue];
		
		if (options[@"animation"][@"shouldEnlarge"])
			shouldEnlarge = [options[@"animation"][@"shouldEnlarge"] boolValue];
		
		if (options[@"animation"][@"enlargeFrom"])
			enlarge_from = [options[@"animation"][@"enlargeFrom"] floatValue];
	}
	
	_mainThread(^{
		if (animation_enabled)
			[self setImageAnimated:image duration:animation_duration shouldFade:shouldFade fadeFrom:fade_from shouldEnlarge:shouldEnlarge enlargeFrom:enlarge_from];
		else
			self.image = image;
	});
}

-(void)setImageAnimated:(UIImage*)image duration:(float)duration shouldFade:(BOOL)shouldFade fadeFrom:(float)fadeFrom shouldEnlarge:(BOOL)shouldEnlarge enlargeFrom:(float)enlargeFrom
{
	self.image = image;
	
	if (shouldFade)
		self.alpha = fadeFrom;
	
	if (shouldEnlarge)
		self.transform = CGAffineTransformMakeScale(enlargeFrom, enlargeFrom);
	
	[UIView animateWithDuration:duration animations:^{
		self.alpha = 1;
		self.transform = CGAffineTransformMakeScale(1.0, 1.0);
	}];
}

@end


