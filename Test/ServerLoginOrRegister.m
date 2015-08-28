//
//  LoginOrRegister.m
//  Test
//
//  Created by 玉文辉 on 15/8/10.
//  Copyright (c) 2015年 玉文辉. All rights reserved.
//

#import "ServerLoginOrRegister.h"
#import "AFNetworking.h"
#import <objc/runtime.h>

@interface ServerLoginOrRegister()

@property (strong, nonatomic) __block NSDictionary *resultlogindict;
@property (strong, nonatomic) __block NSDictionary *resultregistdict;
@property (strong, nonatomic) __block NSDictionary *resultbinddict;
@property (strong, nonatomic) __block NSDictionary *resultexitdict;


@end

@implementation ServerLoginOrRegister

+(ServerLoginOrRegister *)sharedInstance
{
    static ServerLoginOrRegister *sharedManager;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[ServerLoginOrRegister alloc] init];
    });
    
    return sharedManager;
}


#pragma mark

- (void)LoginpostUsername:(NSString *)username
                 Password:(NSString *)password
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"operate": @"login",
                                 @"username": username,
                                 @"password": password};
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"]; //服务器接受类型
    [manager POST:@"http://192.168.1.146:8080/SmartPlatformWeb/servlet/LoginAndRegist" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"json-->%@",responseObject);
        NSLog(@"%@",[responseObject objectForKey:@"message"]);
        if ([[responseObject objectForKey:@"status"] integerValue] == 1) {
            _resultlogindict = @{@"result": @"true",
                      @"message": [responseObject objectForKey:@"message"]};
            [[NSUserDefaults standardUserDefaults] setObject:[responseObject objectForKey:@"datas"] forKey:@"UserInfo"];
        }else
        {
            _resultlogindict = @{@"result": @"false",
                      @"message": [responseObject objectForKey:@"message"]};
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            _resultlogindict = @{@"result": @"false",
                      @"message": @"网络或未知错误"};
    }];
}



- (void)RegistpostUsername:(NSString *)username
                  Password:(NSString *)password
                  Usertype:(NSString *)usertype
                       sex:(NSString *)sex
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"operate": @"regist",
                                 @"username": username,
                                 @"password": password,
                                 @"usertype": usertype,
                                 @"sex":sex};
    [manager POST:@"http://192.168.1.146:8080/SmartPlatformWeb/servlet/LoginAndRegist" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"json-->%@",responseObject);
        if ([[responseObject objectForKey:@"status"] integerValue] == 1) {
            _resultregistdict = @{@"result": @"true",
                      @"message": [responseObject objectForKey:@"message"]};
        }else
        {
            _resultregistdict = @{@"result": @"false",
                      @"message": [responseObject objectForKey:@"message"]};
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            _resultregistdict = @{@"result": @"false",
                      @"message": @"网络或未知错误"};
    }];
}



- (void)BindcidpostUsername:(NSString *)username
                        Cid:(NSInteger)cid
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *cidstr = [NSString stringWithFormat:@"%ld",cid];
    NSDictionary *parameters = @{@"operate": @"bindcid",
                                 @"username": username,
                                 @"cid": cidstr};
    [manager POST:@"http://192.168.1.146:8080/SmartPlatformWeb/servlet/LoginAndRegist" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"json-->%@",responseObject);
        if ([[responseObject objectForKey:@"status"] integerValue] == 1) {
            _resultbinddict = @{@"result": @"true",
                      @"message": [responseObject objectForKey:@"message"]};
        }else
        {
            _resultbinddict = @{@"result": @"false",
                      @"message": [responseObject objectForKey:@"message"]};
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        _resultbinddict = @{@"result": @"false",
                  @"message": @"网络或未知错误"};
    }];
}



- (void)ExitpostUsername:(NSString *)username
                     Cid:(NSInteger)cid
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *cidstr = [NSString stringWithFormat:@"%ld",cid];
    NSDictionary *parameters = @{@"operate": @"logout",
                                 @"username": username,
                                 @"cid": cidstr};
    [manager POST:@"http://192.168.1.146:8080/SmartPlatformWeb/servlet/LoginAndRegist" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"json-->%@",responseObject);
        if ([[responseObject objectForKey:@"status"] integerValue] == 1) {
            _resultexitdict = @{@"result": @"true",
                      @"message": [responseObject objectForKey:@"message"]};
        }else
        {
            _resultexitdict = @{@"result": @"false",
                      @"message": [responseObject objectForKey:@"message"]};
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        _resultexitdict = @{@"result": @"false",
                  @"message": @"网络或未知错误"};
    }];
}

#pragma mark

- (NSDictionary *)ResultLoginDictionary
{
    return _resultlogindict;
}

- (NSDictionary *)ResultRegistDictionary
{
    return _resultregistdict;
}

- (NSDictionary *)ResultBindDictionary
{
    return _resultbinddict;
}

- (NSDictionary *)ResultExitDictionary
{
    return _resultexitdict;
}


@end
