//
//  FallViewController.m
//  Test
//
//  Created by 玉文辉 on 15/8/3.
//  Copyright (c) 2015年 玉文辉. All rights reserved.
//

#import "FallViewController.h"

@interface FallViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) UITableView *tableview;
@end

@implementation FallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self ReviseNavigation];
    [self textLabelOrButton];
    [self fallTableView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark View

- (void)ReviseNavigation
{
    //    [self.navigationController setNavigationBarHidden:YES];
    [self.navigationController.navigationBar setBarTintColor:[UIColor grayColor]];
    self.title = @"摔倒报警";
}

- (void)textLabelOrButton
{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy年MM月dd日";
    NSString *time = [formatter stringFromDate:date];
    
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, 30)];
    textLabel.text = @"手表编号";
    textLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:textLabel];
    
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 94, [UIScreen mainScreen].bounds.size.width, 30)];
    timeLabel.text = time;
    timeLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:timeLabel];
    
    UIButton *nextButton = [[UIButton alloc] initWithFrame:CGRectMake(25, 94, 30, 30)];
    nextButton.backgroundColor = [UIColor redColor];
    [self.view addSubview:nextButton];
    
    UIButton *lastButton = [[UIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 55, 94, 30, 30)];
    lastButton.backgroundColor = [UIColor redColor];
    [self.view addSubview:lastButton];
}

- (void)fallTableView
{
    [self.view addSubview:self.tableview];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.bounces = NO;
}

- (UITableView *)tableview
{
   if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 140, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 160)];
    }
    return _tableview;
}

#pragma mark TableViewDelegate or Datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"UITableViewCell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"111\n222\n33333333333333333"];
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.backgroundColor = [UIColor blackColor];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    button.backgroundColor = [UIColor redColor];
    cell.accessoryView = button;
    tableView.rowHeight = 100;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
