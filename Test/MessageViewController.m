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
#import "DescriptViewController.h"
#import "SocialWorkerDescriptInfo.h"

@interface MessageViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *TableView;
@property (strong, nonatomic) HotWheelsOfFrittersView *HotWheelsView;
@property (assign, nonatomic) NSInteger BookMessageTime;
@property (strong, nonatomic) NSMutableDictionary *BookMessageDict;
@property (strong, nonatomic) NSArray *BookMessageDictArray;
@property (strong, nonatomic) UserInfo *userinfo;
@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDictionary *dict = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserInfo"];
    _userinfo = [[UserInfo alloc] initWithDictionary:dict];
    
    _BookMessageDict = [[NSMutableDictionary alloc] init];
    _BookMessageDictArray = [[NSArray alloc] init];
    
    [self workerMessage];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)ReviseNavigation
{
    self.title = @"我的消息";
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithTitle:@"待点评" style:UIBarButtonItemStylePlain target:self action:@selector(clickDescript)];
    self.navigationItem.rightBarButtonItem = buttonItem;
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor blackColor];
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

#pragma mark Respond Events

- (void)clickDescript
{
    
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
            _BookMessageDictArray = [SocialWorkerDescriptInfo instanceArrayDictFromDict:_BookMessageDict];
//            NSLog(@"%@",_BookMessageDict);
            [_TableView setHidden:NO];
            [_TableView reloadData];
        }else
        {
            UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"获取信息失败" message:[_BookMessageDict objectForKey:@"message"] delegate:self cancelButtonTitle:@"返回" otherButtonTitles:nil];
            [alertview show];
        }
    }
    if (_BookMessageTime > 20) {
        [_HotWheelsView stop];
        [_HotWheelsView removeFromSuperview];
        UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"获取信息失败" message:@"网络连接超时" delegate:self cancelButtonTitle:@"返回" otherButtonTitles:@"重新加载", nil];
        [alertview show];
        [timer invalidate];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else
    {
        [self setTableView];
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
    SocialWorkerDescriptInfo *info = [_BookMessageDictArray objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DescriptViewController *descriptview = [self.storyboard instantiateViewControllerWithIdentifier:@"DescriptView"];
    [self.navigationController pushViewController:descriptview animated:YES];
    SocialWorkerDescriptInfo *info = [_BookMessageDictArray objectAtIndex:indexPath.row];
    descriptview.bookid = info.bespoke_id;
    descriptview.socialworkername = info.spokername;
    descriptview.time = info.bespoketime;
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
