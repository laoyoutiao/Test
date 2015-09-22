//
//  ServerUserLocation.h
//  Test
//
//  Created by 玉文辉 on 15/9/12.
//  Copyright (c) 2015年 玉文辉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

typedef void(^LocationBlock)(NSDictionary *locationblock);
typedef void(^StateBlock)(BOOL stateblock);

@interface ServerUserLocation : NSObject

//获取用户位置
+ (void)GetLocationpostName:(NSString *)username Block:(LocationBlock)block;

//获取用户监控状态
+ (void)GetUserStatepostName:(NSString *)username Block:(StateBlock)block;

//改变用户监控状态
+ (void)ChangeUserStateSwitchpostName:(NSString *)username ToState:(BOOL)state Block:(StateBlock)block;

@end
