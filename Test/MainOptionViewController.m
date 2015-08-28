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

@interface MainOptionViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) ServerHeadImage *serverHeadimage;
@property (strong, nonatomic) UserInfo *userinfo;
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
            return 70;
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
            UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://192.168.1.146:8080/SmartPlatformWeb/%@",_userinfo.head]]]];
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(cell.bounds.size.width - (cell.bounds.size.width - 30) / 4, 10, (cell.bounds.size.width - 70) / 4, cell.bounds.size.height - 20)];
            [button setImage:image forState:UIControlStateNormal];
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
                [button addTarget:self action:@selector(clickInfoButton:) forControlEvents:UIControlEventTouchUpInside];
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
    }
}

#pragma mark Respond Event

- (void)clickInfoButton:(UIButton *)button
{
    
}

- (void)clickHeadImage:(UIButton *)button
{
    _serverHeadimage = [ServerHeadImage sharedInstance];
//    [_serverHeadimage HeadImagepostUsername:@"yuwen" Image:button.imageView.image];
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
