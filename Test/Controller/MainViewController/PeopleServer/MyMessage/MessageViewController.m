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
    
    [self ReviseNavigation];
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

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MessageTableViewCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor blackColor];
    SocialWorkerDescriptInfo *info ;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, [UIScreen mainScreen].bounds.size.width - 10, 160)];
    [cell addSubview:label];
    label.text = [NSString stringWithFormat:@"\n预约对象 : %@\n预约编号 : %@\n预约状态 : %@\n服务内容 : %@\n服务地址 : %@\n预约时间 : %@\n",info.spokername,info.bespoke_id,info.statue,info.item,info.address,info.bespoketime];
    label.numberOfLines = 0;
    if ([info.address length] > 13) {
        tableView.rowHeight = tableView.rowHeight + 20;
        CGRect rect = label.frame;
        rect.size.height = rect.size.height + 20;
        label.frame = rect;
    }else if ([info.address length] > 31)
    {
        tableView.rowHeight = tableView.rowHeight + 40;
        CGRect rect = label.frame;
        rect.size.height = rect.size.height + 40;
        label.frame = rect;
    }
    label.textColor = [UIColor whiteColor];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    SocialWorkerDescriptInfo *info = [_BookMessageDictArray objectAtIndex:section];
    return info.bespoketime;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
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
