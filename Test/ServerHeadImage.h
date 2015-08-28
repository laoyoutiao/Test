//
//  ServerHeadImage.h
//  Test
//
//  Created by 玉文辉 on 15/8/12.
//  Copyright (c) 2015年 玉文辉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ServerHeadImage : NSObject

+(ServerHeadImage *)sharedInstance;

//上传头像
- (void)HeadImagepostUsername:(NSString *)username
                   Image:(UIImage *)image;

- (NSDictionary *)ResultUserDictionary;

//社工图片
- (void)SocialWorkerpostUsername:(NSString *)username
                           image:(UIImage *)image;

- (NSDictionary *)ResultSocialDictionary;

@end
