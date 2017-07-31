//
//  helper_regex.h
//  Prediscore
//
//  Created by hAmidReza on 10/17/16.
//  Copyright © 2016 pxlmind. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface helper_regex : NSObject

+(NSRegularExpression*)username_validation_regex;
+(NSRegularExpression*)username_typing_regex;

+(BOOL)validateNumber:(NSString*)str;

@end
