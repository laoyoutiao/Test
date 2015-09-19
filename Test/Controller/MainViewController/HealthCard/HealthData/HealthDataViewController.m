    //
//  HealthDataViewController.m
//  Test
//
//  Created by 玉文辉 on 15/8/5.
//  Copyright (c) 2015年 玉文辉. All rights reserved.
//

#import "HealthDataViewController.h"
#import "LineChartView.h"
#import "ServerHealthInfo.h"
#import "UserInfo.h"

@interface HealthDataViewController ()
@property (weak, nonatomic) IBOutlet LineChartView *lineChartView;
@property (weak, nonatomic) IBOutlet UILabel *DateLabel;
@property (strong, nonatomic) UserInfo *userinfo;
@property (strong, nonatomic) NSArray *pointarray;
@end

@implementation HealthDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDictionary *dict = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserInfo"];
    _userinfo = [[UserInfo alloc] initWithDictionary:dict];
    
    [self ReviseNavigation];
    [self setlineView];
    [self setdateLabel];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)ReviseNavigation
{
    self.title = @"健康数据";
}

- (void)setlineView
{
    [ServerHealthInfo GetHealthInfopostName:_userinfo.username time:@"2015-08-17" Block:^(NSDictionary *dict){
//        NSLog(@"%@",dict);
        _pointarray = [[NSArray alloc] initWithObjects:@"10",@"120",@"40",@"20",@"50",@"30",@"20",@"110",@"140",@"30",@"80",@"60",@"70",@"100",@"20",@"110",@"90",@"70",@"50",@"40",@"10", nil];
        [_lineChartView setArray:_pointarray];
        [_lineChartView setNeedsDisplay];
    }];
    
}

- (void)setdateLabel
{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy年MM月dd日"];
    NSString *datestr = [formatter stringFromDate:date];
    _DateLabel.text = datestr;
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
