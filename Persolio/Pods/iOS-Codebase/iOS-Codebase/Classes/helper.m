//
//  helper.m
//  macTehran
//
//  Created by Hamidreza Vaklian on 12/25/15.
//  Copyright © 2015 Hamidreza Vaklian. All rights reserved.
//

#import "helper.h"
#import "Codebase.h"
#import "Codebase_definitions.h"
#import "PodAsset.h"
#import <sqlite3/sqlite3.h>

@implementation helper

+(UISelectionFeedbackGenerator*)selectionFeedbackGenerator
{
	if ([UISelectionFeedbackGenerator class])
	{
	static UISelectionFeedbackGenerator* selectionFeedbackGenerator;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		selectionFeedbackGenerator = [UISelectionFeedbackGenerator new];
		[selectionFeedbackGenerator prepare];
	});
	
	return selectionFeedbackGenerator;
	}
	else
		
		return nil;
}

+(void)hapticSelection
{
	[[self selectionFeedbackGenerator] selectionChanged];
}

+(UIImpactFeedbackGenerator*)impactFeedbackGeneratorLight
{
	if ([UIImpactFeedbackGenerator class])
	{
		static UIImpactFeedbackGenerator* impactFeedbackGeneratorLight;
		static dispatch_once_t onceToken;
		dispatch_once(&onceToken, ^{
			impactFeedbackGeneratorLight = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleLight];
			[impactFeedbackGeneratorLight prepare];
		});
		
		return impactFeedbackGeneratorLight;
	}
	else
		return nil;
}

+(UIImpactFeedbackGenerator*)impactFeedbackGeneratorMedium
{
	if ([UIImpactFeedbackGenerator class])
	{
		static UIImpactFeedbackGenerator* impactFeedbackGeneratorMedium;
		static dispatch_once_t onceToken;
		dispatch_once(&onceToken, ^{
			impactFeedbackGeneratorMedium = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleMedium];
			[impactFeedbackGeneratorMedium prepare];
		});
		
		return impactFeedbackGeneratorMedium;
	}
	else
		return nil;
}

+(UIImpactFeedbackGenerator*)impactFeedbackGeneratorHeavy
{
	if ([UIImpactFeedbackGenerator class])
	{
		static UIImpactFeedbackGenerator* impactFeedbackGeneratorHeavy;
		static dispatch_once_t onceToken;
		dispatch_once(&onceToken, ^{
			impactFeedbackGeneratorHeavy = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleHeavy];
			[impactFeedbackGeneratorHeavy prepare];
		});
		
		return impactFeedbackGeneratorHeavy;
	}
	else
		return nil;
}

+(void)hapticImpactLight
{
	[[self impactFeedbackGeneratorLight] impactOccurred];
}
+(void)hapticImpactMedium
{
	[[self impactFeedbackGeneratorMedium] impactOccurred];
}
+(void)hapticImpactHeavy
{
	[[self impactFeedbackGeneratorHeavy] impactOccurred];
}

+(UINotificationFeedbackGenerator*)notificationFeedbackGenerator
{
	if ([UINotificationFeedbackGenerator class])
	{
		static UINotificationFeedbackGenerator* notificationFeedbackGenerator;
		static dispatch_once_t onceToken;
		dispatch_once(&onceToken, ^{
			notificationFeedbackGenerator = [UINotificationFeedbackGenerator new];
			[notificationFeedbackGenerator prepare];
		});
		
		return notificationFeedbackGenerator;
	}
	else
		return nil;
}


+(void)hapticNotificationSuccess
{
	[[self notificationFeedbackGenerator] notificationOccurred:UINotificationFeedbackTypeSuccess];
}
											 
+(void)hapticNotificationWarning
{
	[[self notificationFeedbackGenerator] notificationOccurred:UINotificationFeedbackTypeWarning];
}
+(void)hapticNotificationError
{
	[[self notificationFeedbackGenerator] notificationOccurred:UINotificationFeedbackTypeError];
}

