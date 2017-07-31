//
//  helper_regex.m
//  Prediscore
//
//  Created by hAmidReza on 10/17/16.
//  Copyright © 2016 pxlmind. All rights reserved.
//

#import "helper_regex.h"

@implementation helper_regex

+(NSRegularExpression*)username_validation_regex
{
	static NSRegularExpression *username_regex;
	
	if (!username_regex)
	{
		
		NSError* error;
		username_regex = [NSRegularExpression regularExpressionWithPattern:@"^[a-z][a-z0-9_.]{3,31}$" options:NSRegularExpressionCaseInsensitive error:&error];
		if (error)
			NSAssert(false, @"shittt usernameRegexes");
	}
	
	return username_regex;
}

+(NSRegularExpression*)username_typing_regex
{
	static NSRegularExpression *username_input_regex;
	
	if (!username_input_regex)
	{
		NSError* error;
		username_input_regex = [NSRegularExpression regularExpressionWithPattern:@"^[a-z]{0,1}[a-z0-9_.]{0,31}$" options:NSRegularExpressionCaseInsensitive error:&error];
		if (error)
			NSAssert(false, @"shittt usernameRegexes");
	}
	
	return username_input_regex;
}

//checks that all characters are only numbers
+(NSRegularExpression*)only_number__regex
{
	static NSRegularExpression *only_number__regex;
	
	if (!only_number__regex)
	{
		NSError* error;
		only_number__regex = [NSRegularExpression regularExpressionWithPattern:@"^[0-9\\u06f0-\\\u06f9\\u0660-\\u0669]*$" options:NSRegularExpressionCaseInsensitive error:&error];
		if (error)
			NSAssert(false, @"shittt only_number__regex");
	}
	
	return only_number__regex;
}

+(BOOL)validateNumber:(NSString*)str
{

	NSUInteger numberOfMatches = [[helper_regex only_number__regex] numberOfMatchesInString:str
																					   options:0
																						 range:NSMakeRange(0, [str length])];
	if (numberOfMatches == 0)
		return NO;
	return true;
}


@end
