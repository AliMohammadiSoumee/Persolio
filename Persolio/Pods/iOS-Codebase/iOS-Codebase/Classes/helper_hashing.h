//
//  helper_hashing.h
//  Prediscore
//
//  Created by Hamidreza Vaklian on 5/19/16.
//  Copyright © 2016 pxlmind. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface helper_hashing : NSObject

+(NSData*)hashDictionary:(NSDictionary *)dic;
+(NSString*)hashString:(NSString*)str;
+(NSData*)hashDictionary:(NSDictionary *)dic andKey:(NSString*)key;
+(NSString*)hashString:(NSString*)str andKey:(NSString*)key;
+(NSString*)uniqueDeviceID;
+(NSString*)calculateRN;
+(NSString*)hmacForPutDataMD5:(NSString*)md5;

@end
