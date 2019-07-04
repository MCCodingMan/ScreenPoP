//
//  SecondViewController.m
//  ScreenPoPDemo
//
//  Created by wr on 2019/7/4.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSomeThing];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self initScreenPoP];
}

- (void)initScreenPoP {
    PopGestureRecognizerManager *manager = [PopGestureRecognizerManager shareManager];
    manager.config.returnImageName = @"icon_pop_jt";
    manager.config.isCanPopToRootViewController = NO;
    manager.config.backGroundColor = [UIColor blueColor];
    manager.config.backGroundAlpha = 0.3;
    manager.config.imageColor = [UIColor greenColor];
    manager.config.isFollowGesturePosition = YES;
}

- (void)initSomeThing {
    self.view.backgroundColor = [UIColor grayColor];
    self.title = @"第二个控制器";
    UIButton *jumpButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [jumpButton setTitle:@"跳第三个" forState:UIControlStateNormal];
    [jumpButton addTarget:self action:@selector(jump) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:jumpButton];
    jumpButton.frame = CGRectMake(200, 200, 100, 100);
}

- (void)jump {
    ThirdViewController *vc = [[ThirdViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
