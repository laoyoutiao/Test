//
//  ChangeUserInfoView.m
//  Test
//
//  Created by 玉文辉 on 15/9/14.
//  Copyright (c) 2015年 玉文辉. All rights reserved.
//

#import "ChangeUserInfoView.h"
#import "UserInfo.h"

@interface ChangeUserInfoView ()
@property (weak, nonatomic) IBOutlet UIButton *AccountBtn;
@property (weak, nonatomic) IBOutlet UIButton *AgeBtn;
@property (weak, nonatomic) IBOutlet UIButton *SexBtn;
@property (weak, nonatomic) IBOutlet UIButton *AddressBtn;
@property (weak, nonatomic) IBOutlet UIButton *PhoneBtn;
@property (weak, nonatomic) IBOutlet UIButton *RealNameBtn;
@property (strong, nonatomic) UserInfo *userinfo;
@end

@implementation ChangeUserInfoView

- (void)viewDidLoad {
    [super viewDidLoad];
    NSDictionary *dict = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserInfo"];
    _userinfo = [[UserInfo alloc] initWithDictionary:dict];
    
    NSString *accounttext = [NSString stringWithFormat:@"账号 : %@",_userinfo.username ];
    NSString *agetext = [NSString stringWithFormat:@"年龄 : %@",_userinfo.age ? [NSString stringWithFormat:@"%ld",_userinfo.age] : @"暂无"];
    NSString *sex;
    if(_userinfo.sex)
    {
        sex = @"男";
    }else
    {
        sex = @"女";
    }
    NSString *sextext = [NSString stringWithFormat:@"性别 : %@",sex];
    NSString *addresstext = [NSString stringWithFormat:@"地址 : %@",_userinfo.address ? : @"暂无"];
    NSString *phonetext = [NSString stringWithFormat:@"电话 : %@",_userinfo.cellphone ? : @"暂无"];
    NSString *realnametext = [NSString stringWithFormat:@"真实姓名 : %@",_userinfo.real_name ? : @"暂无"];
    
    [_AccountBtn setTitle:accounttext forState:UIControlStateNormal];
    [_AgeBtn setTitle:agetext forState:UIControlStateNormal];
    [_SexBtn setTitle:sextext forState:UIControlStateNormal];
    [_AddressBtn setTitle:addresstext forState:UIControlStateNormal];
    _AddressBtn.titleLabel.numberOfLines = 3;

    [_PhoneBtn setTitle:phonetext forState:UIControlStateNormal];
    [_RealNameBtn setTitle:realnametext forState:UIControlStateNormal];
    // Do view setup here.
}

@end
