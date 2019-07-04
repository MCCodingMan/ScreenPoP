//
//  PopGestureRecognizerManager.m
//  ScreenPoP
//
//  Created by wr on 2019/7/3.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import "PopGestureRecognizerManager.h"

//屏幕大小
#define Gesture_SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define Gesture_SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
//颜色宏定义
#define Gesture_COLOR_HEX(hex) Gesture_COLOR_HEXA(hex,1.0f)
#define Gesture_COLOR_HEXA(rgbValue,a) [UIColor colorWithRed:((float)(((rgbValue) & 0xFF0000) >> 16))/255.0 green:((float)(((rgbValue) & 0xFF00)>>8))/255.0 blue: ((float)((rgbValue) & 0xFF))/255.0 alpha:(a)]
#define Gesture_ImageWithName(imgName) [UIImage imageNamed:imgName]
#define Gesture_KeyWindow [[UIApplication sharedApplication] delegate].window

static PopGestureRecognizerManager *manager;

@implementation PopGestureRecognizerManager{
    CAShapeLayer *shapeLayer;
    CGPoint startPoint;
    CGPoint farPoint;
    CGPoint lastPoint;
    CGPoint homeLeftPoint;
    BOOL isPopToRootController;
    NSTimer *timer;
}

+ (instancetype)shareManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[PopGestureRecognizerManager alloc] init];
        [manager addScreenEdgePanGestureToWindow];
    });
    return manager;
}

- (instancetype)init {
    if (self = [super init]) {
        _config = [[PopGestureRecognizerManagerConfiger alloc] init];
    }
    return self;
}

/**
 添加手势到window上
 */
- (void)addScreenEdgePanGestureToWindow {
    UIScreenEdgePanGestureRecognizer *gesture = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(screenEdgePanGestureExcuteEvent:)];
    gesture.edges = UIRectEdgeRight;
    [Gesture_KeyWindow addGestureRecognizer:gesture];
}

/**
 屏幕边界手势执行事件
 
 @param gesture 手势
 */
- (void)screenEdgePanGestureExcuteEvent:(UIScreenEdgePanGestureRecognizer *)gesture {
    CGPoint changePoint = [gesture locationInView:Gesture_KeyWindow];
    if (gesture.state == UIGestureRecognizerStateBegan) {
        farPoint = changePoint;
    }
    if (gesture.state == UIGestureRecognizerStateChanged) {
        if (changePoint.x < farPoint.x) {
            farPoint = changePoint;
        }
        if (_config.isCanPopToRootViewController) {
            if (homeLeftPoint.x > changePoint.x + 3 || homeLeftPoint.x < changePoint.x - 3) {
                [self createLayer:changePoint];
                isPopToRootController = NO;
                [NSObject cancelPreviousPerformRequestsWithTarget:self];
                [self performSelector:@selector(changeReturnType:) withObject:@(changePoint.x) afterDelay:_config.returnHomeTime];
            }
        }else{
            [self createLayer:changePoint];
        }
    }
    if (gesture.state == UIGestureRecognizerStateEnded) {
        CABasicAnimation *anim = [CABasicAnimation animation];
        anim.keyPath = @"position";
        anim.duration = 0.5;
        anim.fromValue = [NSValue valueWithCGPoint:shapeLayer.position];
        anim.toValue = [NSValue valueWithCGPoint:CGPointMake(shapeLayer.position.x + 55, shapeLayer.position.y)];
        anim.fillMode = kCAFillModeForwards;
        anim.removedOnCompletion = NO;
        [shapeLayer addAnimation:anim forKey:nil];
        if (changePoint.x < farPoint.x + 20) {
            if (!isPopToRootController) {
                [_config.navagationController popViewControllerAnimated:YES];
            }else{
                [_config.navagationController popToRootViewControllerAnimated:YES];
            }
        }
    }
}

/**
 创建背景layer
 
 @param progressPoint 滑动点
 */
