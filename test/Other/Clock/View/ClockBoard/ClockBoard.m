//
//  ClockBoard.m
//  test
//
//  Created by CBCT_MBP on 2020/12/8.
//  Copyright © 2020 zgcx. All rights reserved.
//

#import "ClockBoard.h"

#import "ClockBoard.h"
#import "ClockTime.h"
#import "ClockPointer.h"

@interface ClockBoard ()

// hour
@property(nonatomic,strong) ClockPointer *hourPtr;
// min
@property(nonatomic,strong) ClockPointer *minPtr;
// sec
@property(nonatomic,strong) ClockPointer *secPtr;
// centeryaler
@property(nonatomic,strong) CAShapeLayer *centerLayer;
// timer
@property(nonatomic,strong) NSTimer      *timer;
// second
@property(nonatomic,assign) CGFloat      second;
// minute
@property(nonatomic,assign) CGFloat      minute;
// hour
@property(nonatomic,assign) CGFloat      hour;
// clockScale
@property(nonatomic,assign) BOOL         clockScale;
// 日期
@property(nonatomic,strong) UILabel      *dateLabel;

@end

@implementation ClockBoard

+(instancetype)boardView:(CGRect)frame {
    return [[ClockBoard alloc] initWithFrame:frame];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self drawGradientBg];
        [self drawClockScale];
        [self setupDateLabel];
        [self drawClockPointer];
        [self setupSubviews];
        [self drawClockCenter];
    }
    return self;
}

-(void)setHour:(CGFloat)hour
        minute:(CGFloat)minute
        second:(CGFloat)second {
    
    _hour = hour;
    _minute = minute;
    _second = second + minute * 60.f + hour * 3600.f;
    
    [self updateHour:hour
              minute:minute
              second:second
             animate:NO];
}

-(void)setYear:(NSInteger)year
         Month:(NSInteger)month
           day:(NSInteger)day {
    
    _dateLabel.text = [NSString stringWithFormat:@"%ld-%ld-%ld",(long)year,(long)month,(long)day];
}

-(void)start {
    [self setupTimer];
}

-(void)stop {
    [self stopTimer];
}

-(void)setupSubviews {
//    self.backgroundColor = SFhexColor(@"3b4857");
}

-(void)layoutSubviews {
    [super layoutSubviews];
    
    [self setCorner:self.width/2];
    
}

// 表中心
-(void)drawClockCenter {
    
    _centerLayer = [CAShapeLayer layer];
    
    _centerLayer.frame = self.bounds;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds)) radius:3 startAngle:0 endAngle:2*M_PI clockwise:NO];
    _centerLayer.path = path.CGPath;
    _centerLayer.strokeColor = kPurpleColor.CGColor;
    _centerLayer.lineWidth = 1.5f;
    [self.layer addSublayer:_centerLayer];
    
    CAShapeLayer *innerLayer = [CAShapeLayer layer];
    innerLayer.frame = self.bounds;
    UIBezierPath *path1 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds)) radius:1.5 startAngle:0 endAngle:2*M_PI clockwise:NO];
    innerLayer.path = path1.CGPath;
    innerLayer.strokeColor = UIColor.brownColor.CGColor;
    innerLayer.lineWidth = 1.f;
    [self.layer addSublayer:innerLayer];
    
}

// 绘制背景渐变
-(void)drawGradientBg {
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.frame = self.bounds;
    layer.startPoint = CGPointMake(0, 0);
    layer.endPoint = CGPointMake(0, 1);
    layer.colors = @[(id)SFhexColor(@"17295c").CGColor,(id)SFhexColor(@"426ead").CGColor];
    [self.layer addSublayer:layer];
}

// 刻度
-(void)drawClockScale {
    
    // 2. 逐个画虚线 同时画上刻度值
    CGFloat angle = M_PI / 30.f;
    CGFloat valueAngle = M_PI / 6.f;
    
    for (int i = 1; i<=60; i++) {
        
        CAShapeLayer *scaleLayer = [CAShapeLayer layer];
        scaleLayer.frame = self.bounds;
        scaleLayer.lineWidth = i % 5 == 0 ? 4.f : 2.f;
        scaleLayer.strokeColor = kCyanColor.CGColor;
        scaleLayer.transform = CATransform3DMakeRotation(i * angle, 0, 0, 1);
        
        UIBezierPath *scalePath = [UIBezierPath bezierPath];
        
        CGPoint startPoint = CGPointMake(100, 0);
        CGPoint endPoint = CGPointMake(100, i % 5 == 0 ? 8 : 4);
        [scalePath moveToPoint:startPoint];
        [scalePath addLineToPoint:endPoint];
        
        scaleLayer.path = scalePath.CGPath;
        [self.layer addSublayer:scaleLayer];
        
        if (i % 5 == 0) {
            UILabel *scaleValue = [UILabel new];
            scaleValue.frame = CGRectMake(CGRectGetMidX(self.bounds)-15, 0, 30, 30);
            scaleValue.textColor = kWhiteColor;
            scaleValue.font = [UIFont systemFontOfSize:15];
            scaleValue.textAlignment = NSTextAlignmentCenter;
            scaleValue.text = [NSString stringWithFormat:@"%d",i/5];
            [self addSubview:scaleValue];
            
            scaleValue.transform = GetCGAffineTransformRotateAroundPoint(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame), CGRectGetWidth(self.bounds)/2, CGRectGetHeight(self.bounds)-15, valueAngle * (i / 5));
            
            //    caleValue.transform = CGAffineTransformMakeRotation(valueAngle * i / 5);
        }
    }
    
    
    // 1.用虚线画刻度，但是精度不够高且不能画较粗的刻度
    //        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    //        shapeLayer.bounds = self.bounds;
    //        shapeLayer.position = CGPointMake(100.f, 100.f);
    //        shapeLayer.fillColor = kClearColor.CGColor;
    //        shapeLayer.strokeColor = kCyanColor.CGColor;
    //        shapeLayer.lineWidth = 9.f;
    //
    //        CGFloat circleLength = M_PI * CGRectGetWidth(self.bounds);
    //        CGFloat lineWidth = 2.f;
    //        CGFloat lineSpaceing = circleLength / 60.f - lineWidth;
    //
    //        shapeLayer.lineDashPattern = [NSArray arrayWithObjects:@(lineWidth),@(lineSpaceing), nil];
    
    //        UIBezierPath *scalePath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(100.f,100.f) radius:self.width/2.f startAngle:0 endAngle:M_PI*2 clockwise:NO];
    //        shapeLayer.path = scalePath.CGPath;
    //        [self.layer addSublayer:shapeLayer];
    
}

