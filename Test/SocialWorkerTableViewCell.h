//
//  SocialWorkerTableViewCell.h
//  Test
//
//  Created by 玉文辉 on 15/8/4.
//  Copyright (c) 2015年 玉文辉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SocialWorkerInfo.h"

@interface SocialWorkerTableViewCell : UITableViewCell
- (CGFloat)HeighTofCell;
- (void)InfoOfCell:(SocialWorkerInfo *)info;
@end
