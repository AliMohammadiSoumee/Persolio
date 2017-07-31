//
//  TestCVC.h
//  Persolio
//
//  Created by Ali Soume`e on 5/3/1396 AP.
//  Copyright © 1396 Ali Soume`e. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TestCVC : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *testImgV;
@property (weak, nonatomic) IBOutlet UILabel *titleLb;
@property (weak, nonatomic) IBOutlet UILabel *descTV;


- (void)prepareWithDic:(NSMutableDictionary*)dic;
@end
