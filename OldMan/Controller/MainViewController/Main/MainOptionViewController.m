//
//  MainOptionViewController.m
//  Test
//
//  Created by 玉文辉 on 15/8/1.
//  Copyright (c) 2015年 玉文辉. All rights reserved.
//

#import "MainOptionViewController.h"
#import "ServerHeadImage.h"
#import "LoginRegisterViewController.h"
#import "UserInfo.h"
#import "ChangeUserInfoView.h"
#import "EquipmentNumberViewController.h"
#import "ServerUserLocation.h"

@interface MainOptionViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) ServerHeadImage *serverHeadimage;
@property (strong, nonatomic) UserInfo *userinfo;
@property (nonatomic) BOOL state;
@end

@implementation MainOptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDictionary *dict = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserInfo"];
    _userinfo = [[UserInfo alloc] initWithDictionary:dict];
    
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
    self.title = @"设置";
}

#pragma mark TableViewDelegate or Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        case 1:
            return 80;
            break;
            
        case 2:
            return 50;
            break;
            
        case 3:
            return 50;
            break;
            
        default:
            return 0;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if (indexPath.row < 2) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"OptionCellFirst" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row == 0) {
            UIImage *image = [UIImage imageWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"HeadImage"]];
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(cell.bounds.size.width - (cell.bounds.size.width - 30) / 4, 10, (cell.bounds.size.width - 70) / 4, cell.bounds.size.height - 20)];
            [button setImage:image forState:UIControlStateNormal];
            button.layer.masksToBounds = YES;
            button.layer.borderWidth = 0.5;
            button.layer.cornerRadius = (cell.bounds.size.height - 20) / 2;
            button.layer.borderColor = [UIColor grayColor].CGColor;
            [button addTarget:self action:@selector(clickHeadImage:) forControlEvents:UIControlEventTouchUpInside];
            button.backgroundColor = [UIColor redColor];
            [cell addSubview:button];
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, cell.bounds.size.width - (cell.bounds.size.width + 70) / 4, cell.bounds.size.height - 20)];
            label.numberOfLines = 2;
            label.text = [NSString stringWithFormat:@"用户名 : %@\n手表ID : %@",_userinfo.username,_userinfo.device_id];
            label.font = [UIFont systemFontOfSize:16];
            [cell addSubview:label];
            
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, cell.bounds.size.height - 1, cell.bounds.size.width, 1)];
            view.backgroundColor = [UIColor blackColor];
            [cell addSubview:view];
        }else
        {
            for (int i = 0; i < 4; i ++) {
                UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(20 + i * (cell.bounds.size.width - 30) / 4, 10, (cell.bounds.size.width - 70) / 4, cell.bounds.size.height - 20)];
                button.backgroundColor = [UIColor yellowColor];
                [cell addSubview:button];
                button.tag = indexPath.row + 100 + i;
                button.layer.masksToBounds = YES;
                button.layer.borderWidth = 0.5;
                button.layer.cornerRadius = (cell.bounds.size.height - 20) / 2;
                button.layer.borderColor = [UIColor grayColor].CGColor;
                [button addTarget:self action:@selector(clickInfoButton:) forControlEvents:UIControlEventTouchUpInside];
                if (i == 0) {
                    [button setTitle:@"资料" forState:UIControlStateNormal];
                }else if (i == 1)
                {
                    [button setTitle:@"分享" forState:UIControlStateNormal];
                }else if (i == 2)
                {
                    [button setTitle:@"关于我们" forState:UIControlStateNormal];
                    button.titleLabel.font = [UIFont systemFontOfSize:13];
                }else if (i == 3) {
                    [ServerUserLocation GetUserStatepostName:_userinfo.username Block:^(BOOL block){
                        _state = block;
                    }];
                    [button setTitle:_state ? @"监控已开启" : @"监控未开启" forState:UIControlStateNormal];
                    if(self.view.frame.size.height > 568)
                    {
                        button.titleLabel.font = [UIFont systemFontOfSize:13];
                    }else
                    {
                        button.titleLabel.font = [UIFont systemFontOfSize:12];
                    }
                }
                [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            }
        }
    }else
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"OptionCellSecond" forIndexPath:indexPath];
        switch (indexPath.row) {
            case 2:
                cell.textLabel.text = @"更换手表";
                break;
                
            case 3:
                cell.textLabel.text = @"退出登录";
                break;
                
            default:
                break;
        }
        cell.textLabel.textColor = [UIColor whiteColor];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 3)
    {
        LoginRegisterViewController *loginview = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginRegisterViewNavigation"];
        [self presentViewController:loginview animated:YES completion:nil];
    }else if (indexPath.row == 2)
    {
        EquipmentNumberViewController *eqipmentview = [self.storyboard instantiateViewControllerWithIdentifier:@"EquipmentNumberView"];
        [self.navigationController pushViewController:eqipmentview animated:YES];
    }
}

#pragma mark Respond Event

- (void)clickInfoButton:(UIButton *)button
{
    if(button.tag == 101)
    {
        ChangeUserInfoView *changeuserinfoview = [self.storyboard instantiateViewControllerWithIdentifier:@"ChangeUserInfoView"];
        [self.navigationController showViewController:changeuserinfoview sender:nil];
    }else if (button.tag == 104)
    {
        UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"监控状态" message:@"是否开启" delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
        [alertview show];
    }
}

- (void)clickHeadImage:(UIButton *)button
{
    _serverHeadimage = [ServerHeadImage sharedInstance];
//    [_serverHeadimage HeadImagepostUsername:@"yuwen" Image:button.imageView.image];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        BOOL tostate = !_state;
        [ServerUserLocation ChangeUserStateSwitchpostName:_userinfo.username ToState:tostate Block:^(BOOL block){
            BOOL resultstate = block;
            if(resultstate)
            {
                UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"监控状态" message:@"开启成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alertview show];
                UIButton *btn = (UIButton *)[self.view viewWithTag:104];
                [btn setTitle:@"监控已开启" forState:UIControlStateNormal];
            }else
            {
                UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"监控状态" message:@"开启失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alertview show];
                UIButton *btn = (UIButton *)[self.view viewWithTag:104];
                [btn setTitle:@"监控未开启" forState:UIControlStateNormal];
            }
        }];
    }
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
