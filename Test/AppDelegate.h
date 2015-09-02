//
//  AppDelegate.h
//  Test
//
//  Created by 玉文辉 on 15/7/30.
//  Copyright (c) 2015年 玉文辉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI/BMapKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate,BMKGeneralDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) BMKMapManager *mapmanager;

@end

