//
//  UserInfo.h
//  Test
//
//  Created by 玉文辉 on 15/8/27.
//  Copyright (c) 2015年 玉文辉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UserInfo : NSObject

@property (assign, nonatomic) NSInteger age;        //年龄
@property (assign, nonatomic) NSInteger height;		//身高
@property (assign, nonatomic) NSInteger weight;		//体重
@property (assign, nonatomic) NSInteger joincount;  //参与评分人数
@property (assign, nonatomic) NSInteger userinfo_id;
@property (assign, nonatomic) NSInteger pnum;
@property (assign, nonatomic) NSInteger score;		//评分
@property (assign, nonatomic) CGFloat distance;		//距离

@property (copy, nonatomic) NSString *address;      //地址
@property (copy, nonatomic) NSString *bindstatue;   //推送绑定状态
@property (copy, nonatomic) NSString *bounder;      //被绑老人账号
@property (copy, nonatomic) NSString *cellphone;    //联系电话
@property (copy, nonatomic) NSString *head;	        //头像地址
@property (copy, nonatomic) NSString *sex;		    //性别
@property (copy, nonatomic) NSString *birthday;     //生日
@property (copy, nonatomic) NSString *origo;	    //籍贯
@property (copy, nonatomic) NSString *username;     //用户账号
@property (copy, nonatomic) NSString *real_name;    //姓名
@property (copy, nonatomic) NSString *usertype;     //用户类型(社工/普通)
@property (copy, nonatomic) NSString *device_id;	//手环id号

@property (copy, nonatomic) NSString *imgset;		//风采图集
@property (copy, nonatomic) NSString *introduce;	//社工介绍
@property (copy, nonatomic) NSString *skill;		//社工技能
@property (copy, nonatomic) NSString *statue;		//空闲状态
@property (copy, nonatomic) NSString *latitude;	    //纬度
@property (copy, nonatomic) NSString *longitude;	//经度
@property (copy, nonatomic) NSString *price;        //服务价格
@property (copy, nonatomic) NSString *city;		    //服务城市
@property (copy, nonatomic) NSString *area;		    //服务地区

- (id)initWithDictionary:(NSDictionary *)dict;

@end
