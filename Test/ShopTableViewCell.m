//
//  ShopTableViewCell.m
//  Test
//
//  Created by 玉文辉 on 15/8/28.
//  Copyright (c) 2015年 玉文辉. All rights reserved.
//

#import "ShopTableViewCell.h"

@interface ShopTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *NameLabel;
@property (weak, nonatomic) IBOutlet UILabel *AddressLabel;
@property (weak, nonatomic) IBOutlet UILabel *DistanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *PriceLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HeightOfNameLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HeightOfAddressLabel;
@property (weak, nonatomic) IBOutlet UIImageView *ImageView;

@end

@implementation ShopTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (CGFloat)HeighTofCell
{
    return _HeightOfNameLabel.constant * 3 + 35     + _HeightOfAddressLabel.constant;
}

- (void)InfoOfCell:(ShopInfo *)info
{
    _NameLabel.text = [NSString stringWithFormat:@"%@",info.shop_name];
    _AddressLabel.text = [NSString stringWithFormat:@"地址 : %@",info.address];
    
    NSLog(@"%ld",_AddressLabel.text.length);
    if (_AddressLabel.text.length > 32) {
        _HeightOfAddressLabel.constant = 52;
    }else if(_AddressLabel.text.length > 16)
    {
        _HeightOfAddressLabel.constant = 38;
    }else
    {
        _HeightOfAddressLabel.constant = 20;
    }
    
    _DistanceLabel.text = [NSString stringWithFormat:@"%.1f Km",info.distance];
    _PriceLabel.text = [NSString stringWithFormat:@"价格 : %.1f 元",info.perprice];
    [_ImageView setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://192.168.1.146:8080/SmartPlatformWeb/%@",info.image]]]]];
    
}

@end
