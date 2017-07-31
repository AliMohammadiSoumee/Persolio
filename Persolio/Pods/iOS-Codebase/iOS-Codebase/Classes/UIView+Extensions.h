//
//  UIView+Extensions.h
//  Kababchi
//
//  Created by hAmidReza on 7/3/17.
//  Copyright © 2017 innovian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extensions)

-(id)getNearestVC;
-(id)getNearestVCByClass:(NSString*)class_str;
-(id)getNearestParentViewByClass:(NSString*)class_str;

@end
