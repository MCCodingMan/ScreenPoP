//
//  PopGestureRecognizerManager.h
//  ScreenPoP
//
//  Created by wr on 2019/7/3.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PopGestureRecognizerManagerConfiger.h"

NS_ASSUME_NONNULL_BEGIN

@interface PopGestureRecognizerManager : NSObject

@property (nonatomic, strong) PopGestureRecognizerManagerConfiger *config;

+ (instancetype)shareManager;
@end

NS_ASSUME_NONNULL_END
