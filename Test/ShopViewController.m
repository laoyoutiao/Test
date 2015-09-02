//
//  ShopViewController.m
//  Test
//
//  Created by 玉文辉 on 15/8/3.
//  Copyright (c) 2015年 玉文辉. All rights reserved.
//

#import "ShopViewController.h"
#import "ServerShopMessage.h"
#import "HotWheelsOfFrittersView.h"
#import "ShopInfo.h"
#import "ShopMessageViewController.h"
#import "ShopTableViewCell.h"

@interface ShopViewController ()

@property (weak, nonatomic) IBOutlet UIView *TabbarView;
@property (weak, nonatomic) IBOutlet UITableView *TableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *TabbarViewHeight;

@property (strong, nonatomic) ShopTableViewCell *cell;
@property (strong, nonatomic) HotWheelsOfFrittersView *HotWheelsView;

@property (assign, nonatomic) NSInteger ShopMessageTime;
@property (strong, nonatomic) NSMutableDictionary *ShopMessageDict;
@property (strong, nonatomic) NSArray *ShopMessageDictArray;

@end

@implementation ShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _ShopMessageDict = [[NSMutableDictionary alloc] init];

    [self ReviseNavigation];
    [self setTabbarView];
    [self message];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark View

- (void)ReviseNavigation
{
    self.title = @"商户列表";
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithTitle:@"地图搜索" style:UIBarButtonItemStylePlain target:self action:@selector(clickMapSecrch:)];
    self.navigationItem.rightBarButtonItem = buttonItem;
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor blackColor];
}

- (void)message
{
    [self setTableView];
//    [[ServerShopMessage sharedInstance] GetShoppostCity:@"佛山市"];
    _ShopMessageTime = 0;
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(shopmessage:) userInfo:nil repeats:YES];
}

- (void)setTableView
{
    _TableView.hidden = YES;
    _HotWheelsView = [[HotWheelsOfFrittersView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 2 - 40, [UIScreen mainScreen].bounds.size.height / 2 - 40, 80, 80)];
    _HotWheelsView.interval = 0.1;
    [_HotWheelsView start];
    [self.view addSubview:_HotWheelsView];
}


- (void)setTabbarView
{
    CGFloat Width = [UIScreen mainScreen].bounds.size.width / 3;
    UIButton *kindBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, Width, _TabbarViewHeight.constant)];
    kindBtn.backgroundColor = [UIColor clearColor];
    [kindBtn setTitle:@"全部分类" forState:UIControlStateNormal];
    [kindBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_TabbarView addSubview:kindBtn];
    
    UIButton *AreaBtn = [[UIButton alloc] initWithFrame:CGRectMake(Width, 0, Width, _TabbarViewHeight.constant)];
    AreaBtn.backgroundColor = [UIColor clearColor];
    [AreaBtn setTitle:@"全部商区" forState:UIControlStateNormal];
    [AreaBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_TabbarView addSubview:AreaBtn];
    
    UIButton *DescBtn = [[UIButton alloc] initWithFrame:CGRectMake(Width * 2, 0, Width, _TabbarViewHeight.constant)];
    DescBtn.backgroundColor = [UIColor clearColor];
    [DescBtn setTitle:@"智能排序" forState:UIControlStateNormal];
    [DescBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_TabbarView addSubview:DescBtn];
}

#pragma mark TabelViewDelegate or Datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_ShopMessageDictArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    _cell = [tableView dequeueReusableCellWithIdentifier:@"ShopTableViewCell" forIndexPath:indexPath];
    [_cell InfoOfCell:[_ShopMessageDictArray objectAtIndex:indexPath.row]];
    tableView.rowHeight = [_cell HeighTofCell];
    return _cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ShopMessageViewController *ShopMessageView = [self.storyboard instantiateViewControllerWithIdentifier:@"ShopMessageView"];
    ShopMessageView.info = [_ShopMessageDictArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:ShopMessageView animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

#pragma mark Respond Event


- (void)clickMapSecrch:(UIButton *)button
{
    
}

- (void)shopmessage:(NSTimer *)timer
{
    _ShopMessageTime ++;
    [_ShopMessageDict setDictionary:[[ServerShopMessage sharedInstance] ResultCityShopDictionary]];
    if ([_ShopMessageDict count]) {
        [_HotWheelsView stop];
        [_HotWheelsView removeFromSuperview];
        [timer invalidate];
        if ([[_ShopMessageDict objectForKey:@"result"] isEqualToString:@"true"]) {
            [_ShopMessageDict removeObjectForKey:@"result"];
            _ShopMessageDictArray = [ShopInfo instanceArrayDictFromDict:_ShopMessageDict];
//            NSLog(@"%@",_ShopMessageDictArray);
            [_TableView setHidden:NO];
            [_TableView reloadData];
        }else
        {
            UIAlertView *alterview = [[UIAlertView alloc] initWithTitle:@"获取信息失败" message:[_ShopMessageDict objectForKey:@"message"] delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
            [alterview show];
        }
    }
    if (_ShopMessageTime > 20) {
        [_HotWheelsView stop];
        [_HotWheelsView removeFromSuperview];
        UIAlertView *alterview = [[UIAlertView alloc] initWithTitle:@"获取信息失败" message:@"网络连接超时" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
        [alterview show];
        [timer invalidate];
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
