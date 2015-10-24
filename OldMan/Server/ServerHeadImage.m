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

@property (strong, nonatomic) __block NSDictionary *resultdict;

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

- (void)ImagepostUsername:(NSString *)username
                        Image:(UIImage *)image ImageKind:(ImageKind)imagekind
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSData *data = UIImageJPEGRepresentation(image, 1.0f);
    NSString *ImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    NSString *operate;
    switch (imagekind) {
        case 0:
            operate = @"upload";
            break;
            
        case 1:
            operate = @"upimg";
            break;
            
        default:
            break;
    }
    NSDictionary *parameters = @{@"operate": operate,
                                 @"username": username,
                                 @"imgStr": ImageStr};
    manager.requestSerializer.timeoutInterval = 20;

    [manager POST:@"http://192.168.1.146:8080/SmartPlatformWeb/servlet/HeadImage" parameters:parameters success:^(NSURLSessionTask *operation, id responseObject) {
        NSLog(@"json-->%@",responseObject);
        NSLog(@"%@",[responseObject objectForKey:@"message"]);
        if ([[responseObject objectForKey:@"status"] integerValue] == 1) {
            _resultdict = @{@"result": @"true",
                      @"message": [responseObject objectForKey:@"message"]};
        }else
        {
            _resultdict = @{@"result": @"false",
                      @"message": [responseObject objectForKey:@"message"]};
        }
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        _resultdict = @{@"result": @"false",
                  @"message": @"网络或未知错误"};
    }];
}

#pragma mark

- (NSDictionary *)ResultDictionary
{
    return _resultdict;
}


@end
