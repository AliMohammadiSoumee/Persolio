//
//  CoWorkerDetailsVC.m
//  Persolio
//
//  Created by Ali Soume`e on 5/9/1396 AP.
//  Copyright © 1396 Ali Soume`e. All rights reserved.
//

#import "CoWorkerDetailsVC.h"

@interface CoWorkerDetailsVC ()

@end

@implementation CoWorkerDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configNavBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)configNavBar {
    self.navigationItem.title = [NSString stringWithFormat:@"Details"];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor]}];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