+(NSDictionary*)getAppVersions
{
	static NSRegularExpression *regex;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		regex = [NSRegularExpression regularExpressionWithPattern:@"^(\\d+)\\.(\\d+)\\.(\\d+)$" options:NSRegularExpressionCaseInsensitive error:nil];
	});
	
	NSString* buildNo_str = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
	NSNumber* buildNo = [[helper decimalStrFormatter] numberFromString:buildNo_str];
	NSString* version =  [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
	
	NSArray *matches = [regex matchesInString:version options:0 range:NSMakeRange(0, [version length])];
	
	if (matches && matches.count)
	{
		NSString* str1 = [version substringWithRange:[matches[0] rangeAtIndex:1]];
		NSNumber* v1 = [[helper decimalStrFormatter] numberFromString:str1];
		NSString* str2 = [version substringWithRange:[matches[0] rangeAtIndex:2]];
		NSNumber* v2 = [[helper decimalStrFormatter] numberFromString:str2];
		NSString* str3 = [version substringWithRange:[matches[0] rangeAtIndex:3]];
		NSNumber* v3 = [[helper decimalStrFormatter] numberFromString:str3];
		
		return @{@"build": buildNo_str,
				 @"_build": buildNo,
				 @"version": version,
				 @"_version": @[v1, v2, v3]};
	}
	return @{@"build": buildNo,
			 @"version": version};
}

+(NSNumberFormatter*)decimalStrFormatter
{
	static NSNumberFormatter* decimalStrFormatter;
	if (!decimalStrFormatter)
	{
		decimalStrFormatter= [NSNumberFormatter new];
		decimalStrFormatter.numberStyle = NSNumberFormatterDecimalStyle;
	}
	return decimalStrFormatter;
}

+(NSString*)getAppVersionStringWithVersion:(NSArray*)version andBuild:(NSNumber*)build formatted:(BOOL)formatted
{
	if (formatted)
		return _strfmt(@"%@.%@.%@ (#%@)", version[0], version[1], version[2], build);
	else
		return _strfmt(@"%@.%@.%@-%@", version[0], version[1], version[2], build);
}
+(UIBezierPath*)bezierPathWithDescArray:(NSArray*)array andWidth:(CGFloat)w
{
	UIBezierPath* path = [UIBezierPath bezierPath];
	for (NSArray* arr in array) {
		NSString* cmd = arr[0];
		if ([cmd isEqualToString:@"m"]) //move to point
			[path moveToPoint:CGPointMake([arr[1] floatValue]/100*w, [arr[2] floatValue]/100*w)];
		else if ([cmd isEqualToString:@"l"]) //line
			[path addLineToPoint:CGPointMake([arr[1] floatValue]/100*w, [arr[2] floatValue]/100*w)];
		else if ([cmd isEqualToString:@"c"]) //curve
			[path addCurveToPoint:CGPointMake([arr[1] floatValue]/100*w, [arr[2] floatValue]/100*w) controlPoint1:CGPointMake([arr[3] floatValue]/100*w, [arr[4] floatValue]/100*w) controlPoint2:CGPointMake([arr[5] floatValue]/100*w, [arr[6] floatValue]/100*w)];
	}
	
	[path closePath];
	
	return path;
}


+(UIBarButtonItem*)shapeBarButtonWithConf:(void (^)(MyShapeButton* button))buttonConfCallback andCallback:(void (^)(void))buttonClick
{
	MyShapeButton* shapeButton = [[MyShapeButton alloc] initWithShapeDesc:nil andShapeTintColor:[UIColor whiteColor] andButtonClick:buttonClick];
	
	if (buttonConfCallback)
		buttonConfCallback(shapeButton);
	
	shapeButton.frame = CGRectMake(0, 0, 44, 44);
	UIBarButtonItem *theButtonItem = [[UIBarButtonItem alloc] initWithCustomView:shapeButton];
	return theButtonItem;
}



