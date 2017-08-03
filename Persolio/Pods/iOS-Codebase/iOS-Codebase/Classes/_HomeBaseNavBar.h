//
//  _HomeBaseNavBar.h
//  Kababchi
//
//  Created by hAmidReza on 7/20/17.
//  Copyright © 2017 innovian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyShapeButton.h"

@interface _HomeBaseNavBar : UINavigationBar

@property (retain, nonatomic) MyShapeButton* leftButton;
@property (retain, nonatomic) MyShapeButton* rightButton;

@property (retain, nonatomic) NSDictionary* theTitleTextAttributes UI_APPEARANCE_SELECTOR;

@end
