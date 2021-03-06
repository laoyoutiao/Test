//
//  ServerShopMessage.m
//  Test
//
//  Created by 玉文辉 on 15/8/13.
//  Copyright (c) 2015年 玉文辉. All rights reserved.
//

#import "ServerShopMessage.h"
#import "AFNetworking.h"

@interface ServerShopMessage ()

@property (strong, nonatomic) __block NSDictionary *resultcityshopdict;
@property (strong, nonatomic) __block NSDictionary *resultareashopdict;
@property (strong, nonatomic) __block NSDictionary *resultshopinfodict;


@end

@implementation ServerShopMessage

+(ServerShopMessage *)sharedInstance
{
    static ServerShopMessage *sharedManager;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[ServerShopMessage alloc] init];
    });
    
    return sharedManager;
}

#pragma mark

- (void)GetShoppostString:(NSString *)string SelectKind:(SelectKind)selectkind
{
    switch (selectkind) {
        case 0:
            [self GetShoppostCity:string];
            break;
            
        case 1:
            
            break;
            
        default:
            break;
    }
}

- (void)GetShoppostCity:(NSString *)city
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *parameters = @{@"operate": @"look",
                                 @"city": city};
    manager.requestSerializer.timeoutInterval = 20;
    [manager POST:@"http://192.168.1.146:8080/SmartPlatformWeb/servlet/ShopManage" parameters:parameters success:^(NSURLSessionTask *operation, id responseObject) {
//        NSLog(@"json-->%@",responseObject);
        NSLog(@"%@",[responseObject objectForKey:@"message"]);
        if ([[responseObject objectForKey:@"code"] integerValue] == 1) {
            NSMutableDictionary *mutabledict = [[NSMutableDictionary alloc] init];
            [mutabledict setObject:@"true" forKey:@"result"];
            NSArray *array = [responseObject objectForKey:@"datas"];
            for (int i = 0; i < [array count]; i ++) {
                NSDictionary *messdict = [array objectAtIndex:i];
                NSString *keyname = [NSString stringWithFormat:@"%d",i];
                [mutabledict setObject:messdict forKey:keyname];
            }
            _resultcityshopdict = mutabledict;
        }else
        {
            _resultcityshopdict = @{@"result": @"false", @"message": [responseObject objectForKey:@"message"]};
        }
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        _resultcityshopdict = @{@"result": @"false"};
    }];
}


- (void)AreaOfShoppostBound:(NSString *)bound
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *parameters = @{@"operate": @"getshops",
                                 @"city": bound};
    manager.requestSerializer.timeoutInterval = 20;
    [manager POST:@"http://192.168.1.146:8080/SmartPlatformWeb/servlet/ShopManage" parameters:parameters success:^(NSURLSessionTask *operation, id responseObject) {
        //        NSLog(@"json-->%@",responseObject);
        NSLog(@"%@",[responseObject objectForKey:@"message"]);
        if ([[responseObject objectForKey:@"code"] integerValue] == 1) {
            NSMutableDictionary *mutabledict = [[NSMutableDictionary alloc] init];
            [mutabledict setValue:@"true" forKeyPath:@"result"];
            [mutabledict addEntriesFromDictionary:[responseObject objectForKey:@"datas"]];
            _resultareashopdict = mutabledict;
        }else
        {
            _resultareashopdict = @{@"result": @"false", @"message": [responseObject objectForKey:@"message"]};
        }
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        _resultareashopdict = @{@"result": @"false"};
    }];
}



- (void)InfoOfShoppostShopID:(NSString *)shopid
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *parameters = @{@"operate": @"shopinfo",
                                 @"city": shopid};
    manager.requestSerializer.timeoutInterval = 20;
    [manager POST:@"http://192.168.1.146:8080/SmartPlatformWeb/servlet/ShopManage" parameters:parameters success:^(NSURLSessionTask *operation, id responseObject) {
        //        NSLog(@"json-->%@",responseObject);
        NSLog(@"%@",[responseObject objectForKey:@"message"]);
        if ([[responseObject objectForKey:@"code"] integerValue] == 1) {
            NSMutableDictionary *mutabledict = [[NSMutableDictionary alloc] init];
            [mutabledict setValue:@"true" forKeyPath:@"result"];
            [mutabledict addEntriesFromDictionary:[responseObject objectForKey:@"datas"]];
            _resultshopinfodict = mutabledict;
        }else
        {
            _resultshopinfodict = @{@"result": @"false", @"message": [responseObject objectForKey:@"message"]};
        }
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        _resultshopinfodict = @{@"result": @"false"};
    }];
}

#pragma mark

- (NSDictionary *)ResultCityShopDictionary
{
    return _resultcityshopdict;
}

- (NSDictionary *)ResultAreaShopDictionary
{
    return _resultareashopdict;
}

- (NSDictionary *)ResultShopInfoDictionary
{
    return _resultshopinfodict;
}

@end
