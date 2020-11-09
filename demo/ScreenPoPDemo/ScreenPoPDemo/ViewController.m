//
//  ViewController.m
//  ScreenPoPDemo
//
//  Created by wr on 2019/7/4.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initScreenPoP];
    [self initSomeThing];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)initScreenPoP {
    PopGestureRecognizerManager *manager = [PopGestureRecognizerManager shareManager];
    manager.config.navagationController = self.navigationController;
    manager.config.returnImageName = @"icon_pop_jt";
}

- (void)initSomeThing {
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"这是第一个控制器";
    UIButton *jumpButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [jumpButton setTitle:@"跳第二个控制器" forState:UIControlStateNormal];
    [jumpButton addTarget:self action:@selector(jump) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:jumpButton];
    jumpButton.frame = CGRectMake(200, 200, 100, 100);
}

- (void)jump {
    SecondViewController *vc = [[SecondViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
