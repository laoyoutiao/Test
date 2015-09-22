//
//  ShopTableViewCell.m
//  Test
//
//  Created by 玉文辉 on 15/8/28.
//  Copyright (c) 2015年 玉文辉. All rights reserved.
//

#import "ShopTableViewCell.h"



@interface ShopTableViewCell ()



@end

@implementation ShopTableViewCell

- (void)awakeFromNib {
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void)InfoOfCell:(ShopInfo *)info
{
    _NameLabel.text = [NSString stringWithFormat:@"%@",info.shop_name];
    _AddressLabel.text = [NSString stringWithFormat:@"地址 : %@",info.address];
    _DistanceLabel.text = [NSString stringWithFormat:@"%.1f Km",info.distance];
    _PriceLabel.text = [NSString stringWithFormat:@"价格 : %.1f 元",info.perprice];
    [_ImageView setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://192.168.1.146:8080/SmartPlatformWeb/%@",info.image]]]]];
    
}




@end
