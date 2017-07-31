//
//  TestCVC.m
//  Persolio
//
//  Created by Ali Soume`e on 5/3/1396 AP.
//  Copyright © 1396 Ali Soume`e. All rights reserved.
//

#import "TestCVC.h"

@implementation TestCVC

- (void)prepareWithDic:(NSMutableDictionary*)dic {
    if (self) {
        
        if (dic[@"image"]) {
            NSString *imgName = _strfmt(@"%@.png", dic[@"image"]);
            UIImage *image = [UIImage imageNamed:imgName];
            _testImgV.image = image;
        }
        
        if (_str_ok1(dic[@"title"])) {
            _titleLb.text = dic[@"title"];
        }
        
        if (_str_ok1(dic[@"desc"])) {
            _descTV.text = dic[@"desc"];
        }
        
        if (dic[@"tag"]) {
            if ([dic[@"tag"] integerValue] == 0) {
                [self.titleLb setFont:[_titleLb.font fontWithSize:24]];
                [self.descTV setFont:[_titleLb.font fontWithSize:16]];
            }
            else {
                [self.titleLb setFont:[_titleLb.font fontWithSize:18]];
                [self.descTV setFont:[_titleLb.font fontWithSize:12]];
            }
        }
    }
}

@end
