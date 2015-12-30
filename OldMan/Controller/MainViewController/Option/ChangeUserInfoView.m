//
//  ChangeUserInfoView.m
//  Test
//
//  Created by 玉文辉 on 15/9/14.
//  Copyright (c) 2015年 玉文辉. All rights reserved.
//

#import "ChangeUserInfoView.h"
#import "UserInfo.h"
#import "MyHeader.h"

@interface ChangeUserInfoView ()<UITextFieldDelegate,UITextViewDelegate>
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
    
    _AccountBtn.tag = TagNumber(0);
    _AgeBtn.tag = TagNumber(1);
    _SexBtn.tag = TagNumber(2);
    _AddressBtn.tag = TagNumber(3);
    _PhoneBtn.tag = TagNumber(4);
    _RealNameBtn.tag = TagNumber(5);
    // Do view setup here.
}

- (IBAction)ClickBtn:(id)sender {
    UIButton *button = sender;
    NSLogInteger(button.tag);
    UITextField *field = [[UITextField alloc] initWithFrame:CGRectMake(button.frame.origin.x, button.frame.origin.y, button.frame.size.width, button.frame.size.height)];
    field.returnKeyType = UIReturnKeyDone;
    field.tag = button.tag;
    field.delegate = self;
    [field becomeFirstResponder];
    button.hidden = YES;
    field.layer.borderWidth = 0.5;
    [self.view addSubview:field];
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    NSLog(@"1");
    [textView resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    switch (textField.tag) {
        case TagNumber(0):
            _AccountBtn.hidden = NO;
            break;
            
        case TagNumber(1):
            _AgeBtn.hidden = NO;
            break;
            
        case TagNumber(2):
            _SexBtn.hidden = NO;
            break;
            
        case TagNumber(3):
            _AddressBtn.hidden = NO;
            break;
            
        case TagNumber(4):
            _PhoneBtn.hidden = NO;
            break;
            
        case TagNumber(5):
            _RealNameBtn.hidden = NO;
            break;
            
        default:
            break;
    }
    if (![textField.text isEqualToString:@""])
    {
        switch (textField.tag) {
            case TagNumber(0):
                [_AccountBtn setTitle:[NSString stringWithFormat:@"账号 : %@",textField.text] forState:UIControlStateNormal];
                break;
                
            case TagNumber(1):
                [_AgeBtn setTitle:[NSString stringWithFormat:@"年龄 : %@",textField.text] forState:UIControlStateNormal];
                break;
                
            case TagNumber(2):
                [_SexBtn setTitle:[NSString stringWithFormat:@"性别 : %@",textField.text] forState:UIControlStateNormal];
                break;
                
            case TagNumber(3):
                [_AddressBtn setTitle:[NSString stringWithFormat:@"地址 : %@",textField.text] forState:UIControlStateNormal];
                break;
                
            case TagNumber(4):
                [_PhoneBtn setTitle:[NSString stringWithFormat:@"电话 : %@",textField.text] forState:UIControlStateNormal];
                break;
                
            case TagNumber(5):
                [_RealNameBtn setTitle:[NSString stringWithFormat:@"真实姓名 : %@",textField.text] forState:UIControlStateNormal];
                break;
                
            default:
                break;
        }
    }
    [textField removeFromSuperview];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}



@end
