//
//  _UIControlBase.h
//  mactehrannew
//
//  Created by hAmidReza on 5/29/17.
//  Copyright © 2017 archibits. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface _UIControlBase : UIButton
// at first it was a subclass of UIControl; the touches had latency and also touchupinside event was not being called sometimes. changing this to UIButton solved the problem. :( no solutions found on the web.

@property (assign, nonatomic) BOOL highlightingDisabled;


/**
 sets the disabled alpha state of the control.
 */
@property (assign, nonatomic) CGFloat disabledAlpha;
@property (retain, nonatomic) UIColor* highlightedBackgroundColor;
@property (retain, nonatomic) UIColor* highlightedTextColor;

-(void)initialize;

@end
