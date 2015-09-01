//
//  ServerHealthInfo.h
//  Test
//
//  Created by 玉文辉 on 15/9/1.
//  Copyright (c) 2015年 玉文辉. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef  void (^HealthBlock)(NSDictionary *healthdict);

@interface ServerHealthInfo : UITableViewCell

+ (void)GetHealthInfopostName:(NSString *)username time:(NSString *)time Block:(HealthBlock)block;

@end
