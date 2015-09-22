//
//  LineChartView.m
//  DrawDemo
//
//  Created by 东子 Adam on 12-5-31.
//  Copyright (c) 2012年 热频科技. All rights reserved.
//

#import "LineChartView.h"

@interface LineChartView()
{
    CALayer *linesLayer;
    UIView *popView;
    UILabel *disLabel;
}

@end

@implementation LineChartView

- (void)drawRect:(CGRect)rect
{
    NSLog(@"%f",self.frame.size.height);
    [self setClearsContextBeforeDrawing: YES];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextRef context1 = UIGraphicsGetCurrentContext();
    float x = self.bounds.size.width ;
    float y = self.bounds.size.height ;
    for (int i=0; i<8; i++) {
        CGPoint bPoint = CGPointMake(30, y);
        CGPoint ePoint = CGPointMake(x, y);
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 30, 25)];
        [label setCenter:CGPointMake(bPoint.x-15, bPoint.y-25)];
        [label setTextAlignment:NSTextAlignmentCenter];
        [label setBackgroundColor:[UIColor clearColor]];
        [label setTextColor:[UIColor blackColor]];
        [label setText:[NSString stringWithFormat:@"%d",i*20]];
        label.font = [UIFont systemFontOfSize:15];
        [self addSubview:label];
        CGContextMoveToPoint(context, bPoint.x, bPoint.y-25);
        CGContextAddLineToPoint(context, ePoint.x, ePoint.y-25);
        y -= self.frame.size.height / 8;
    }
    CGContextStrokePath(context);
    
    for (int i=0; i < 30; i++) {
        UILabel *label;
        if (i < 5)
        {
            label = [[UILabel alloc]initWithFrame:CGRectMake(i*6+30, self.bounds.size.height - 20, 9, 15)];
        }else{
            label = [[UILabel alloc]initWithFrame:CGRectMake(i*10+12, self.bounds.size.height - 20, 9, 15)];
        }
        [label setTextAlignment:NSTextAlignmentCenter];
        [label setBackgroundColor:[UIColor clearColor]];
        [label setTextColor:[UIColor blackColor]];
        label.numberOfLines = 1;
        label.adjustsFontSizeToFitWidth = YES;
        label.font = [UIFont systemFontOfSize:8];
        [label setText:[NSString stringWithFormat:@"%d",i*2]];
        [self addSubview:label];
    }
    
//    //画点线条------------------
//    CGColorRef pointColorRef = [UIColor colorWithRed:24.0f/255.0f green:116.0f/255.0f blue:205.0f/255.0f alpha:1.0].CGColor;
//    CGFloat pointLineWidth = 1.5f;
//    CGFloat pointMiterLimit = 5.0f;
//    CGContextSetLineWidth(context, pointLineWidth);//主线宽度
//    CGContextSetMiterLimit(context, pointMiterLimit);//投影角度  
//    CGContextSetShadowWithColor(context, CGSizeMake(3, 5), 8, pointColorRef);//设置双条线
//    CGContextSetLineJoin(context, kCGLineJoinRound);
//    CGContextSetLineCap(context, kCGLineCapRound );
//    CGContextSetBlendMode(context, kCGBlendModeNormal);
//    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);

	//绘图
    CGContextSetStrokeColorWithColor(context1, [UIColor blueColor].CGColor);
    
	for (int i = 1; i<[_array count]; i++)
	{
        CGPoint goPoint;
        if (i == 1) {
            CGContextMoveToPoint(context1, 30, self.bounds.size.height - 25 - [[_array objectAtIndex:0] floatValue]*self.frame.size.height/160);
            goPoint = CGPointMake(30, self.bounds.size.height - 25 - [[_array objectAtIndex:0] floatValue]*self.frame.size.height/160);
        }else if (i < 5)
        {
            goPoint = CGPointMake(i*7+30, self.bounds.size.height - 25 - [[_array objectAtIndex:i-1] floatValue]*self.frame.size.height/160);
            CGContextAddLineToPoint(context1, goPoint.x, goPoint.y);;
        }else{
            goPoint = CGPointMake(i*11+8, self.bounds.size.height - 25 - [[_array objectAtIndex:i-1] floatValue]*self.frame.size.height/160);
            CGContextAddLineToPoint(context1, goPoint.x, goPoint.y);;
        }
        
        //添加触摸点
        UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
        [bt setBackgroundColor:[UIColor redColor]];
        [bt setFrame:CGRectMake(0, 0, 6, 6)];
        [bt setCenter:goPoint];
        bt.tag = 100+i;
        [self addSubview:bt];
	}
	CGContextStrokePath(context1);
    
}


@end
