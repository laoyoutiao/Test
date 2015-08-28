//
//  HotWheelsOfFrittersView.h
//  Test
//
//  Created by 玉文辉 on 15/8/14.
//  Copyright (c) 2015年 玉文辉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HotWheelsOfFrittersView : UIView
@property CGFloat interval;
@property NSInteger backcolorRed;
@property NSInteger backcolorGreen;
@property NSInteger backcolorBlue;
@property CGFloat backAlpha;
@property NSInteger wheelcolorRed;
@property NSInteger wheelcolorGreen;
@property NSInteger wheelcolorBlue;
- (void)start;
- (void)stop;
@end
