//
//  MainCardViewController.m
//  Test
//
//  Created by 玉文辉 on 15/8/1.
//  Copyright (c) 2015年 玉文辉. All rights reserved.
//

#import "MainCardViewController.h"
#import "HealthDataViewController.h"
#import "HealthRemindViewController.h"

@interface MainCardViewController ()

@end

@implementation MainCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self ReviseNavigation];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)ReviseNavigation
{
    //    [self.navigationController setNavigationBarHidden:YES];
    [self.navigationController.navigationBar setBarTintColor:[UIColor grayColor]];
    self.title = @"健康卡";
}

- (IBAction)ClickHealthData:(id)sender {
    HealthDataViewController *dataView = [self.storyboard instantiateViewControllerWithIdentifier:@"HealthDataView"];
    [self.navigationController pushViewController:dataView animated:YES];
}

- (IBAction)ClickHealthReming:(id)sender {
    HealthRemindViewController *remindView = [self.storyboard instantiateViewControllerWithIdentifier:@"HealthRemindView"];
    [self.navigationController pushViewController:remindView animated:YES];
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
