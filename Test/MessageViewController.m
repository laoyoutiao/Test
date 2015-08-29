//
//  MessageViewController.m
//  Test
//
//  Created by 玉文辉 on 15/8/3.
//  Copyright (c) 2015年 玉文辉. All rights reserved.
//

#import "MessageViewController.h"
#import "UserInfo.h"
#import "ServerSocialWorkerMessage.h"
#import "HotWheelsOfFrittersView.h"

@interface MessageViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *TableView;
@property (strong, nonatomic) HotWheelsOfFrittersView *HotWheelsView;
@property (assign, nonatomic) NSInteger BookMessageTime;
@property (strong, nonatomic) NSMutableDictionary *BookMessageDict;
@property (strong, nonatomic) NSMutableArray *BookMessageDictArray;
@property (strong, nonatomic) UserInfo *userinfo;
@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDictionary *dict = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserInfo"];
    _userinfo = [[UserInfo alloc] initWithDictionary:dict];
    
    _BookMessageDict = [[NSMutableDictionary alloc] init];
    _BookMessageDictArray = [[NSMutableArray alloc] init];
    
    [self workerMessage];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)workerMessage
{
    [self setTableView];
    _BookMessageTime = 0;
    [[ServerSocialWorkerMessage sharedInstance] GetBookMessageUsername:_userinfo.username Usertype:_userinfo.usertype];
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(workermessage:) userInfo:nil repeats:YES];
}

- (void)setTableView
{
    _TableView.hidden = YES;
    _HotWheelsView = [[HotWheelsOfFrittersView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 2 - 40, [UIScreen mainScreen].bounds.size.height / 2 - 40, 80, 80)];
    _HotWheelsView.interval = 0.1;
    [_HotWheelsView start];
    [self.view addSubview:_HotWheelsView];
}

- (void)workermessage:(NSTimer *)timer
{
    _BookMessageTime ++;
    [_BookMessageDict setDictionary:[[ServerSocialWorkerMessage sharedInstance] ResultBookMessageDictionary]];
    if ([_BookMessageDict count]) {
        [_HotWheelsView stop];
        [_HotWheelsView removeFromSuperview];
        [timer invalidate];
        if ([[_BookMessageDict objectForKey:@"result"] isEqualToString:@"true"]) {
            [_BookMessageDict removeObjectForKey:@"result"];
//            _BookMessageDictArray = [SocialWorkerInfo instanceArrayDictFromDict:_WorkerMessageDict];
            NSLog(@"%@",_BookMessageDict);
            [_TableView setHidden:NO];
            [_TableView reloadData];
        }else
        {
            UIAlertView *alterview = [[UIAlertView alloc] initWithTitle:@"获取信息失败" message:[_BookMessageDict objectForKey:@"message"] delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
            [alterview show];
        }
    }
    if (_BookMessageTime > 20) {
        [_HotWheelsView stop];
        [_HotWheelsView removeFromSuperview];
        UIAlertView *alterview = [[UIAlertView alloc] initWithTitle:@"获取信息失败" message:@"网络连接超时" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
        [alterview show];
        [timer invalidate];
    }
}

#pragma mark TableViewDelegate or datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 30)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 30)];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"1";
    [view addSubview:label];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 180.0f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_BookMessageDictArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MessageTableViewCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor blackColor];
    return cell;
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