+(NSNumber*)totalDiskSpace
{
	NSDictionary *fattributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
	return [fattributes objectForKey:NSFileSystemSize];
}

+(void)printAvailableFonts
{
	for (NSString *familyName in [UIFont familyNames]){
		NSLog(@"Family name: %@", familyName);
		for (NSString *fontName in [UIFont fontNamesForFamilyName:familyName]) {
			NSLog(@"--Font name: %@", fontName);
		}
	}
}

+(UIColor*)linearColorBetweenLowerColor:(UIColor*)lowerColor andUpperColor:(UIColor*)upperColor andProgress:(CGFloat)progress
{
	CGFloat lowerR, lowerG, lowerB, lowerA;
	[lowerColor getRed:&lowerR green:&lowerG blue:&lowerB alpha:&lowerA];
	CGFloat upperR, upperG, upperB, upperA;
	[upperColor getRed:&upperR green:&upperG blue:&upperB alpha:&upperA];
	UIColor* finalColor = [UIColor colorWithRed:lowerR + (upperR - lowerR) * progress green:lowerG + (upperG - lowerG) * progress blue:lowerB + (upperB - lowerB) * progress alpha:lowerA + (upperA - lowerA) * progress];
	return finalColor;
}



+(UIAlertController*)simpleAlertWithTitle:(NSString*)title message:(NSString*)msg
{
	UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
	
	UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
	[alertController addAction:ok];
	
	return alertController;
}

+(NSDictionary*)deviceInfoDictionary
{
	NSUUID* ident = [[UIDevice currentDevice] identifierForVendor];
	
	NSString* platformString = [[[UIDeviceHardware alloc] init] platformString];
	NSString* identString = [ident UUIDString];
	
	NSString* osVersion = [NSString stringWithFormat:@"%@", [[UIDevice currentDevice] systemVersion]];
	NSString* capacity = [NSString stringWithFormat:@"%lluGB", [[helper totalDiskSpace] unsignedLongLongValue] / 1000000000];
	
	NSDictionary* device_info = @{@"device": @{@"uid": identString, @"platform": platformString, @"name": [[UIDevice currentDevice] name], @"capacity": capacity}, @"os": @{@"version": osVersion, @"type": @"iOS"}};
	
	return device_info;
}

+(UIView*)hairlineTopOfView:(UIView*)view margin:(CGFloat)margin backColor:(UIColor*)color
{
	_defineDeviceScale;
	UIView* hairline = [UIView new];
	hairline.backgroundColor = color ? color : [UIColor blackColor];
	hairline.translatesAutoresizingMaskIntoConstraints = NO;
	[view addSubview:hairline];
	[hairline sdc_alignSideEdgesWithSuperviewInset:0];
	[hairline sdc_pinHeight:1/s];
	[hairline sdc_alignTopEdgeWithSuperviewMargin:margin];
	return hairline;
}

+(UIView*)hairlineBottomOfView:(UIView*)view margin:(CGFloat)margin backColor:(UIColor*)color
{
	_defineDeviceScale;
	UIView* hairline = [UIView new];
	hairline.backgroundColor = color ? color : [UIColor blackColor];
	hairline.translatesAutoresizingMaskIntoConstraints = NO;
	[view addSubview:hairline];
	[hairline sdc_alignSideEdgesWithSuperviewInset:0];
	[hairline sdc_pinHeight:1/s];
	[hairline sdc_alignBottomEdgeWithSuperviewMargin:margin];
	return hairline;
}


+(UIView*)hairlineTopEdgeToBottomOfView:(UIView*)view margin:(CGFloat)margin backColor:(UIColor*)color
{
	_defineDeviceScale;
	UIView* hairline = [UIView new];
	hairline.backgroundColor = color ? color : [UIColor blackColor];
	hairline.translatesAutoresizingMaskIntoConstraints = NO;
	[view.superview addSubview:hairline];
	[hairline sdc_alignSideEdgesWithSuperviewInset:0];
	[hairline sdc_pinHeight:1/s];
	[hairline sdc_alignEdge:UIRectEdgeTop withEdge:UIRectEdgeBottom ofView:view inset:margin];
	return hairline;
}

