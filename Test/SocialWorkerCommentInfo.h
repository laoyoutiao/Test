//
//  SocialWorkerCommentInfo.h
//  Test
//
//  Created by 玉文辉 on 15/8/27.
//  Copyright (c) 2015年 玉文辉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SocialWorkerCommentInfo : NSObject

@property (strong, nonatomic) NSString *discuss_id;   //评论id号
@property (strong, nonatomic) NSString *username;	 //用户账号
@property (strong, nonatomic) NSString *discussor;	 //社工账号
@property (strong, nonatomic) NSString *descript;	 //评论内容
@property (assign, nonatomic) CGFloat score;		 //评分(0-5)
@property (strong, nonatomic) NSString *discusstime;	 //评论时间
@property (assign, nonatomic) NSInteger pnum;

- (id)initWithDictionary:(NSDictionary *)dict;

+ (NSArray *)instanceArrayDictFromDict:(NSDictionary *)dict;

@end
