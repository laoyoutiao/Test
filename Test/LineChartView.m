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

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        linesLayer = [[CALayer alloc] init];
        linesLayer.masksToBounds = YES;
        linesLayer.contentsGravity = kCAGravityLeft;
        linesLayer.backgroundColor = [[UIColor whiteColor] CGColor];
        [self.layer addSublayer:linesLayer];
        
        //PopView
        popView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 60, 30)];
        [popView setBackgroundColor:[UIColor clearColor]];
        [popView setAlpha:0.0f];
        disLabel = [[UILabel alloc]initWithFrame:popView.frame];
        [disLabel setTextAlignment:NSTextAlignmentCenter];
        disLabel.textColor = [UIColor greenColor];
        [popView addSubview:disLabel];
        [self addSubview:popView];
    }
    return self;
}

#define ZeroPoint CGPointMake(30,460)

- (void)drawRect:(CGRect)rect
{
    [self setClearsContextBeforeDrawing: YES];
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //画背景线条------------------
    CGColorRef backColorRef = [UIColor blackColor].CGColor;
    CGFloat backLineWidth = 2.f;
    CGFloat backMiterLimit = 0.f;
    CGContextSetLineWidth(context, backLineWidth);//主线宽度
    CGContextSetMiterLimit(context, backMiterLimit);//投影角度  
    CGContextSetShadowWithColor(context, CGSizeMake(3, 5), 8, backColorRef);//设置双条线
    CGContextSetLineJoin(context, kCGLineJoinRound);
    CGContextSetLineCap(context, kCGLineCapRound );
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    
    int x = self.bounds.size.width ;
    int y = self.bounds.size.height ;

    for (int i=0; i<8; i++) {
        CGPoint bPoint = CGPointMake(30, y);
        CGPoint ePoint = CGPointMake(x, y);
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
        [label setCenter:CGPointMake(bPoint.x-15, bPoint.y-30)];
        [label setTextAlignment:NSTextAlignmentCenter];
        [label setBackgroundColor:[UIColor clearColor]];
        [label setTextColor:[UIColor whiteColor]];
        [label setText:[NSString stringWithFormat:@"%d",i*20]];
        label.font = [UIFont systemFontOfSize:15];
        [self addSubview:label];
        CGContextMoveToPoint(context, bPoint.x, bPoint.y-30);
        CGContextAddLineToPoint(context, ePoint.x, ePoint.y-30);
        y -= 50;
    }
    
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
        [label setTextColor:[UIColor whiteColor]];
        label.numberOfLines = 1;
        label.adjustsFontSizeToFitWidth = YES;
        label.font = [UIFont systemFontOfSize:8];
        [label setText:[NSString stringWithFormat:@"%d",i*2]];
        [self addSubview:label];
    }
    
//    //画点线条------------------
    CGColorRef pointColorRef = [UIColor colorWithRed:24.0f/255.0f green:116.0f/255.0f blue:205.0f/255.0f alpha:1.0].CGColor;
    CGFloat pointLineWidth = 1.5f;
    CGFloat pointMiterLimit = 5.0f;
    CGContextSetLineWidth(context, pointLineWidth);//主线宽度
    CGContextSetMiterLimit(context, pointMiterLimit);//投影角度  
    CGContextSetShadowWithColor(context, CGSizeMake(3, 5), 8, pointColorRef);//设置双条线
    CGContextSetLineJoin(context, kCGLineJoinRound);
    CGContextSetLineCap(context, kCGLineCapRound );
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);

	//绘图
	int i = 1;
	CGContextMoveToPoint(context, 30, self.bounds.size.height - 30 - [[_array objectAtIndex:0] floatValue]*10/4);
    UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
    [bt setBackgroundColor:[UIColor redColor]];
    [bt setFrame:CGRectMake(0, 0, 5, 5)];
    [bt setCenter:CGPointMake(30, self.bounds.size.height - 30 - [[_array objectAtIndex:0] floatValue]*10/4)];
    [self addSubview:bt];
    
	for (; i<[_array count]; i++)
	{
        CGPoint goPoint;
        if (i < 5)
        {
            goPoint = CGPointMake(i*7+30, self.bounds.size.height - 30 - [[_array objectAtIndex:i] floatValue]*10/4);
        }else{
            goPoint = CGPointMake(i*11+8, self.bounds.size.height - 30 - [[_array objectAtIndex:i] floatValue]*10/4);
        }
		CGContextAddLineToPoint(context, goPoint.x, goPoint.y);;
        
        //添加触摸点
        UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
        [bt setBackgroundColor:[UIColor redColor]];
        [bt setFrame:CGRectMake(0, 0, 5, 5)];
        [bt setCenter:goPoint];
        bt.tag = 100+i;
        [self addSubview:bt];
	}
	CGContextStrokePath(context);
    
}


@end
