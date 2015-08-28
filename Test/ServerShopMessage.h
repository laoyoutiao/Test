//
//  ServerShopMessage.h
//  Test
//
//  Created by 玉文辉 on 15/8/13.
//  Copyright (c) 2015年 玉文辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServerShopMessage : NSObject


+(ServerShopMessage *)sharedInstance;

//获取城市商店
- (void)GetShoppostCity:(NSString *)city;

- (NSDictionary *)ResultCityShopDictionary;

//获取范围商店
- (void)AreaOfShoppostBound:(NSString *)bound;

- (NSDictionary *)ResultAreaShopDictionary;

//获取商店商品
- (void)InfoOfShoppostShopID:(NSString *)shopid;

- (NSDictionary *)ResultShopInfoDictionary;


@end
