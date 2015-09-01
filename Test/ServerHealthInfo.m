//
//  ServerHealthInfo.m
//  Test
//
//  Created by 玉文辉 on 15/9/1.
//  Copyright (c) 2015年 玉文辉. All rights reserved.
//

#import "ServerHealthInfo.h"
#import "AFNetworking.h"

@implementation ServerHealthInfo

+ (void)GetHealthInfopostName:(NSString *)username time:(NSString *)time Block:(HealthBlock)block
{
    __block NSDictionary *resultworkercommentdict;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"operate": @"look",
                                 @"username": username,
                                 @"time": time};
    [manager POST:@"http://192.168.1.146:8080/SmartPlatformWeb/servlet/HealthInfo" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//              NSLog(@"json-->%@",responseObject);
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
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        resultworkercommentdict = @{@"result": @"false"};
        block(resultworkercommentdict);
    }];
}

@end