-(void)setupDateLabel {
    _dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.bounds)+12, CGRectGetMidY(self.bounds)-5, CGRectGetWidth(self.bounds)/2 - 45, 10)];
    _dateLabel.font = [UIFont systemFontOfSize:9];
    [_dateLabel setCorner:2];
    _dateLabel.textColor = SFhexColorAlpha(@"000000", 0.9);
    _dateLabel.backgroundColor = SFhexColorAlpha(@"ffffff", 0.9);
    _dateLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_dateLabel];
    
    UIImageView *logo = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.bounds)-30, 25, 60, 60)];
    logo.image = [UIImage imageNamed:@"rolex"];
    [self addSubview:logo];
}

// 表针
-(void)drawClockPointer {
    
    _hourPtr = [ClockPointer pointerWithType:ClockPointerTypeHour];
    _minPtr  = [ClockPointer pointerWithType:ClockPointerTypeMin];
    _secPtr  = [ClockPointer pointerWithType:ClockPointerTypeSec];
    
    CGFloat centerX = CGRectGetMidX(self.bounds);
    CGFloat centerY = CGRectGetMidY(self.bounds);
    
    _hourPtr.frame = CGRectMake(centerX, centerY, 30, [_hourPtr length]);
    _minPtr.frame  = CGRectMake(centerX, centerY, 30, [_minPtr length]);
    _secPtr.frame  = CGRectMake(centerX, centerY, 30, [_secPtr length]);
    
    [self.layer addSublayer:_hourPtr];
    [self.layer addSublayer:_minPtr];
    [self.layer addSublayer:_secPtr];
    
}

-(void)updateHour:(CGFloat)hour
           minute:(CGFloat)min
           second:(CGFloat)sec
          animate:(BOOL)isAnimate {
    
    /*
     hour   2π / 12
     min    2π / 12 * 5
     second 2π / 12 * 5
     */
    
    CGFloat hourArc     = M_PI + hour * (2 * M_PI / 12.f);
    CGFloat minuteArc   = M_PI + min  * (2 * M_PI / 60.f);
    CGFloat secondArc   = M_PI + sec  * (2 * M_PI / 60.f);
    
//    if ((hour > 6.f && hour <= 12) || ((hour > 18 && hour <= 24))) {
//        hourArc     = hour * (2 * M_PI / 12.f) - M_PI;
//    }
//    if (min > 30) {
//        minuteArc   = min  * (2 * M_PI / 60.f) - M_PI;
//    }
//    if (sec > 30) {
//        secondArc   = sec  * (2 * M_PI / 60.f) - M_PI;
//    }
    
    NSLog(@"  %f   %f   %f   小时:%f 分钟:%f  秒:%f",hourArc,minuteArc,secondArc,_hour,_minute,_second);
    WeakSelfDefault
    void(^transformAction)(void) = ^(){
        weakSelf.hourPtr.transform = CATransform3DMakeRotation(hourArc, 0, 0, 1);
        weakSelf.minPtr.transform  = CATransform3DMakeRotation(minuteArc, 0, 0, 1);
        weakSelf.secPtr.transform  = CATransform3DMakeRotation(secondArc, 0, 0, 1);
    };
    if (isAnimate) {
        [UIView animateWithDuration:1 animations:^{
            transformAction();
        }];
    }else {
        transformAction();
    }
    
}

-(void)timerAction {
    
    _second += 1.f;
    _minute = _second / 60.f;
    _hour   = _minute / 60.f;
    [self updateHour:_hour minute:_minute second:_second animate:YES];
}

-(void)setupTimer {
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
        [_timer setFireDate:[NSDate distantPast]];
    }
}

-(void)stopTimer {
    [_timer setFireDate:[NSDate distantFuture]];
    [_timer invalidate];
    _timer = nil;
}

// 绕某个中心点旋转
CGAffineTransform GetCGAffineTransformRotateAroundPoint(float centerX,float centerY,float x,float y,float angle) {
    x = x - centerX;
    y = y - centerY;
    CGAffineTransform transform = CGAffineTransformMakeTranslation(x, y);
    transform = CGAffineTransformRotate(transform, angle);
    transform = CGAffineTransformTranslate(transform, -x, -y);
    return transform;
}


@end
