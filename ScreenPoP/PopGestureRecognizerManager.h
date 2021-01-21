//
//  PopGestureRecognizerManager.h
//  ScreenPoP
//
//  Created by wr on 2019/7/3.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PopGestureRecognizerManagerConfiger.h"

NS_ASSUME_NONNULL_BEGIN

@interface PopGestureRecognizerManager : NSObject

@property (nonatomic, strong, nonnull) PopGestureRecognizerManagerConfiger *config;

/**
 返回上一个控制器，返回事件
 默认为空
 */
@property (nonatomic, copy, nullable) void(^backActionBlock)(void);

/**
 返回首页，返回事件
 默认为空
 */
@property (nonatomic, copy, nullable) void(^backHomeActionBlock)(void);

/// 单例
+ (instancetype)shareManager;

/// 释放返回Block
- (void)freeBackBlock;

/// 注册
/// @param config 配置信息
/// @param block 注册回调
- (void)registerManagerWithConfig:(PopGestureRecognizerManagerConfiger *)config completeBlock:(void(^)(BOOL isSuccess))block;
@end

NS_ASSUME_NONNULL_END
