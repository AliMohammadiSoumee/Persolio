//
//  ShopSlideShowTVC.m
//  Persolio
//
//  Created by Ali Soume`e on 5/10/1396 AP.
//  Copyright © 1396 Ali Soume`e. All rights reserved.
//

#import "ShopSlideShowTVC.h"

@implementation ShopSlideShowTVC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)prepareWith:(CGFloat)width {
    UIImageView *lastImgV;
    for (int i = 0; i < 3; i++) {
        UIImageView *image = [UIImageView new];
        image.translatesAutoresizingMaskIntoConstraints = NO;
        image.contentMode = UIViewContentModeScaleAspectFill;
        
        image.image = [UIImage imageNamed:_strfmt(@"outSlide%d.png", i)];
        image.clipsToBounds = YES;
        [_contentV addSubview:image];
        
        if (!lastImgV) {
            [image sdc_alignEdgesWithSuperview:UIRectEdgeLeft];
        }
        else {
            [image sdc_alignEdge:UIRectEdgeLeft withEdge:UIRectEdgeRight ofView:lastImgV];
        }
        
        [image sdc_pinWidth:width];
        [image sdc_alignEdgesWithSuperview:UIRectEdgeTop | UIRectEdgeBottom];
        
        lastImgV = image;
    }
    [lastImgV sdc_alignEdgesWithSuperview:UIRectEdgeRight];
}
@end
