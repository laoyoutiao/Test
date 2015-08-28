//
//  HotWheelsOfFrittersView.m
//  Test
//
//  Created by 玉文辉 on 15/8/14.
//  Copyright (c) 2015年 玉文辉. All rights reserved.
//

#import "HotWheelsOfFrittersView.h"

@interface HotWheelsOfFrittersView()
@property NSInteger cyclenum;
@property CGContextRef contextline;
@property CGContextRef context;
@property NSTimer *time;
@end

@implementation HotWheelsOfFrittersView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setbackforHotWheels];
    }
    return self;
}

- (void)setbackforHotWheels
{
    self.layer.masksToBounds = YES;
    self.backgroundColor = [UIColor clearColor];
    [self.layer setCornerRadius:self .bounds.size.width / 2];
}

- (void)drawRect:(CGRect)rect
{
    [self setCircle];
    _cyclenum = 1;
    [self setLineAlpha];
    
//    CGPoint p1 = CGPointMake(0, 150);
//    CGPoint p2 = CGPointMake(189.5, 150);
//    CGPoint p3 = CGPointMake(189.5, 120);
//    CGPoint p4 = CGPointMake(277.75, 120);
//    CGPoint p5 = CGPointMake(277.75, 150);
//    CGPoint p6 = CGPointMake(375, 150);
//    UIBezierPath *path = [UIBezierPath bezierPath];
//    float radius = 5;
//    
//    [path moveToPoint:p1];
//    [path addLineToPoint:p2];
//    [path addArcWithCenter:CGPointMake(p3.x + radius, p3.y + radius) radius:radius startAngle:M_PI endAngle:3*M_PI_2 clockwise:YES];
//    [path addLineToPoint:CGPointMake(p4.x - radius, p4.y )];
//    [path addArcWithCenter:CGPointMake(p4.x - radius, p4.y + radius) radius:radius startAngle:3*M_PI_2 endAngle:2*M_PI clockwise:YES];
//    [path addLineToPoint:p5];
//    [path addLineToPoint:p6];
//    
//    [[UIColor blackColor] setStroke];
//    [path setLineWidth:1];
//    [path stroke];
//    [path closePath];
    
}

- (void)animationofwheel:(NSTimer *)time
{
    _cyclenum++;
    self.transform = CGAffineTransformMakeRotation(_cyclenum * M_PI / 6);
}

- (void)start
{
    if (!_interval) {
        _interval = 0.1;
    }
    _time = [NSTimer scheduledTimerWithTimeInterval:_interval target:self selector:@selector(animationofwheel:) userInfo:nil repeats:YES];
}

- (void)stop
{
    [_time invalidate];
}


- (void)setLineX:(CGFloat)x Y:(CGFloat)y ToX:(CGFloat)tx ToY:(CGFloat)ty Alpha:(CGFloat)alpha
{
    _contextline = UIGraphicsGetCurrentContext();
    CGContextBeginPath(_contextline);
    if (!_wheelcolorRed || !_wheelcolorBlue || !_wheelcolorGreen) {
        _wheelcolorGreen = 0;
        _wheelcolorRed = 0;
        _wheelcolorBlue = 0;
    }
    CGContextSetRGBStrokeColor(_contextline, _wheelcolorRed, _wheelcolorGreen, _wheelcolorBlue, alpha);
    CGContextSetLineWidth(_contextline, self.bounds.size.width / 13);
    CGContextMoveToPoint(_contextline, x, y);
    CGContextAddLineToPoint(_contextline, tx, ty);
    CGContextSetLineJoin(_contextline, kCGLineJoinRound);
    CGContextSetLineCap(_contextline, kCGLineCapRound );
    CGContextSetBlendMode(_contextline, kCGBlendModeNormal);
    CGContextStrokePath(_contextline);
}

- (void)setCircle
{
    _context = UIGraphicsGetCurrentContext();
    float radius = self.bounds.size.width / 2;
    CGRect Rect = self.bounds;
    CGContextBeginPath(_context);
    if (!_backAlpha) {
        _backAlpha = 0;
    }
    if (!_backcolorRed || !_backcolorBlue || !_backcolorGreen) {
        _backcolorGreen = 0;
        _backcolorRed = 0;
        _backcolorBlue = 0;
    }
    CGContextSetRGBFillColor(_context, _backcolorRed, _backcolorGreen, _backcolorBlue, _backAlpha);
    CGContextMoveToPoint(_context, CGRectGetMinX(Rect) + radius, CGRectGetMinY(Rect));
    CGContextAddArc(_context, CGRectGetMaxX(Rect) - radius, CGRectGetMaxX(Rect) + radius, radius, 33 * (float)M_PI_2, 0, 0);
    CGContextAddArc(_context,CGRectGetMaxX(Rect) - radius, CGRectGetMaxY(Rect), radius, 0, (float)M_PI / 2, 0);
    CGContextAddArc(_context,CGRectGetMinX(Rect) + radius, CGRectGetMaxY(Rect) - radius, radius, (float)M_PI / 2, (float)M_PI, 0);
    CGContextAddArc(_context,CGRectGetMinX(Rect) + radius, CGRectGetMinY(Rect) + radius, radius, (float)M_PI, 33 * (float)M_PI / 2, 0);
    

}

