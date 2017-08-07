//
//  TestVC.m
//  Persolio
//
//  Created by Ali Soume`e on 5/16/1396 AP.
//  Copyright © 1396 Ali Soume`e. All rights reserved.
//

#import "TestVC.h"

@interface TestVC ()

@end

@implementation TestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configNavBar];
}


- (void)configNavBar {
    self.navigationItem.title = [NSString stringWithFormat:@"Tests"];
    //    [self.navigationController.navigationBar setTitleTextAttributes:
    //     @{NSForegroundColorAttributeName:[UIColor blackColor],
    //       NSFontAttributeName:[UIFont fontWithName:@"mplus-1c-regular" size:21]}];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor]}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)happyButtonTouched:(id)sender {
    _sadBorder.image = nil;
    _sosoBorder.image = nil;
    _happyBorder.image = [UIImage imageNamed:@"border.png"];
}
- (IBAction)sadButtonTouched:(id)sender {
    
    _happyBorder.image = nil;
    _sosoBorder.image = nil;
    _sadBorder.image = [UIImage imageNamed:@"border.png"];
}
- (IBAction)sosoButtonTouched:(id)sender {
    _happyBorder.image = nil;
    _sadBorder.image = nil;
    _sosoBorder.image = [UIImage imageNamed:@"border.png"];
}
- (IBAction)nextButtonTouched:(id)sender {
    TestVC *vc = _vc_from_storyboard(@"TestLibrary", @"TestVC");
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)previosButtonTouched:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
