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

@interface ShopViewController ()
@property (weak, nonatomic) IBOutlet UIView *TabbarView;
@property (weak, nonatomic) IBOutlet UITableView *TableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *TabbarViewHeight;
@property (strong, nonatomic) ServerShopMessage *servershopmessage;
@property (strong, nonatomic) HotWheelsOfFrittersView *hotwheelsview;
@property (assign, nonatomic) NSInteger shopmessagetime;
@property (strong, nonatomic) NSMutableDictionary *shopmessagedict;
@end

@implementation ShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _servershopmessage = [ServerShopMessage sharedInstance];
    _shopmessagedict = [[NSMutableDictionary alloc] init];

    [self ReviseNavigation];
    [self setTabbarView];
    [self message];
    [self setTableView];
    // Do any additional setup after loading the view.
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)ReviseNavigation
{
    self.title = @"社工预约";
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithTitle:@"地图搜索" style:UIBarButtonItemStylePlain target:self action:@selector(clickMapSecrch:)];
    self.navigationItem.rightBarButtonItem = buttonItem;
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor blackColor];
    
    
}

- (void)clickMapSecrch:(UIButton *)button
{
    
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
    [DescBtn setTitle:@"只能排序" forState:UIControlStateNormal];
    [DescBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_TabbarView addSubview:DescBtn];
}

- (void)message
{
    [_servershopmessage GetShoppostCity:@"佛山市"];
    _shopmessagetime = 0;
    NSTimer *timer;
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(shopmessage:) userInfo:nil repeats:YES];
}

- (void)shopmessage:(NSTimer *)timer
{
    _shopmessagetime ++;
    [_shopmessagedict setDictionary:[_servershopmessage ResultCityShopDictionary]];
    if ([_shopmessagedict count]) {
        [_hotwheelsview stop];
        [_hotwheelsview removeFromSuperview];
        [timer invalidate];
        if ([[_shopmessagedict objectForKey:@"result"] isEqualToString:@"true"]) {
            [_shopmessagedict removeObjectForKey:@"result"];
            
            [_TableView setHidden:NO];
            [_TableView reloadData];
        }else
        {
            UIAlertView *alterview = [[UIAlertView alloc] initWithTitle:@"获取信息失败" message:[_shopmessagedict objectForKey:@"message"] delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
            [alterview show];
        }
    }
    if (_shopmessagetime > 20) {
        [_hotwheelsview stop];
        [_hotwheelsview removeFromSuperview];
        UIAlertView *alterview = [[UIAlertView alloc] initWithTitle:@"获取信息失败" message:@"网络连接超时" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
        [alterview show];
        [timer invalidate];
    }
}

- (void)setTableView
{
    _TableView.hidden = YES;
    _hotwheelsview = [[HotWheelsOfFrittersView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 2 - 40, [UIScreen mainScreen].bounds.size.height / 2 - 40, 80, 80)];
    _hotwheelsview.interval = 0.1;
    [_hotwheelsview start];
    [self.view addSubview:_hotwheelsview];
    

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
