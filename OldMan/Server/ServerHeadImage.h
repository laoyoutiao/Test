//
//  ServerHeadImage.h
//  Test
//
//  Created by 玉文辉 on 15/8/12.
//  Copyright (c) 2015年 玉文辉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ImageKind){
    ImageKindHeadImage = 0,
    ImageKindWorkerImage = 1
};

@interface ServerHeadImage : NSObject

+(ServerHeadImage *)sharedInstance;

//上传图片
- (void)ImagepostUsername:(NSString *)username
                   Image:(UIImage *)image ImageKind:(ImageKind)imagekind;

- (NSDictionary *)ResultDictionary;


@end
