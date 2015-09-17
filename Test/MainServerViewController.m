//
//  MainServerViewController.m
//  Test
//
//  Created by 玉文辉 on 15/8/1.
//  Copyright (c) 2015年 玉文辉. All rights reserved.
//

#import "MainServerViewController.h"
#import "SocialWorkerViewController.h"
#import "ShopViewController.h"
#import "ThingViewController.h"
#import "MessageViewController.h"

@interface MainServerViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MainServerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
    self.title = @"便民服务";
    

}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ServerTableViewCell" forIndexPath:indexPath];
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"社工预约";
            break;
            
        case 1:
            cell.textLabel.text = @"商户信息";
            break;
            
        case 2:
            cell.textLabel.text = @"老人办事";
            break;
            
        case 3:
            cell.textLabel.text = @"我的消息";
            break;
            
        default:
            break;
    }
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SocialWorkerViewController *socialworkerview = [self.storyboard instantiateViewControllerWithIdentifier:@"SocialWorkerView"];
    ShopViewController *shopview = [self.storyboard instantiateViewControllerWithIdentifier:@"ShopView"];
    ThingViewController *thingview = [self.storyboard instantiateViewControllerWithIdentifier:@"ThingView"];
    MessageViewController *messageview = [self.storyboard instantiateViewControllerWithIdentifier:@"MessageView"];
    switch (indexPath.row) {
        case 0:
            [self.navigationController pushViewController:socialworkerview animated:YES];
            break;
            
        case 1:
            [self.navigationController pushViewController:shopview animated:YES];
            break;
            
        case 2:
            [self.navigationController pushViewController:thingview animated:YES];
            break;
            
        case 3:
            [self.navigationController showViewController:messageview sender:nil];
            break;
            
        default:
            break;
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
