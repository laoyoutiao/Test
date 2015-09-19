//
//  LoginOrRegister.h
//  Test
//
//  Created by 玉文辉 on 15/8/10.
//  Copyright (c) 2015年 玉文辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServerLoginOrRegister : NSObject


+(ServerLoginOrRegister *)sharedInstance;

//登录
- (void)LoginpostUsername:(NSString *)username
                 Password:(NSString *)password;

- (NSDictionary *)ResultLoginDictionary;

//注册
- (void)RegistpostUsername:(NSString *)username
                  Password:(NSString *)password
                  Usertype:(NSString *)usertype
                       sex:(NSString *)sex;

- (NSDictionary *)ResultRegistDictionary;

//推送绑定
- (void)BindcidpostUsername:(NSString *)username
                        Cid:(NSInteger)cid;

- (NSDictionary *)ResultBindDictionary;


//注销登录
- (void)ExitpostUsername:(NSString *)username
                     Cid:(NSInteger)cid;

- (NSDictionary *)ResultExitDictionary;

@end
