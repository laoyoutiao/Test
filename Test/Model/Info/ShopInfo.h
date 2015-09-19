//
//  ShopInfo.h
//  Test
//
//  Created by 玉文辉 on 15/8/28.
//  Copyright (c) 2015年 玉文辉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface ShopInfo : NSObject

@property (assign, nonatomic) CGFloat distance;		//店铺离用户距离
@property (assign, nonatomic) CGFloat perprice;		//人均价格
@property (assign, nonatomic) CGFloat score;		//评分
@property (assign, nonatomic) NSInteger popularity;		//人气度

@property (strong, nonatomic) NSString * shop_id;   	//店铺id编号
@property (strong, nonatomic) NSString * shop_name;	//店铺名称
@property (strong, nonatomic) NSString * shop_type;	//店铺
@property (strong, nonatomic) NSString * province;	//店铺所在省份
@property (strong, nonatomic) NSString * city;		//店铺所在城市
@property (strong, nonatomic) NSString * area;		//店铺所在城区
@property (strong, nonatomic) NSString * town;		//店铺所在城镇
@property (strong, nonatomic) NSString * address;		//店铺详细地址
@property (strong, nonatomic) NSString * longitude;	//店铺经度
@property (strong, nonatomic) NSString * latitude;	//店铺纬度
@property (strong, nonatomic) NSString * phone;		//店铺联系电话
@property (strong, nonatomic) NSString * image;		//店铺头像
@property (strong, nonatomic) NSString * property;	//店铺二次分类
@property (strong, nonatomic) NSString * html;		//店铺主页
@property (strong, nonatomic) NSString * activity;	//活动描述

- (id)initWithDictionary:(NSDictionary *)dict;

+ (NSArray *)instanceArrayDictFromDict:(NSDictionary *)dict;

@end
