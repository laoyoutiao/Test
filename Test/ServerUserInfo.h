//
//  ServerUserInfo.h
//  Test
//
//  Created by 玉文辉 on 15/8/12.
//  Copyright (c) 2015年 玉文辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServerUserInfo : NSObject


+(ServerUserInfo *)sharedInstance;

//更改个人信息
- (void)ChangeUserInfopostUsername:(NSString *)username
                UserInfoDictionary:(NSDictionary *)userinfodictionary
               UserInfoKindNsarray:(NSArray *)userinfokindarray;

- (NSDictionary *)ResultChangeInfoDictionary;

//更改电话号码
- (void)ChangePhonepostUsername:(NSString *)username
                      Cellphone:(NSString *)cellphone;

- (NSDictionary *)ResultChangePhoneDictionary;




@end
