//
//  PopGestureRecognizerManagerConfiger.h
//  ScreenPoP
//
//  Created by wr on 2019/7/3.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PopGestureRecognizerManagerConfiger : NSObject

/**
 导航控制器
 默认为当前window的导航控制器
 */
@property (nonatomic, strong) UINavigationController *navagationController;

/**
 拖动时，背景颜色
 默认为0x333333
 */
@property (nonatomic, retain) UIColor *backGroundColor;

/**
 背景眼神alpha
 默认为0.5
 */
@property (nonatomic, assign) float backGroundAlpha;

/**
 拖动时展示的图片
 必填，否则无图片
 */
@property (nonatomic, copy) NSString *returnImageName;

/**
 用于修改拖动时展示的图片的颜色
 默认为不变色即nil
 */
@property (nonatomic, retain, nullable) UIColor *imageColor;

/**
 是否跟随手势位置移动
 默认为NO
 */
@property (nonatomic, assign) BOOL isFollowGesturePosition;

/**
 是否可以返回首页
 默认为NO
 */
@property (nonatomic, assign) BOOL isCanPopToRootViewController;

/**
 返回首页拖动时展示的图片
 isCanPopToRootViewController为YES时，必填
 */
@property (nonatomic, copy) NSString *returnHomeImageName;

/**
 返回首页用时
 默认为1秒
 */
@property (nonatomic, assign) int returnHomeTime;

@end

NS_ASSUME_NONNULL_END
