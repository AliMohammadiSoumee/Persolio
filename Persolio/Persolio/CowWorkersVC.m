//
//  CowWorkersVC.m
//  Persolio
//
//  Created by Ali Soume`e on 5/9/1396 AP.
//  Copyright © 1396 Ali Soume`e. All rights reserved.
//

#import "CowWorkersVC.h"
#import "CowWorkersTVC.h"
#import "CowWorkersSlideShowTVC.h"

@interface CowWorkersVC () <UITableViewDelegate, UITableViewDataSource>
{
    NSArray *dummyTitle;
    NSArray *dummyDesc;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation CowWorkersVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self prepareTableView];
    [self configNavBar];
}


- (void)configNavBar {
    self.navigationItem.title = [NSString stringWithFormat:@"Persolio"];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor]}];
}


- (void)prepareTableView {
    
    dummyTitle = [NSArray arrayWithObjects: @"کاربین", @"مرکز مشاوره حامی", @"متمم", @"تلنت یاب", nil];
    dummyDesc = @[@"کاریابی آنلاین یعنی ما به شما کمک میکنیم تا کارهای خوبی پیدا کنید", @"مرکز مشاوره حامی به شما کمک میکند تا درسهایتان را بهتر بخوانید", @"متمم همان مهارتهای من را افزایش میدهد", @"تلنت های مردم را میابیم تا زندگی بهتری ارایه دهیم"];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return dummyTitle.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        CowWorkersSlideShowTVC *cell = [tableView dequeueReusableCellWithIdentifier:@"CowWorkersSlideShowTVC"];
        return cell;
    }
    else {
        CowWorkersTVC *cell = [tableView dequeueReusableCellWithIdentifier:@"CowWorkersTVC"];
        NSMutableDictionary *dic = [NSMutableDictionary new];
        dic[@"title"] = dummyTitle[indexPath.row - 1];
        dic[@"desc"] = dummyDesc[indexPath.row - 1];
        dic[@"image"] = [UIImage imageNamed:_strfmt(@"out%ld.png", indexPath.row - 1)];
        cell.dic = dic;
        [cell prepare];
        return cell;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0)
        return 165;
    else
        return 240;
}


@end
