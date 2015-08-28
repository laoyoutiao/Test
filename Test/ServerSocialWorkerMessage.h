//
//  ServerSocialWorkerMessage.h
//  Test
//
//  Created by 玉文辉 on 15/8/24.
//  Copyright (c) 2015年 玉文辉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^CommentBlock)(NSDictionary *commentdict);

@interface ServerSocialWorkerMessage : NSObject


+(ServerSocialWorkerMessage *)sharedInstance;

//社工资料
- (void)GetWorkerpostCity:(NSString *)city;

- (void)GetWorkerpostCity:(NSString *)city Area:(NSString *)area;

- (NSDictionary *)ResultWorkerDictionary;


//社工评论
+ (void)GetWorkerCommentpostName:(NSString *)username Row:(NSInteger)rowcount Block:(CommentBlock)block;


//获取预约信息

- (void)GetBookMessageUsername:(NSString *)username
                      Usertype:(NSString *)usertype;

- (NSDictionary *)ResultBookMessageDictionary;

@end
