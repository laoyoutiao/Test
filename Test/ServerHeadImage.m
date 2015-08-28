//
//  ServerHeadImage.m
//  Test
//
//  Created by 玉文辉 on 15/8/12.
//  Copyright (c) 2015年 玉文辉. All rights reserved.
//

#import "ServerHeadImage.h"
#import "AFNetworking.h"

@interface ServerHeadImage ()

@property (strong, nonatomic) __block NSDictionary *resultuserdict;
@property (strong, nonatomic) __block NSDictionary *resultsocialdict;

@end

@implementation ServerHeadImage


+(ServerHeadImage *)sharedInstance
{
    static ServerHeadImage *sharedManager;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[ServerHeadImage alloc] init];
    });
    
    return sharedManager;
}


#pragma mark

- (void)HeadImagepostUsername:(NSString *)username
                     Image:(UIImage *)image
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSData *data = UIImageJPEGRepresentation(image, 1.0f);
    NSString *ImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    NSDictionary *parameters = @{@"operate": @"upload",
                                 @"username": username,
                                 @"imgStr": ImageStr};
    [manager POST:@"http://192.168.1.146:8080/SmartPlatformWeb/servlet/HeadImage" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"json-->%@",responseObject);
        NSLog(@"%@",[responseObject objectForKey:@"message"]);
        if ([[responseObject objectForKey:@"status"] integerValue] == 1) {
            _resultuserdict = @{@"result": @"true",
                      @"message": [responseObject objectForKey:@"message"]};
        }else
        {
            _resultuserdict = @{@"result": @"false",
                      @"message": [responseObject objectForKey:@"message"]};
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        _resultuserdict = @{@"result": @"false",
                  @"message": @"网络或未知错误"};
    }];
}



- (void)SocialWorkerpostUsername:(NSString *)username
                           image:(UIImage *)image
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSData *data = UIImageJPEGRepresentation(image, 1.0f);
    NSString *ImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    NSDictionary *parameters = @{@"operate": @"upimg",
                                 @"username": username,
                                 @"imgStr": ImageStr};
    [manager POST:@"http://192.168.1.146:8080/SmartPlatformWeb/servlet/HeadImage" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"json-->%@",responseObject);
        NSLog(@"%@",[responseObject objectForKey:@"message"]);
        if ([[responseObject objectForKey:@"status"] integerValue] == 1) {
            _resultsocialdict = @{@"result": @"true",
                      @"message": [responseObject objectForKey:@"message"]};
        }else
        {
            _resultsocialdict = @{@"result": @"false",
                      @"message": [responseObject objectForKey:@"message"]};
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        _resultsocialdict = @{@"result": @"false",
                  @"message": @"网络或未知错误"};
    }];
}

#pragma mark

- (NSDictionary *)ResultUserDictionary
{
    return _resultuserdict;
}

- (NSDictionary *)ResultSocialDictionary
{
    return _resultsocialdict;
}


@end
