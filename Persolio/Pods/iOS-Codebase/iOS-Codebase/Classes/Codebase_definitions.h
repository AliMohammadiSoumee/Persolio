//
//  core_definitions.h
//  Pods
//
//  Created by hAmidReza on 6/1/17.
//
//

#import <Foundation/Foundation.h>

#define _1pixel 1.0f/[[UIScreen mainScreen] scale]
#define kFoursquareClientID @"IZG1HYH0GJICYHZ543GCPXUGN3B21AK2GNGM14WFYMQZSVTL"
#define kFoursquareClientSecret @"PZOSA0WLON0SDP1MTRXJHEE50YYLIFTLG4WWKGZIKCJTIJYC"

#define _strfmt(fmt,...) [NSString stringWithFormat:(fmt), ##__VA_ARGS__]
//#define _simpleAlert(title, message) [helper simpleAlertWithTitle:title message:message]

#define _1pixel 1.0f/[[UIScreen mainScreen] scale]
#define x_center_horiz(aView) (aView.superview.frame.size.width - aView.frame.size.width)/2
#define y_center_vertic(aView) (aView.superview.frame.size.height - aView.frame.size.height)/2
#define frameSetVerticalCenterInSuperView(aView) aView.frame = CGRectMake(aView.frame.origin.x, (aView.superview.frame.size.height - aView.frame.size.height)/2, aView.frame.size.width, aView.frame.size.height)
#define CGRectMakeDiff(aView, dX, dY, dW, dH) CGRectMake(aView.frame.origin.x + dX, aView.frame.origin.y + dY, aView.frame.size.width + dW, aView.frame.size.height + dH)
#define CGRectSetHeight(aView, newHeight) CGRectMake(aView.frame.origin.x, aView.frame.origin.y, aView.frame.size.width, newHeight)
#define CGRectSetWidth(aView, newWidth) CGRectMake(aView.frame.origin.x, aView.frame.origin.y, newWidth, aView.frame.size.height)
#define CGRectSetX(aView, newX) CGRectMake(newX, aView.frame.origin.y, aView.frame.size.width, aView.frame.size.height)
#define CGRectSetY(aView, newY) CGRectMake(aView.frame.origin.x, newY, aView.frame.size.width, aView.frame.size.height)
#define CGRectDiffX(aView, newX) CGRectMake(aView.frame.origin.x + newX, aView.frame.origin.y, aView.frame.size.width, aView.frame.size.height)
#define CGRectDiffY(aView, newY) CGRectMake(aView.frame.origin.x, aView.frame.origin.y + newY, aView.frame.size.width, aView.frame.size.height)
#define CGRectDiffXY(aView, newX, newY) CGRectMake(aView.frame.origin.x + newX, aView.frame.origin.y + newY, aView.frame.size.width, aView.frame.size.height)
#define CGRectSetXY(aView, newX, newY) CGRectMake(newX, newY, aView.frame.size.width, aView.frame.size.height)
#define CGRectDiffXSetY(aView, newX, newY) CGRectMake(aView.frame.origin.x + newX, newY, aView.frame.size.width, aView.frame.size.height)
#define CGRectSetXDiffY(aView, newX, newY) CGRectMake(newX, aView.frame.origin.y + newY, aView.frame.size.width, aView.frame.size.height)
#define CGGetHeight(aView) aView.frame.size.height
#define CGGetWidth(aView) aView.frame.size.width
#define CGGetY(aView) aView.frame.origin.y
#define CGGetX(aView) aView.frame.origin.x

#define rad(angle) ((angle) / 180.0 * M_PI)



//#define _verbose_mode

#define _asynMainAfter(delay, arg) dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{arg})
#define _defineAppDelegate AppDelegate* theAppDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate]
#define _defineDeviceWidth CGFloat w = [[UIScreen mainScreen] bounds].size.width
#define _defineDeviceHeight CGFloat h = [[UIScreen mainScreen] bounds].size.height
#define _defineDeviceScale CGFloat s = [UIScreen mainScreen].scale

