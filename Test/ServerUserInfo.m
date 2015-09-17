//
//  ServerUserInfo.m
//  Test
//
//  Created by 玉文辉 on 15/8/12.
//  Copyright (c) 2015年 玉文辉. All rights reserved.
//

#import "ServerUserInfo.h"
#import "AFNetworking.h"

@interface ServerUserInfo ()

@property (strong, nonatomic) __block  NSDictionary *resultchangeinfodict;
@property (strong, nonatomic) __block  NSDictionary *resultchangephonedict;

@end

@implementation ServerUserInfo

+(ServerUserInfo *)sharedInstance
{
    static ServerUserInfo *sharedManager;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[ServerUserInfo alloc] init];
    });
    
    return sharedManager;
}

#pragma mark

- (void)ChangeUserInfopostUsername:(NSString *)username
                UserInfoDictionary:(NSDictionary *)userinfodictionary
               UserInfoKindNsarray:(NSArray *)userinfokindarray
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer.timeoutInterval = 20;
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:@"update" forKey:@"operate"];
    [parameters setObject:username forKey:@"username"];

    for (int i = 0; i < [userinfodictionary count]; i ++) {
        NSString *str = [userinfodictionary objectForKey:[userinfokindarray objectAtIndex:i]];
        [parameters setObject:str forKey:[userinfokindarray objectAtIndex:i]];
    }
    
    [manager POST:@"http://192.168.1.146:8080/SmartPlatformWeb/servlet/UserInfo" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"json-->%@",responseObject);
        NSLog(@"%@",[responseObject objectForKey:@"message"]);
        if ([[responseObject objectForKey:@"status"] integerValue] == 1) {
            _resultchangeinfodict = @{@"result": @"true",
                      @"message": [responseObject objectForKey:@"message"]};
        }else
        {
            _resultchangeinfodict = @{@"result": @"false",
                      @"message": [responseObject objectForKey:@"message"]};
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        _resultchangeinfodict = @{@"result": @"false",
                  @"message": @"网络或未知错误"};
    }];
}


- (void)ChangePhonepostUsername:(NSString *)username
                      Cellphone:(NSString *)cellphone
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer.timeoutInterval = 20;
    NSDictionary *parameters = @{@"operate": @"update",
                                 @"username": username,
                                 @"cellphone": cellphone};
    [manager POST:@"http://192.168.1.146:8080/SmartPlatformWeb/servlet/UserInfo" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"json-->%@",responseObject);
        NSLog(@"%@",[responseObject objectForKey:@"message"]);
        if ([[responseObject objectForKey:@"status"] integerValue] == 1) {
            _resultchangephonedict = @{@"result": @"true",
                      @"message": [responseObject objectForKey:@"message"]};
        }else
        {
            _resultchangephonedict = @{@"result": @"false",
                      @"message": [responseObject objectForKey:@"message"]};
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        _resultchangephonedict = @{@"result": @"false",
                  @"message": @"网络或未知错误"};
    }];
}

#pragma mark

- (NSDictionary *)ResultChangeInfoDictionary
{
    return _resultchangeinfodict;
}

- (NSDictionary *)ResultChangePhoneDictionary
{
    return _resultchangephonedict;
}


@end
