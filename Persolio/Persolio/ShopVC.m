//
//  ShopVC.m
//  Persolio
//
//  Created by Ali Soume`e on 5/10/1396 AP.
//  Copyright © 1396 Ali Soume`e. All rights reserved.
//

#import "ShopVC.h"
#import "ShopSlideShowTVC.h"
#import "ShopTVC.h"

@interface ShopVC () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ShopVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configNavBar];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
}


- (void)configNavBar {
    self.navigationItem.title = [NSString stringWithFormat:@"Persolio"];
    //    [self.navigationController.navigationBar setTitleTextAttributes:
    //     @{NSForegroundColorAttributeName:[UIColor blackColor],
    //       NSFontAttributeName:[UIFont fontWithName:@"mplus-1c-regular" size:21]}];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor]}];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        ShopSlideShowTVC *cell = [tableView dequeueReusableCellWithIdentifier:@"ShopSlideShowTVC"];
        [cell prepareWith:self.view.bounds.size.width];
        return cell;
    }
    else {
        ShopTVC *cell = [tableView dequeueReusableCellWithIdentifier:@"ShopTVC"];
        [cell prepare];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 200;
    }
    else {
        return 150;
    }
}

@end
