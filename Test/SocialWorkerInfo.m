//
//  SocialWorkerInfo.m
//  Test
//
//  Created by 玉文辉 on 15/8/24.
//  Copyright (c) 2015年 玉文辉. All rights reserved.
//

#import "SocialWorkerInfo.h"
#import "NSDictionary+Safe.h"

@implementation SocialWorkerInfo

- (id)initWithDictionary:(NSDictionary *)dict
{
    if(self = [super init])
    {
        _address = [dict safeStringForKey:@"address"];
        _age= [dict safeIntegerForKey:@"age"];
        _area= [dict safeStringForKey:@"area"];
        _bindstatue= [dict safeStringForKey:@"bindstatue"];
        _bounder= [dict safeStringForKey:@"bounder"];
        _cellphone= [dict safeStringForKey:@"cellphone"];
        _city= [dict safeStringForKey:@"city"];
        _distance= [dict safeFloatForKey:@"distance"];
        _head= [dict safeStringForKey:@"head"];
        _height= [dict safeIntegerForKey:@"height"];
        _imgset= [dict safeStringForKey:@"imgset"];
        _introduce= [dict safeStringForKey:@"introduce"];
        _joincount= [dict safeIntegerForKey:@"joincount"];
        _latitude= [dict safeStringForKey:@"latitude"];
        _longitude= [dict safeStringForKey:@"longitude"];
        _pnum= [dict safeIntegerForKey:@"pnum"];
        _price= [dict safeStringForKey:@"price"];
        _score= [dict safeIntegerForKey:@"score"];
        _sex= [dict safeStringForKey:@"sex"];
        _skill= [dict safeStringForKey:@"skill"];
        _statue= [dict safeStringForKey:@"statue"];
        _userinfo_id= [dict safeIntegerForKey:@"userinfo_id"];
        _username= [dict safeStringForKey:@"username"];
        _weight= [dict safeIntegerForKey:@"weight"];
    }
    return self;
}

+ (NSArray *)instanceArrayDictFromDict:(NSDictionary *)dict
{
    NSMutableArray *instanceArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < [dict count]; i ++){
        [instanceArray  addObject:[[self alloc] initWithDictionary:[dict objectForKey:[NSString stringWithFormat:@"%d",i]]]];
    }
    return [NSArray arrayWithArray:instanceArray];
}

@end
