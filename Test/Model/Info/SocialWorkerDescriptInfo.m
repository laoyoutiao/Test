//
//  SocialWorkerDescriptInfo.m
//  Test
//
//  Created by 玉文辉 on 15/9/15.
//  Copyright (c) 2015年 玉文辉. All rights reserved.
//

#import "SocialWorkerDescriptInfo.h"
#import "NSDictionary+Safe.h"

@implementation SocialWorkerDescriptInfo

- (id)initWithDictionary:(NSDictionary *)dict
{
    if(self = [super init])
    {
        _bespoke_id = [dict safeStringForKey:@"bespoke_id"];  //预约编号
        _username = [dict safeStringForKey:@"username"];  //预约人账号
        _real_name = [dict safeStringForKey:@"real_name"];	 //预约人姓名
        _bespoker = [dict safeStringForKey:@"bespoker"];	 //社工账号
        _spokername = [dict safeStringForKey:@"spokername"]; //社工姓名
        _sex = [dict safeStringForKey:@"sex"];         //社工性别
        _head = [dict safeStringForKey:@"head"];		 //社工头像地址
        _item = [dict safeStringForKey:@"item"];		 //服务项目
        _bespoketime = [dict safeStringForKey:@"bespoketime"]; //预约时间
        _starttime = [dict safeStringForKey:@"starttime"];	 //服务开始时间
        _endtime = [dict safeStringForKey:@"endtime"];	 //服务结束时间
        _address = [dict safeStringForKey:@"address"];	 //服务地址
        _statue = [dict safeStringForKey:@"statue"]; 	 //预约接受状态(接受/拒绝)
        _realdelete = [dict safeStringForKey:@"realdelete"];	 //预约人删除
        _spokdelete = [dict safeStringForKey:@"spokdelete"];	 //社工删除
        _timestatue = [dict safeStringForKey:@"timestatue"];	 //服务进行状态(待进行/进行中/到期)
        _remark = [dict safeStringForKey:@"remark"];      //备注
        _pnum = [dict safeIntegerForKey:@"pnum"];
    }
    return self;
}

+ (NSArray *)instanceArrayDictFromDict:(NSDictionary *)dict
{
    NSMutableArray *instanceArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < [dict count]; i ++){
        [instanceArray  addObject:[dict objectForKey:[NSString stringWithFormat:@"%d",i]]];
    }
    return [NSArray arrayWithArray:instanceArray];
}

@end
