//
//  ShopSlideShowTVC.h
//  Persolio
//
//  Created by Ali Soume`e on 5/10/1396 AP.
//  Copyright © 1396 Ali Soume`e. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopSlideShowTVC : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *contentV;
@property (nonatomic, strong) NSMutableDictionary *dic;
- (void)prepareWith:(CGFloat)width;
@end
