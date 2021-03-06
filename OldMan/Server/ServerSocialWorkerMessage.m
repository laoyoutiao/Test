//
//  ServerSocialWorkerMessage.m
//  Test
//
//  Created by 玉文辉 on 15/8/24.
//  Copyright (c) 2015年 玉文辉. All rights reserved.
//

#import "ServerSocialWorkerMessage.h"
#import "AFNetworking.h"

@interface ServerSocialWorkerMessage ()
@property (strong, nonatomic) __block NSDictionary *resultworkerdict;
@property (strong, nonatomic) __block NSDictionary *resultbookdict;
@end

@implementation ServerSocialWorkerMessage

+(ServerSocialWorkerMessage *)sharedInstance
{
    static ServerSocialWorkerMessage *sharedManager;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[ServerSocialWorkerMessage alloc] init];
    });
    
    return sharedManager;
}

#pragma mark

- (void)GetWorkerpostCity:(NSString *)city Area:(NSString *)area SelectKind:(SelectKind)selectkind
{
    switch (selectkind) {
        case 0:
            [self GetWorkerpostCity:city];
            break;
            
        case 1:
            [self GetWorkerpostCity:city Area:area];
            break;
            
        default:
            break;
    }
}

- (void)GetWorkerpostCity:(NSString *)city
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *parameters = @{@"operate": @"look",
                                 @"city": city};
    manager.requestSerializer.timeoutInterval = 20;
    [manager POST:@"http://192.168.1.146:8080/SmartPlatformWeb/servlet/WorkerManage" parameters:parameters success:^(NSURLSessionTask *operation, id responseObject) {
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
            _resultworkerdict = mutabledict;
        }else
        {
            _resultworkerdict = @{@"result": @"false", @"message": [responseObject objectForKey:@"message"]};
        }
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        _resultworkerdict = @{@"result": @"false"};
    }];
}

- (void)GetWorkerpostCity:(NSString *)city Area:(NSString *)area
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *parameters = @{@"operate": @"look",
                                 @"city": city,
                                 @"area": area};
    manager.requestSerializer.timeoutInterval = 20;
    [manager POST:@"http://192.168.1.146:8080/SmartPlatformWeb/servlet/WorkerManage" parameters:parameters success:^(NSURLSessionTask *operation, id responseObject) {
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
            _resultworkerdict = mutabledict;
        }else
        {
            _resultworkerdict = @{@"result": @"false", @"message": [responseObject objectForKey:@"message"]};
        }
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        _resultworkerdict = @{@"result": @"false"};
    }];
}


+ (void)GetWorkerCommentpostName:(NSString *)username Row:(NSInteger)rowcount Block:(CommentBlock)block
{
    __block NSDictionary *resultworkercommentdict;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *parameters = @{@"operate": @"getcomment",
                                 @"username": username,
                                 @"rowcount": [NSString stringWithFormat:@"%ld",rowcount]};
    manager.requestSerializer.timeoutInterval = 20;
    [manager POST:@"http://192.168.1.146:8080/SmartPlatformWeb/servlet/WorkerManage" parameters:parameters success:^(NSURLSessionTask *operation, id responseObject) {
//      NSLog(@"json-->%@",responseObject);
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
            resultworkercommentdict = mutabledict;
        }else
        {
            resultworkercommentdict = @{@"result": @"false", @"message": [responseObject objectForKey:@"message"]};
        }
        block(resultworkercommentdict);
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        resultworkercommentdict = @{@"result": @"false"};
        block(resultworkercommentdict);
    }];
}

- (void)GetBookMessageUsername:(NSString *)username
                      Usertype:(NSString *)usertype
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *parameters = @{@"operate": @"getcomment",
                                 @"username": username,
                                 @"usertype": usertype};
    manager.requestSerializer.timeoutInterval = 20;
    [manager POST:@"http://192.168.1.146:8080/SmartPlatformWeb/servlet/WorkerManage" parameters:parameters success:^(NSURLSessionTask *operation, id responseObject) {
        //      NSLog(@"json-->%@",responseObject);
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
            _resultbookdict = mutabledict;
        }else
        {
            _resultbookdict = @{@"result": @"false", @"message": [responseObject objectForKey:@"message"]};
        }
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        _resultbookdict = @{@"result": @"false"};
    }];
}

#pragma mark

- (NSDictionary *)ResultWorkerDictionary
{
    return _resultworkerdict;
}

- (NSDictionary *)ResultBookMessageDictionary
{
    return  _resultbookdict;
}

@end
