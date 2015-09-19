//
//  ServerShopMessage.h
//  Test
//
//  Created by 玉文辉 on 15/8/13.
//  Copyright (c) 2015年 玉文辉. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, SelectKind){
    SelectKindCity = 0,
    SelectKindArea = 1
};

@interface ServerShopMessage : NSObject

+(ServerShopMessage *)sharedInstance;

//获取商店
- (void)GetShoppostString:(NSString *)string SelectKind:(SelectKind)selectkind;

- (NSDictionary *)ResultCityShopDictionary;

//获取商店商品
- (void)InfoOfShoppostShopID:(NSString *)shopid;

- (NSDictionary *)ResultShopInfoDictionary;


@end
