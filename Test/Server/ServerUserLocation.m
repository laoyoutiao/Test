//
//  ServerUserLocation.m
//  Test
//
//  Created by 玉文辉 on 15/9/12.
//  Copyright (c) 2015年 玉文辉. All rights reserved.
//

#import "ServerUserLocation.h"
#import "AFNetworking.h"

@implementation ServerUserLocation

+ (void)GetLocationpostName:(NSString *)username Block:(LocationBlock)block
{
    __block NSDictionary *resultlocation;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"operate": @"get",
                                 @"username": username};
    manager.requestSerializer.timeoutInterval = 20;
    [manager POST:@"http://192.168.1.146:8080/SmartPlatformWeb/servlet/UserLocation" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"json-->%@",responseObject);
        NSLog(@"%@",[responseObject objectForKey:@"message"]);
        if ([[responseObject objectForKey:@"code"] integerValue] == 1) {
            NSMutableDictionary *mutabledict = [[NSMutableDictionary alloc] init];
            [mutabledict setObject:@"true" forKey:@"result"];
            CLLocation *location = [responseObject objectForKey:@"datas"];
            NSString *longitude = [NSString stringWithFormat:@"%f",location.coordinate.longitude];
            NSString *latiude = [NSString stringWithFormat:@"%f",location.coordinate.latitude];
            [mutabledict setObject:longitude forKey:@"longitude"];
            [mutabledict setObject:latiude forKey:@"latiude"];
            resultlocation = mutabledict;
        }else
        {
            resultlocation = @{@"result": @"false", @"message": [responseObject objectForKey:@"message"],@"latiude":@"2"};
        }
        NSLog(@"%@",resultlocation);
        block(resultlocation);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        resultlocation = @{@"result": @"false", @"message": @"未知错误"};
        block(resultlocation);
    }];

}


@end
