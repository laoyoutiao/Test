//
//  ScheduleViewController.m
//  Test
//
//  Created by 玉文辉 on 15/8/7.
//  Copyright (c) 2015年 玉文辉. All rights reserved.
//

#import "ScheduleViewController.h"

@interface ScheduleViewController ()
@property (weak, nonatomic) IBOutlet UILabel *StartTime;
@property (weak, nonatomic) IBOutlet UILabel *FinishTime;

@end

@implementation ScheduleViewController

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
    self.title = @"日程添加";
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