- (void)setLineAlpha
{
    CGFloat radius = self.bounds.size.width / 2;
    
    // 8轮
    
    //左上 右上 右下 左下
//    [self setLineX:radius*(1-(sin(M_PI_4)*3/4)) Y:radius*(1-(sin(M_PI_4)*3/4)) ToX:radius*(1-(sin(M_PI_4)/4)) ToY:radius*(1-(sin(M_PI_4)/4)) Alpha:0.3];
//    [self setLineX:radius*(1+(sin(M_PI_4)*3/4)) Y:radius*(1-(sin(M_PI_4)*3/4)) ToX:radius*(1+(sin(M_PI_4)/4)) ToY:radius*(1-(sin(M_PI_4)/4)) Alpha:0.3];
//    [self setLineX:radius*(1+(sin(M_PI_4)*3/4)) Y:radius*(1+(sin(M_PI_4)*3/4)) ToX:radius*(1+(sin(M_PI_4)/4)) ToY:radius*(1+(sin(M_PI_4)/4)) Alpha:0.3];
//    [self setLineX:radius*(1-(sin(M_PI_4)*3/4)) Y:radius*(1+(sin(M_PI_4)*3/4)) ToX:radius*(1-(sin(M_PI_4)/4)) ToY:radius*(1+(sin(M_PI_4)/4)) Alpha:0.7];
    
    //上右下左
//    [self setLineX:radius  Y:radius*3/4 ToX:radius  ToY:radius/4 Alpha:0.3];
//    [self setLineX:radius*7/4 Y:radius  ToX:radius*5/4 ToY:radius  Alpha:0.3];
//    [self setLineX:radius Y:radius*7/4  ToX:radius ToY:radius*5/4  Alpha:0.45];
//    [self setLineX:radius*3/4 Y:radius  ToX:radius/4 ToY:radius  Alpha:1];
    
    
    //12轮
    
    //左上 右上 右下 左下
    [self setLineX:radius*(1-(sin(M_PI / 6)*3/4)) Y:radius*(1-(cos(M_PI / 6)*3/4)) ToX:radius*(1-(sin(M_PI / 6)/2)) ToY:radius*(1-(cos(M_PI / 6)/2)) Alpha:0.3];
    [self setLineX:radius*(1-(sin(M_PI / 3)*3/4)) Y:radius*(1-(cos(M_PI / 3)*3/4)) ToX:radius*(1-(sin(M_PI / 3)/2)) ToY:radius*(1-(cos(M_PI / 3)/2)) Alpha:0.3];
    
    
    [self setLineX:radius*(1+(sin(M_PI / 6)*3/4)) Y:radius*(1-(cos(M_PI / 6)*3/4)) ToX:radius*(1+(sin(M_PI / 6)/2)) ToY:radius*(1-(cos(M_PI / 6)/2)) Alpha:0.3];
    [self setLineX:radius*(1+(sin(M_PI / 3)*3/4)) Y:radius*(1-(cos(M_PI / 3)*3/4)) ToX:radius*(1+(sin(M_PI / 3)/2)) ToY:radius*(1-(cos(M_PI / 3)/2)) Alpha:0.3];
    
    
    [self setLineX:radius*(1+(sin(M_PI / 6)*3/4)) Y:radius*(1+(cos(M_PI / 6)*3/4)) ToX:radius*(1+(sin(M_PI / 6)/2)) ToY:radius*(1+(cos(M_PI / 6)/2)) Alpha:0.3];
    [self setLineX:radius*(1+(sin(M_PI / 3)*3/4)) Y:radius*(1+(cos(M_PI / 3)*3/4)) ToX:radius*(1+(sin(M_PI / 3)/2)) ToY:radius*(1+(cos(M_PI / 3)/2)) Alpha:0.3];
    
    
    [self setLineX:radius*(1-(sin(M_PI / 6)*3/4)) Y:radius*(1+(cos(M_PI / 6)*3/4)) ToX:radius*(1-(sin(M_PI / 6)/2)) ToY:radius*(1+(cos(M_PI / 6)/2)) Alpha:0.7];
    [self setLineX:radius*(1-(sin(M_PI / 3)*3/4)) Y:radius*(1+(cos(M_PI / 3)*3/4)) ToX:radius*(1-(sin(M_PI / 3)/2)) ToY:radius*(1+(cos(M_PI / 3)/2)) Alpha:0.7];
    
    
    
    //上右下左
    [self setLineX:radius  Y:radius/4 ToX:radius  ToY:radius/2 Alpha:0.3];
    [self setLineX:radius*7/4 Y:radius  ToX:radius*6/4 ToY:radius  Alpha:0.3];
    [self setLineX:radius Y:radius*7/4  ToX:radius ToY:radius*6/4  Alpha:0.45];
    [self setLineX:radius/4 Y:radius  ToX:radius/2 ToY:radius  Alpha:1];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
