//
//  SocialWorkerViewController.m
//  Test
//
//  Created by 玉文辉 on 15/8/3.
//  Copyright (c) 2015年 玉文辉. All rights reserved.
//

#import "SocialWorkerViewController.h"
#import "WorkerMessageViewController.h"
#import "SocialWorkerTableViewCell.h"
#import "ServerSocialWorkerMessage.h"
#import "SocialWorkerInfo.h"
#import "HotWheelsOfFrittersView.h"

@interface SocialWorkerViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *ScrollerView;
@property (weak, nonatomic) IBOutlet UITableView *TableView;
@property (strong, nonatomic) SocialWorkerTableViewCell *cell;
@property (strong, nonatomic) ServerSocialWorkerMessage *ServerSocialWorkerMessage;
@property (strong, nonatomic) HotWheelsOfFrittersView *HotWheelsView;
@property (strong, nonatomic) NSArray *WorkerMessageDictArray;
@property (assign, nonatomic) NSInteger WorkerMessageTime;
@property (strong, nonatomic) NSMutableDictionary *WorkerMessageDict;
@property (assign, nonatomic) BOOL IsFirst;
@end

@implementation SocialWorkerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _ServerSocialWorkerMessage = [ServerSocialWorkerMessage sharedInstance];
    _WorkerMessageDict = [[NSMutableDictionary alloc] init];
    _WorkerMessageDictArray = [[NSArray alloc] init];
    
    [self setScorllerView];
    [self ReviseNavigation];
    [self workerMessage];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark View

- (void)setScorllerView
{
    _ScrollerView.delegate = self;
    NSArray *array = [[NSArray alloc] initWithObjects:@"南海区",@"三水区",@"禅城区",@"高明区",@"顺德区", nil];
    CGFloat Width = [UIScreen mainScreen].bounds.size.width / 3;
    [_ScrollerView setContentSize:CGSizeMake(Width * 5, 0)];
    for (int i = 0; i < 5; i ++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(Width * i, 0, Width, 40)];
        button.tag = 200 + i;
        button.backgroundColor = [UIColor blackColor];
        [button setTitle:[array objectAtIndex:i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(selectLocation:) forControlEvents:UIControlEventTouchUpInside];
        [_ScrollerView addSubview:button];
    }
}

- (void)ReviseNavigation
{
    self.title = @"社工预约";
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithTitle:@"智能排序" style:UIBarButtonItemStylePlain target:self action:@selector(clickLevelSeque:)];
    self.navigationItem.rightBarButtonItem = buttonItem;
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor blackColor];
}

- (void)workerMessage
{
    _IsFirst = YES;
    [self setTableView];
    [_ServerSocialWorkerMessage GetWorkerpostCity:@"佛山市"];
    _WorkerMessageTime = 0;
    NSTimer *timer;
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(workermessage:) userInfo:nil repeats:YES];
}

- (void)setTableView
{
    _TableView.hidden = YES;
    _HotWheelsView = [[HotWheelsOfFrittersView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 2 - 40, [UIScreen mainScreen].bounds.size.height / 2 - 40, 80, 80)];
    _HotWheelsView.interval = 0.1;
    [_HotWheelsView start];
    [self.view addSubview:_HotWheelsView];
}

#pragma mark Respond Event

- (void)workermessage:(NSTimer *)timer
{
    _WorkerMessageTime ++;
    [_WorkerMessageDict setDictionary:[_ServerSocialWorkerMessage ResultWorkerDictionary]];
    if ([_WorkerMessageDict count]) {
        [_HotWheelsView stop];
        [_HotWheelsView removeFromSuperview];
        [timer invalidate];
        if ([[_WorkerMessageDict objectForKey:@"result"] isEqualToString:@"true"]) {
            [_WorkerMessageDict removeObjectForKey:@"result"];
            _WorkerMessageDictArray = [SocialWorkerInfo instanceArrayDictFromDict:_WorkerMessageDict];
//            NSLog(@"%@",_WorkerMessageDict);
            [_TableView setHidden:NO];
            [_TableView reloadData];
        }else
        {
            UIAlertView *alterview = [[UIAlertView alloc] initWithTitle:@"获取信息失败" message:[_WorkerMessageDict objectForKey:@"message"] delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
            [alterview show];
            if (!_IsFirst) {
                [_TableView setHidden:NO];
            }
        }
        _IsFirst = NO;
    }
    if (_WorkerMessageTime > 20) {
        [_HotWheelsView stop];
        [_HotWheelsView removeFromSuperview];
        UIAlertView *alterview = [[UIAlertView alloc] initWithTitle:@"获取信息失败" message:@"网络连接超时" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
        [alterview show];
        [timer invalidate];
        if (!_IsFirst) {
            [_TableView setHidden:NO];
        }
        _IsFirst = NO;
    }
}


- (void)selectLocation:(UIButton *)button
{
    [self setTableView];
    NSString *area = button.titleLabel.text;
    [_ServerSocialWorkerMessage GetWorkerpostCity:@"佛山市" Area:area];
    _WorkerMessageTime = 0;
    NSTimer *timer;
    timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(workermessage:) userInfo:nil repeats:YES];
}

- (void)clickLevelSeque:(UIButton *)button
{
    
}

#pragma mark TableViewDelegate or datasource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_WorkerMessageDictArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    _cell = [tableView dequeueReusableCellWithIdentifier:@"SocialWorkerTableViewCell" forIndexPath:indexPath];
    tableView.rowHeight = [_cell HeighTofCell];
    [_cell InfoOfCell:[_WorkerMessageDictArray objectAtIndex:indexPath.row]];
    return _cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    WorkerMessageViewController *WorkerMessageView = [self.storyboard instantiateViewControllerWithIdentifier:@"WorkerMessageView"];
    WorkerMessageView.info = [_WorkerMessageDictArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:WorkerMessageView animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
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
