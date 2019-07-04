//
//  PopGestureRecognizerManagerConfiger.m
//  ScreenPoP
//
//  Created by wr on 2019/7/3.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import "PopGestureRecognizerManagerConfiger.h"
#define Gesture_COLOR_HEX(hex) Gesture_COLOR_HEXA(hex,1.0f)
#define Gesture_COLOR_HEXA(rgbValue,a) [UIColor colorWithRed:((float)(((rgbValue) & 0xFF0000) >> 16))/255.0 green:((float)(((rgbValue) & 0xFF00)>>8))/255.0 blue: ((float)((rgbValue) & 0xFF))/255.0 alpha:(a)]

@implementation PopGestureRecognizerManagerConfiger

- (instancetype)init {
    if (self = [super init]) {
        _navagationController = (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
        _backGroundColor = Gesture_COLOR_HEX(0x000000);
        _isFollowGesturePosition = NO;
        _isCanPopToRootViewController = NO;
        _imageColor = nil;
        _returnHomeTime = 1.0f;
        _backGroundAlpha = 0.3f;
    }
    return self;
}

@end
