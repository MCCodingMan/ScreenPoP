//
//  ThirdViewController.m
//  ScreenPoPDemo
//
//  Created by wr on 2019/7/4.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import "ThirdViewController.h"

@interface ThirdViewController ()

@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSomeThing];
    [self initScreenPoP];
    // Do any additional setup after loading the view.
}

- (void)initScreenPoP {
    PopGestureRecognizerManager *manager = [PopGestureRecognizerManager shareManager];
    manager.config.returnImageName = @"icon_pop_jt3";
    manager.config.returnHomeImageName = @"icon_pop_home";
    manager.config.isCanPopToRootViewController = YES;
    manager.config.backGroundColor = [UIColor redColor];
    manager.config.backGroundAlpha = 0.3;
    manager.config.imageColor = [UIColor redColor];
    manager.config.isFollowGesturePosition = NO;
}

- (void)initSomeThing {
    self.view.backgroundColor = [UIColor purpleColor];
    self.title = @"第三个控制器";
}

@end