#define _defineWeakSelf __weak __typeof__(self) weakSelf = self
#define _defineWeakObject(x) __weak __typeof__(x) weakObj = x

//#define currentLanguageBundle [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:_loadPref(@"current-language") ofType:@"lproj"]]
//
#define _str(key) [helper localizableValueWithKey:key]
#define _nscgrect(x, y, w, h) [NSValue valueWithCGRect:CGRectMake(x, y, w, h)]
//#define _str_setLang(lang) _savePref(lang, @"current-language")

//////

#define DEG2RAD(angle) angle*M_PI/180.0
#define RAD2DEG(angle) angle*180.0/M_PI

#define _codebaseDic [[NSBundle mainBundle] infoDictionary][@"codebase"]

#define _vc_from_storyboard(storyboard_name, vc_ident) [[UIStoryboard storyboardWithName:storyboard_name bundle: nil] instantiateViewControllerWithIdentifier:vc_ident]

#define _uiimage_ok(arg) ([arg isKindOfClass:[UIImage class]])
#define _block_ok(arg) ([arg isKindOfClass:NSClassFromString(@"NSBlock")])
#define _arr_ok1(arr) (arr && [arr isKindOfClass:[NSArray class]])
#define _arr_ok2(arr) (arr && [arr isKindOfClass:[NSArray class]] && [arr count] > 0)
#define _num_ok1(num) (num && [num isKindOfClass:[NSNumber class]])
#define _num_ok2(num) (num && [num isKindOfClass:[NSNumber class]] && [num floatValue] > 0)
#define _str_ok1(str) (str && [str isKindOfClass:[NSString class]])
#define _str_ok2(str) (str && [str isKindOfClass:[NSString class]] && [str length] > 0)
#define _str_safe(str) (str && [str isKindOfClass:[NSString class]] ? str : @"")
#define _bool_true(arg) (arg && [arg isKindOfClass:[NSNumber class]] && [arg boolValue] ? true : false)
#define _dic_ok(dic, field) (dic && [dic isKindOfClass:[NSDictionary class]] && dic[field])
#define _dic_safe_field(dic, field) (dic && [dic isKindOfClass:[NSDictionary class]] && dic[field] ? dic[field] : [NSNull null])
#define _dic_required_field(dic, field) (dic && [dic isKindOfClass:[NSDictionary class]] && dic[field] && dic[field] != [NSNull null])


#define _MAXMIN_Bound(min, x, max) MAX(MIN(x, max), min)
#define _if_between(min, x, max) (min < x && x < max)
#define _map(value, low1, high1, low2, high2) (low2 + (value - low1) * (high2 - low2) / (high1 - low1))

#define RGBAColor(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define rgba(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define c_opaqueWhite(a) rgba(255*a, 255*a, 255*a, 1.0f)
#define _black(a) rgba(255*a, 255*a, 255*a, 1.0f)

#define _ensureUserRole(userDic, role) (userDic && [userDic[@"role"] isKindOfClass:[NSNumber class]] && [userDic[@"role"] unsignedIntegerValue] >= role)

///////////////////    HAPTIC MACROS
#define hapticTick [helper hapticSelection]

#define hapticILight [helper hapticImpactLight]
#define hapticIMedium [helper hapticImpactMedium]
#define hapticIHeavy [helper hapticImpactHeavy]

#define hapticNotiSuccess [helper hapticNotificationSuccess]
#define hapticNotiWarning [helper hapticNotificationWarning]
#define hapticNotiError [helper hapticNotificationError]



#define _location(coordinate) [[CLLocation alloc] initWithCoordinate:coordinate altitude:1 horizontalAccuracy:1 verticalAccuracy:-1 timestamp:[NSDate date]]
///////////////////

@interface core_definitions : NSObject

NSArray* k_iconExclam();
NSArray* k_iconRetry();
NSArray* k_iconLeftArrow();
NSArray* __codebase_k_iconCrossHeavy();
NSArray* __codebase_k_iconWarning();
NSArray* __codebase_k_iconLocationSible();
NSArray* __codebase_k_iconMyLocationPickerPin();
@end
