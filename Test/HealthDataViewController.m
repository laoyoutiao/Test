//
//  HealthDataViewController.m
//  Test
//
//  Created by 玉文辉 on 15/8/5.
//  Copyright (c) 2015年 玉文辉. All rights reserved.
//

#import "HealthDataViewController.h"
#import "LineChartView.h"

@interface HealthDataViewController ()
@property (weak, nonatomic) IBOutlet UIView *LineView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *LineViewHeigth;
@property (weak, nonatomic) IBOutlet UILabel *DateLabel;

@end

@implementation HealthDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
    LineChartView *lineChartView = [[LineChartView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, _LineViewHeigth.constant)];
    
    
    NSMutableArray *pointArr = [[NSMutableArray alloc]init];
    
    //生成随机点
    [pointArr addObject:[NSValue valueWithCGPoint:CGPointMake(50*0, 30)]];
    [pointArr addObject:[NSValue valueWithCGPoint:CGPointMake(50*1, 40)]];
    [pointArr addObject:[NSValue valueWithCGPoint:CGPointMake(50*2, 70)]];
    [pointArr addObject:[NSValue valueWithCGPoint:CGPointMake(50*3, 30)]];
    [pointArr addObject:[NSValue valueWithCGPoint:CGPointMake(50*4, 20)]];
    [pointArr addObject:[NSValue valueWithCGPoint:CGPointMake(50*5, 55)]];
    [pointArr addObject:[NSValue valueWithCGPoint:CGPointMake(50*6, 80)]];
    
    //竖轴
    NSMutableArray *vArr = [[NSMutableArray alloc]initWithCapacity:pointArr.count-1];
    for (int i=0; i<9; i++) {
        [vArr addObject:[NSString stringWithFormat:@"%d",i*20]];
    }
    
    //横轴
    NSMutableArray *hArr = [[NSMutableArray alloc]initWithCapacity:pointArr.count-1];
    
    for (int i = 0;i < 30;i++)
    {
        [hArr addObject:[NSString stringWithFormat:@"%d",i * 2]];
    }
    
    [lineChartView setHDesc:hArr];
    [lineChartView setVDesc:vArr];
    [lineChartView setArray:pointArr];
    [_LineView addSubview:lineChartView];
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
