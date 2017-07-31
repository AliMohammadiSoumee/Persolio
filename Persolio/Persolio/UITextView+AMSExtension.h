//
//  UITextView+AMSExtension.h
//  Palette
//
//  Created by Ali Soume`e on 5/6/1396 AP.
//  Copyright © 1396 Ali-Soume. All rights reserved.
//

#import <UIKit/UIKit.h>



FOUNDATION_EXPORT double UITextView_PlaceholderVersionNumber;
FOUNDATION_EXPORT const unsigned char UITextView_PlaceholderVersionString[];


@interface UITextView (AMSExtension)

@property (nonatomic, readonly) UILabel *placeholderLabel;
@property (nonatomic, strong) IBInspectable NSString *placeholder;
@property (nonatomic, strong) NSAttributedString *attributedPlaceholder;
@property (nonatomic, strong) IBInspectable UIColor *placeholderColor;

+ (UIColor *)defaultPlaceholderColor;


@end
