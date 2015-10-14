//
//  ShopMessageViewController.m
//  Test
//
//  Created by 玉文辉 on 15/8/10.
//  Copyright (c) 2015年 玉文辉. All rights reserved.
//

#import "ShopMessageViewController.h"

@interface ShopMessageViewController ()

@property (weak, nonatomic) IBOutlet UILabel *NameLabel;
@property (weak, nonatomic) IBOutlet UILabel *PriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *IntroduceLabel;
@property (weak, nonatomic) IBOutlet UILabel *TimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *WorkPhoneLabel;
@property (weak, nonatomic) IBOutlet UIButton *AddressButton;
@property (weak, nonatomic) IBOutlet UIButton *ShopPhoneButton;
@property (weak, nonatomic) IBOutlet UIImageView *ImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HeigthOfAddressButton;

@end

@implementation ShopMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self ReviseNavigation];
    [self setImage];
    [self SetLabelText];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)ReviseNavigation
{
    self.title = @"商店详情";
}

- (void)setImage
{
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://192.168.1.146:8080/SmartPlatformWeb/%@",_info.image]]];
    _ImageView.image = [UIImage imageWithData:data];
}

- (void)SetLabelText
{
    _NameLabel.text = [NSString stringWithFormat:@"商店名称 : %@",_info.shop_name];
    _PriceLabel.text = [NSString stringWithFormat:@"商店价格 : %.1f",_info.perprice];
    _IntroduceLabel.text = [NSString stringWithFormat:@"商店介绍 : %@",_info.activity ? : @""];
    _TimeLabel.text = [NSString stringWithFormat:@"有效期 : "];
    _WorkPhoneLabel.text = [NSString stringWithFormat:@"社工电话 : "];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width / 2 - 2.5, _HeigthOfAddressButton.constant)];
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:14];
    label.text = [NSString stringWithFormat:@"地址 : %@",_info.address];
    [_AddressButton addSubview:label];
    [_AddressButton setTitle:nil forState:UIControlStateNormal];

    [_ShopPhoneButton setTitle:[NSString stringWithFormat:@"电话 : %@",_info.phone] forState:UIControlStateNormal];
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
