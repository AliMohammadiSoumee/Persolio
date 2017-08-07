//
//  ShopSlideShowTVC.m
//  Persolio
//
//  Created by Ali Soume`e on 5/10/1396 AP.
//  Copyright © 1396 Ali Soume`e. All rights reserved.
//

#import "ShopSlideShowTVC.h"

@interface ShopSlideShowTVC() <UIScrollViewDelegate>

@end

@implementation ShopSlideShowTVC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)prepareWith:(CGFloat)width {
    self.scrollView.delegate = self;
    _pageControl.numberOfPages = 3;
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

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    int page = scrollView.contentOffset.x / scrollView.frame.size.width;
    [_pageControl setCurrentPage:page];
}
@end
