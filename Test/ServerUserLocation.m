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
    __block CLLocationCoordinate2D location;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"operate": @"get",
                                 @"username": username};
    
    [manager POST:@"http://192.168.1.146:8080/SmartPlatformWeb/servlet/UserLocation" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"json-->%@",responseObject);
//        NSLog(@"%@",[responseObject objectForKey:@"message"]);
//        if ([[responseObject objectForKey:@"code"] integerValue] == 1) {
//            NSMutableDictionary *mutabledict = [[NSMutableDictionary alloc] init];
//            [mutabledict setObject:@"true" forKey:@"result"];
//            NSArray *array = [responseObject objectForKey:@"datas"];
//        }else
//        {
            location = (CLLocationCoordinate2D){0,0};
//        }
        block(location);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        location = (CLLocationCoordinate2D){-1,-1};
        block(location);
    }];

}

@end
