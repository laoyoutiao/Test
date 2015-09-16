//
//  SocialWorkerDescriptInfo.h
//  Test
//
//  Created by 玉文辉 on 15/9/15.
//  Copyright (c) 2015年 玉文辉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SocialWorkerDescriptInfo : UIViewController

@property (strong, nonatomic) NSString *bespoke_id;  //预约编号
@property (strong, nonatomic) NSString *username;	 //预约人账号
@property (strong, nonatomic) NSString *real_name;	 //预约人姓名
@property (strong, nonatomic) NSString *bespoker;	 //社工账号
@property (strong, nonatomic) NSString *spokername;	 //社工姓名
@property (strong, nonatomic) NSString *sex;         //社工性别
@property (strong, nonatomic) NSString *head;		 //社工头像地址
@property (strong, nonatomic) NSString *item;		 //服务项目
@property (strong, nonatomic) NSString *bespoketime; //预约时间
@property (strong, nonatomic) NSString *starttime;	 //服务开始时间
@property (strong, nonatomic) NSString *endtime;	 //服务结束时间
@property (strong, nonatomic) NSString *address;	 //服务地址
@property (strong, nonatomic) NSString *statue;	 	 //预约接受状态(接受/拒绝)
@property (strong, nonatomic) NSString *realdelete;	 //预约人删除
@property (strong, nonatomic) NSString *spokdelete;	 //社工删除
@property (strong, nonatomic) NSString *timestatue;	 //服务进行状态(待进行/进行中/到期)
@property (strong, nonatomic) NSString *remark;      //备注
@property (assign, nonatomic) NSInteger pnum;

- (id)initWithDictionary:(NSDictionary *)dict;

+ (NSArray *)instanceArrayDictFromDict:(NSDictionary *)dict;

@end
