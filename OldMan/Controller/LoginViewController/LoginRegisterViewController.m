//
//  LoginRegisterViewController.m
//  Test
//
//  Created by 玉文辉 on 15/7/30.
//  Copyright (c) 2015年 玉文辉. All rights reserved.
//

#import "LoginRegisterViewController.h"
#import "EquipmentBindingViewController.h"
#import "ServerLoginOrRegister.h"
#import "RegistViewController.h"
#import "HotWheelsOfFrittersView.h"
#import "UserInfo.h"

@interface LoginRegisterViewController ()<UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UINavigationItem *NavigationItem;
@property (weak, nonatomic) IBOutlet UIImageView *HeadImageView;
@property (weak, nonatomic) IBOutlet UIButton *LoginButton;
@property (weak, nonatomic) IBOutlet UITextField *UserNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *PassWordTextField;
@property (strong, nonatomic) HotWheelsOfFrittersView *hotwheels;
@property (strong, nonatomic) UIView *hotwheelview;
@property (assign, nonatomic) NSInteger logintime;
@property (strong, nonatomic) NSDictionary *logindict;
@property (strong, nonatomic) UserInfo *userinfo;
@end

@implementation LoginRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%@",[NSArray class]);
    
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"UserInfo"];

    self.view.backgroundColor = [UIColor whiteColor];
    
    [self ReviseNavigation];
    
    [self SetHeadImageView];
    
    [self SetUserText];
    // Do any additional setup after loading the view.
}

#pragma mark View

- (void)ReviseNavigation
{
    self.NavigationItem.title = @"登录";
}

- (void)SetHeadImageView
{
    UIImage *image = [UIImage imageWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"HeadImage"]];
    _HeadImageView.image = image;
    _HeadImageView.layer.masksToBounds = YES;
    _HeadImageView.layer.cornerRadius = 50;
    _HeadImageView.layer.borderWidth = 0.5;
    _HeadImageView.layer.borderColor = [UIColor grayColor].CGColor;
    
}

- (void)SetUserText
{
    _UserNameTextField.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserName"];
    _PassWordTextField.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserPassword"];
}

#pragma mark Respond Events

- (IBAction)ClickLoginButton:(id)sender {
    if (![_UserNameTextField.text isEqualToString:@""] && ![_PassWordTextField.text isEqualToString:@""]) {
        [[ServerLoginOrRegister sharedInstance] LoginpostUsername:_UserNameTextField.text Password:_PassWordTextField.text];
        [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(getdict:) userInfo:nil repeats:YES];
        _logintime = 0;
        if (!_hotwheelview) {
            _hotwheelview = [[UIView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
            _hotwheelview.backgroundColor = [UIColor grayColor];
            _hotwheelview.alpha = 0.8;
            _hotwheels = [[HotWheelsOfFrittersView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 2 - 50, [UIScreen mainScreen].bounds.size.height / 2 - 114, 100, 100)];
            [_hotwheelview addSubview:_hotwheels];
            [self.view addSubview:_hotwheelview];
            [_hotwheels start];
        }
    }else if([_UserNameTextField.text isEqualToString:@""] || [_PassWordTextField.text isEqualToString:@""])
    {
        NSString *str = @"请输入账号/密码";
        UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:str message:@"错误:账号或密码为空" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
        [alertview show];
    }else
    {
        UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"登录失败" message:@"未知错误" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
        [alertview show];
    }
    
}

- (void)getdict:(NSTimer *)timer
{
    _logintime ++;
    _logindict = [[ServerLoginOrRegister sharedInstance] ResultLoginDictionary];
    if ([_logindict count]) {
        if ([[_logindict objectForKey:@"result"] isEqualToString:@"true"]) {
            NSDictionary *dict = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserInfo"];
            _userinfo = [[UserInfo alloc] initWithDictionary:dict];
            NSData *imagedata = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://192.168.1.146:8080/SmartPlatformWeb/%@",_userinfo.head]]];
            [[NSUserDefaults standardUserDefaults] setObject:imagedata forKey:@"HeadImage"];
            EquipmentBindingViewController *equipbingViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"EquipmentBindingView"];
            [self.navigationController pushViewController:equipbingViewController animated:YES];
            UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"登录成功" message:@"欢迎你使用本公司产品" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
            [alertview show];
            [timer invalidate];
            [[NSUserDefaults standardUserDefaults] setObject:_UserNameTextField.text forKey:@"UserName"];
            [[NSUserDefaults standardUserDefaults] setObject:_PassWordTextField.text forKey:@"UserPassword"];
            [_hotwheels stop];
            [_hotwheelview removeFromSuperview];
            _hotwheelview = nil;
        }else if([[_logindict objectForKey:@"result"] isEqualToString:@"false"])
        {
            [_hotwheels stop];
            [_hotwheelview removeFromSuperview];
            NSString *error = [_logindict objectForKey:@"message"];
            UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"登录失败" message:error delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
            [alertview show];
            [timer invalidate];
            _hotwheelview = nil;
        }else
        {
            [_hotwheels stop];
            [_hotwheelview removeFromSuperview];
            UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"登录失败" message:@"未知错误" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
            [alertview show];
            [timer invalidate];
            _hotwheelview = nil;
        }
    }else
    {
        NSLog(@"%ld",_logintime);
        if (_logintime >= 20) {
            UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"登录失败" message:@"连接超时" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
            [alertview show];
            [timer invalidate];
            [_hotwheels stop];
            [_hotwheelview removeFromSuperview];
            _hotwheelview = nil;
        }
    }
}

- (IBAction)ClickRegistButton:(id)sender {
    RegistViewController *registViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"RegistView"];
    [self.navigationController pushViewController:registViewController animated:YES];
}

#pragma mark ChangeView

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
