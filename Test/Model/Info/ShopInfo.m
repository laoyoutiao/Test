//
//  ShopInfo.m
//  Test
//
//  Created by 玉文辉 on 15/8/28.
//  Copyright (c) 2015年 玉文辉. All rights reserved.
//

#import "ShopInfo.h"
#import "NSDictionary+Safe.h"

@implementation ShopInfo

- (id)initWithDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        _distance = [dict safeFloatForKey:@"distance"];
        _perprice = [dict safeFloatForKey:@"perprice"];
        _score = [dict safeFloatForKey:@"score"];
        _popularity = [dict safeIntegerForKey:@"popularity"];
        
        _shop_id = [dict safeStringForKey:@"shop_id"];
        _shop_name = [dict safeStringForKey:@"shop_name"];
        _shop_type = [dict safeStringForKey:@"shop_type"];
        _province = [dict safeStringForKey:@"province"];
        _city = [dict safeStringForKey:@"city"];
        _area = [dict safeStringForKey:@"area"];
        _town = [dict safeStringForKey:@"town"];
        _address = [dict safeStringForKey:@"address"];
        _longitude = [dict safeStringForKey:@"longitude"];
        _latitude = [dict safeStringForKey:@"latitude"];
        _phone = [dict safeStringForKey:@"phone"];
        _image = [dict safeStringForKey:@"image"];
        _property = [dict safeStringForKey:@"propery"];
        _html = [dict safeStringForKey:@"html"];
        _activity = [dict safeStringForKey:@"activity"];
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