+(UIView*)hairlineBottomEdgeToTopOfView:(UIView*)view margin:(CGFloat)margin backColor:(UIColor*)color
{
	_defineDeviceScale;
	UIView* hairline = [UIView new];
	hairline.backgroundColor = color ? color : [UIColor blackColor];
	hairline.translatesAutoresizingMaskIntoConstraints = NO;
	[view.superview addSubview:hairline];
	[hairline sdc_alignSideEdgesWithSuperviewInset:0];
	[hairline sdc_pinHeight:1/s];
	[hairline sdc_alignEdge:UIRectEdgeBottom withEdge:UIRectEdgeTop ofView:view inset:-margin];
	return hairline;
}


static NSDictionary *localizable;
+(void)prepareLocalizableStrings
{
	NSString *path = [[NSBundle mainBundle] pathForResource:@"Localizable"
													 ofType:@"strings"];
	
	localizable = [NSDictionary dictionaryWithContentsOfFile:path];
}

+(NSString*)localizableValueWithKey:(NSString*)key
{
	return localizable[key];
}
//////

+ (UIImage *)filledImageFrom:(UIImage *)source withColor:(UIColor *)color
{
	
	// begin a new image context, to draw our colored image onto with the right scale
	UIGraphicsBeginImageContextWithOptions(source.size, NO, [UIScreen mainScreen].scale);
	
	// get a reference to that context we created
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	// set the fill color
	[color setFill];
	
	// translate/flip the graphics context (for transforming from CG* coords to UI* coords
	CGContextTranslateCTM(context, 0, source.size.height);
	CGContextScaleCTM(context, 1.0, -1.0);
	
	CGContextSetBlendMode(context, kCGBlendModeColorBurn);
	CGRect rect = CGRectMake(0, 0, source.size.width, source.size.height);
	CGContextDrawImage(context, rect, source.CGImage);
	
	CGContextSetBlendMode(context, kCGBlendModeSourceIn);
	CGContextAddRect(context, rect);
	CGContextDrawPath(context,kCGPathFill);
	
	// generate a new UIImage from the graphics context we drew onto
	UIImage *coloredImg = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	//return the color-burned image
	return coloredImg;
}

+(NSBundle*)theBundle
{
	return [PodAsset bundleForPod:@"iOS-Codebase"];
}

+(NSString *)thousandSeparatedStringFromNumber:(NSNumber *)number
{
	static NSNumberFormatter* numberFormatter;

		if (!numberFormatter)
		{
			numberFormatter = [[NSNumberFormatter alloc] init];
			[numberFormatter setFormatterBehavior: NSNumberFormatterBehavior10_4];
			[numberFormatter setNumberStyle: NSNumberFormatterDecimalStyle];
		}
		
		return [numberFormatter stringFromNumber:number];
		
	
}

+(int)ui_lang
{
	return 1;//0:english, 1:farsi
}

+(NSURLSession*)assetProviderSession
{
	static NSURLSession* assetProviderSession;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
		assetProviderSession = [NSURLSession sessionWithConfiguration:sessionConfig delegate:nil delegateQueue:nil];
	});
	return assetProviderSession;
}

+(void)makeSqliteThreadSafeIfNeeded
{
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
	sqlite3_shutdown();
	if (sqlite3_threadsafe() > 0) {
		int retCode = sqlite3_config(SQLITE_CONFIG_SERIALIZED);
		if (retCode == SQLITE_OK) {
			NSLog(@"Can now use sqlite on multiple threads, using the same connection");
		} else {
			NSLog(@"setting sqlite thread safe mode to serialized failed!!! return code: %d", retCode);
		}
	} else {
		NSLog(@"Your SQLite database is not compiled to be threadsafe.");
	}
	sqlite3_initialize();
		});
}

@end