- (void)createLayer:(CGPoint)progressPoint {
    CGPoint tempPoint = CGPointZero;
    if (progressPoint.x < Gesture_SCREEN_WIDTH - 40) {
        tempPoint = CGPointMake(Gesture_SCREEN_WIDTH - 40, progressPoint.y);
    }else{
        tempPoint = progressPoint;
    }
    if (_config.isFollowGesturePosition) {
        if (progressPoint.y <= 100) {
            tempPoint = CGPointMake(tempPoint.x, 100);
        }else if (progressPoint.y >= Gesture_SCREEN_HEIGHT - 100) {
            tempPoint = CGPointMake(tempPoint.x, Gesture_SCREEN_HEIGHT - 100);
        }
    }else{
        tempPoint = CGPointMake(Gesture_SCREEN_WIDTH - 40, Gesture_SCREEN_HEIGHT / 2);
    }
    [shapeLayer removeFromSuperlayer];
    shapeLayer = [CAShapeLayer layer];
    shapeLayer.backgroundColor = [UIColor clearColor].CGColor;
    shapeLayer.frame = CGRectMake(0, 0, Gesture_SCREEN_WIDTH, Gesture_SCREEN_HEIGHT);
    shapeLayer.lineJoin = kCALineJoinRound;
    shapeLayer.lineCap = kCALineCapRound;
    CALayer *subLayer = [CALayer layer];
    subLayer.backgroundColor = [UIColor clearColor].CGColor;
    subLayer.contents = (__bridge id _Nullable)([self changeImage:Gesture_ImageWithName(_config.returnImageName) Color:_config.imageColor].CGImage);
    subLayer.frame = CGRectMake(tempPoint.x + 10, tempPoint.y - 15, 30, 30);
    UIBezierPath *path = [[UIBezierPath alloc] init];
    path.lineWidth = 1;
    path.usesEvenOddFillRule = YES;
    [path moveToPoint:CGPointMake(Gesture_SCREEN_WIDTH, tempPoint.y - 100)];
    [path addQuadCurveToPoint:CGPointMake(tempPoint.x + 10 * (Gesture_SCREEN_WIDTH - tempPoint.x) / 40, tempPoint.y - 20) controlPoint:CGPointMake(Gesture_SCREEN_WIDTH, tempPoint.y - 70)];
    [path addQuadCurveToPoint:CGPointMake(tempPoint.x + 10 * (Gesture_SCREEN_WIDTH - tempPoint.x) / 40, tempPoint.y + 20) controlPoint:CGPointMake(tempPoint.x - 0 * (Gesture_SCREEN_WIDTH - tempPoint.x) / 40, tempPoint.y)];
    [path addQuadCurveToPoint:CGPointMake(Gesture_SCREEN_WIDTH, tempPoint.y + 100) controlPoint:CGPointMake(Gesture_SCREEN_WIDTH, tempPoint.y + 70)];
    shapeLayer.fillColor = [_config.backGroundColor colorWithAlphaComponent:_config.backGroundAlpha].CGColor;
    shapeLayer.path = path.CGPath;
    [shapeLayer addSublayer:subLayer];
    [Gesture_KeyWindow.layer addSublayer:shapeLayer];
}

/**
 改变返回执行类型以及图标
 */
- (void)changeReturnType:(NSNumber *)pointX {
    homeLeftPoint = CGPointMake([pointX floatValue], 0);
    isPopToRootController = YES;
    CALayer *layer = [shapeLayer.sublayers firstObject];
    layer.contents = (__bridge id _Nullable)([self changeImage:Gesture_ImageWithName(_config.returnHomeImageName) Color:_config.imageColor].CGImage);
}

/**
 修改图片颜色
 
 @param image 要改变的图片
 @param color 设置的颜色
 @return 返回图片
 */
- (UIImage *)changeImage:(UIImage *)image Color:(UIColor * __nullable)color {
    if (color) {
        UIGraphicsBeginImageContextWithOptions(image.size, NO, image.scale);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextTranslateCTM(context, 0, image.size.height);
        CGContextScaleCTM(context, 1.0, -1.0);
        CGContextSetBlendMode(context, kCGBlendModeNormal);
        CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
        CGContextClipToMask(context, rect, image.CGImage);
        [color setFill];
        CGContextFillRect(context, rect);
        UIImage*newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return newImage;
    }else{
        return image;
    }
}

@end

