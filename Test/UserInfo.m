//
//  UserInfo.m
//  Test
//
//  Created by 玉文辉 on 15/8/27.
//  Copyright (c) 2015年 玉文辉. All rights reserved.
//

#import "UserInfo.h"
#import "NSDictionary+Safe.h"

@implementation UserInfo

- (id)initWithDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        _age = [dict safeIntegerForKey:@"age"];
        _height = [dict safeIntegerForKey:@"height"];
        _weight = [dict safeIntegerForKey:@"weight"];
        _joincount = [dict safeIntegerForKey:@"joincount"];
        _userinfo_id = [dict safeIntegerForKey:@"userinfo_id"];
        _pnum = [dict safeIntegerForKey:@"pnum"];
        _score = [dict safeIntegerForKey:@"score"];
        _distance = [dict safeFloatForKey:@"distance"];
        
        _address  =  [dict safeStringForKey:@"address"];
        _bindstatue = [dict safeStringForKey:@"bindstatue"];
        _bounder = [dict safeStringForKey:@"bounder"];
        _cellphone = [dict safeStringForKey:@"cellphone"];
        _head = [dict safeStringForKey:@"head"];
        _sex = [dict safeStringForKey:@"sex"];
        _birthday = [dict safeStringForKey:@"birthday"];
        _origo = [dict safeStringForKey:@"origo"];
        _username = [dict safeStringForKey:@"username"];
        _real_name = [dict safeStringForKey:@"real_name"];
        _usertype = [dict safeStringForKey:@"usertype"];
        _device_id = [dict safeStringForKey:@"device_id"];
        
        _imgset = [dict safeStringForKey:@"imgset"];
        _introduce = [dict safeStringForKey:@"introduce"];
        _skill = [dict safeStringForKey:@"sikll"];
        _statue = [dict safeStringForKey:@"statue"];
        _latitude = [dict safeStringForKey:@"latitude"];
        _longitude = [dict safeStringForKey:@"longitude"];
        _price = [dict safeStringForKey:@"price"];
        _city = [dict safeStringForKey:@"city"];
        _area = [dict safeStringForKey:@"area"];
    }
    return self;
}

@end
