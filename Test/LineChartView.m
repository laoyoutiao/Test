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
        
        _hInterval = 10;
        _vInterval = 10;
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

    for (int i=0; i<_vDesc.count; i++) {
        CGPoint bPoint = CGPointMake(30, y);
        CGPoint ePoint = CGPointMake(x, y);
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
        [label setCenter:CGPointMake(bPoint.x-15, bPoint.y-30)];
        [label setTextAlignment:NSTextAlignmentCenter];
        [label setBackgroundColor:[UIColor clearColor]];
        [label setTextColor:[UIColor whiteColor]];
        [label setText:[_vDesc objectAtIndex:i]];
        [self addSubview:label];
        CGContextMoveToPoint(context, bPoint.x, bPoint.y-30);
        CGContextAddLineToPoint(context, ePoint.x, ePoint.y-30);
        y -= 50;
    }
    
    for (int i=0; i < _hDesc.count-1; i++) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(i*_vInterval+30, self.bounds.size.height - 20, 15, 15)];
        [label setTextAlignment:NSTextAlignmentCenter];
        [label setBackgroundColor:[UIColor clearColor]];
        [label setTextColor:[UIColor whiteColor]];
        label.numberOfLines = 1;
        label.adjustsFontSizeToFitWidth = YES;
        [label setText:[_hDesc objectAtIndex:i]];
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
	CGPoint p1 = [[_array objectAtIndex:0] CGPointValue];
	int i = 1;
	CGContextMoveToPoint(context, p1.x+30, self.bounds.size.height - p1.y);
	for (; i<[_array count]; i++)
	{
		p1 = [[_array objectAtIndex:i] CGPointValue];
        CGPoint goPoint = CGPointMake(30 + p1.x / 5, self.bounds.size.height - 30 - p1.y*_vInterval/4);
		CGContextAddLineToPoint(context, goPoint.x, goPoint.y);;
        
        //添加触摸点
        UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
        [bt setBackgroundColor:[UIColor redColor]];
        [bt setFrame:CGRectMake(0, 0, 10, 10)];
        [bt setCenter:goPoint];
        [bt addTarget:self 
               action:@selector(btAction:) 
     forControlEvents:UIControlEventTouchUpInside];
        bt.tag = 100+i;
        [self addSubview:bt];
	}
	CGContextStrokePath(context);
    
}

- (void)btAction:(id)sender{
    UIButton *bt = (UIButton*)sender;
    CGPoint point = [[_array objectAtIndex:(bt.tag - 100)] CGPointValue];
    NSString *text = [NSString stringWithFormat:@"%.1f",point.y];
    [disLabel setText:text];
    popView.center = CGPointMake(bt.center.x, bt.center.y - popView.frame.size.height/2);
    [popView setAlpha:1.0f];
}

@end