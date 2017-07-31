//
//  CowWorkersTVC.m
//  Persolio
//
//  Created by Ali Soume`e on 5/9/1396 AP.
//  Copyright © 1396 Ali Soume`e. All rights reserved.
//

#import "CowWorkersTVC.h"

@implementation CowWorkersTVC

- (void)awakeFromNib {
    [super awakeFromNib];
    
}


- (void)prepare {
    self.imageV.layer.cornerRadius = 5;
    if (_str_ok1(_dic[@"title"])) {
        self.titleLb.text = _dic[@"title"];
    }
    if (_str_ok1(_dic[@"desc"])) {
        self.descTV.text = _dic[@"desc"];
    }
    if (_dic[@"image"] && [_dic[@"image"] isKindOfClass:[UIImage class]]) {
        self.imageV.image = _dic[@"image"];
    }
}
@end
