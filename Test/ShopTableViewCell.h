//
//  ShopTableViewCell.h
//  Test
//
//  Created by 玉文辉 on 15/8/28.
//  Copyright (c) 2015年 玉文辉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopInfo.h"

@interface ShopTableViewCell : UITableViewCell

@property (strong, nonatomic) ShopInfo *info;

- (CGFloat)HeighTofCell;

- (void)InfoOfCell:(ShopInfo *)info;

@end
