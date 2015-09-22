//
//  HealthRemindViewController.m
//  Test
//
//  Created by 玉文辉 on 15/8/5.
//  Copyright (c) 2015年 玉文辉. All rights reserved.
//

#import "HealthRemindViewController.h"
#import "FSCalendar.h"
#import "ScheduleViewController.h"

@interface HealthRemindViewController ()<FSCalendarDelegate,FSCalendarDataSource>
@property (weak, nonatomic) IBOutlet FSCalendar *FSCalendarView;
@property (weak, nonatomic) IBOutlet UILabel *TimeLabel;
@end

@implementation HealthRemindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self ReviseNavigation];
    [self setCalendarView];
    [self setLabelorButton];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)ReviseNavigation
{
    self.title = @"健康提醒";
}

- (void)setCalendarView
{
    _FSCalendarView.appearance.weekdayTextColor = [UIColor blueColor];
    _FSCalendarView.appearance.headerTitleColor = [UIColor blueColor];
    _FSCalendarView.appearance.eventColor = [UIColor blueColor];
    _FSCalendarView.appearance.selectionColor = [UIColor greenColor];
    _FSCalendarView.appearance.headerDateFormat = @"yyyy年MM月";
    _FSCalendarView.appearance.todayColor = [UIColor redColor];
    _FSCalendarView.appearance.cellStyle = FSCalendarCellStyleCircle;
    _FSCalendarView.appearance.headerMinimumDissolvedAlpha = 0.2;
    
}

- (void)setLabelorButton
{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    _TimeLabel.text = [formatter stringFromDate:date];
//    NSString *time = @"2015-08-19 12:10:10  ";
//    NSDate *date1 = [formatter dateFromString:time];
//    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
//    unsigned int unitFlags = NSCalendarUnitSecond;
//    NSDateComponents *comps = [gregorian components:unitFlags fromDate:date1 toDate:date options:0];
//    NSLog(@"%@",date1);
    
}

- (IBAction)ClickAddButton:(id)sender {
    ScheduleViewController *scheduleView = [self.storyboard instantiateViewControllerWithIdentifier:@"ScheduleView"];
    [self.navigationController pushViewController:scheduleView animated:YES];
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
