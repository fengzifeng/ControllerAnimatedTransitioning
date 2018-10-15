//
//  rootViewController.m
//  ControllerAnimatedTransitioning
//
//  Created by fengzifeng on 2018/10/12.
//  Copyright © 2018年 fengzifeng. All rights reserved.
//

#import "rootViewController.h"
#import "firstViewController.h"
#import "secondViewController.h"
#import "ThirdViewController.h"
#import "FourViewController.h"
#import "SevenViewController.h"
#import "SixViewController.h"
#import "FiveViewController.h"
#import "EightViewController.h"
//渐隐渐现动画
//FFNavigationTransitionOptionFlip,           //3D翻转动画
//FFNavigationTransitionOptionScale,          //类似相册的缩放动画
//FFNavigationTransitionOptionSystem,         //模拟系统动画
//FFNavigationTransitionOptionFromRight,      //从右边弹出动画
//FFNavigationTransitionOptionFromLeft,       //从左边弹出动画
//FFNavigationTransitionOptionFromTop,        //从顶部弹出动画
//FFNavigationTransitionOptionFromBottom,     //从底部弹出动画
@interface rootViewController ()

@end

@implementation rootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100, 100, 100, 30);
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    [button setTitle:@"系统push" forState:UIControlStateNormal];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(100, 150, 100, 30);
    button1.backgroundColor = [UIColor redColor];
    [button1 addTarget:self action:@selector(click1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    [button1 setTitle:@"渐隐渐现动画" forState:UIControlStateNormal];

    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(100, 200, 100, 30);
    button2.backgroundColor = [UIColor redColor];
    [button2 addTarget:self action:@selector(click2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    [button2 setTitle:@"3D翻转动画" forState:UIControlStateNormal];

    UIButton *button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    button3.frame = CGRectMake(100, 250, 100, 30);
    button3.backgroundColor = [UIColor redColor];
    [button3 addTarget:self action:@selector(click3) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button3];
    [button3 setTitle:@"缩放动画" forState:UIControlStateNormal];

    UIButton *button4 = [UIButton buttonWithType:UIButtonTypeCustom];
    button4.frame = CGRectMake(100, 300, 100, 30);
    button4.backgroundColor = [UIColor redColor];
    [button4 addTarget:self action:@selector(click4) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button4];
    [button4 setTitle:@"从右边弹出" forState:UIControlStateNormal];

    UIButton *button5 = [UIButton buttonWithType:UIButtonTypeCustom];
    button5.frame = CGRectMake(100, 350, 100, 30);
    button5.backgroundColor = [UIColor redColor];
    [button5 addTarget:self action:@selector(click5) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button5];
    [button5 setTitle:@"从左边弹出" forState:UIControlStateNormal];

    UIButton *button6 = [UIButton buttonWithType:UIButtonTypeCustom];
    button6.frame = CGRectMake(100, 400, 100, 30);
    button6.backgroundColor = [UIColor redColor];
    [button6 addTarget:self action:@selector(click6) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button6];
    [button6 setTitle:@"从顶部弹出" forState:UIControlStateNormal];

    UIButton *button7 = [UIButton buttonWithType:UIButtonTypeCustom];
    button7.frame = CGRectMake(100, 450, 100, 30);
    button7.backgroundColor = [UIColor redColor];
    [button7 addTarget:self action:@selector(click7) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button7];
    [button7 setTitle:@"从底部弹出" forState:UIControlStateNormal];

}

- (void)click
{
    firstViewController *vc = [[firstViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)click1
{
    secondViewController *vc = [[secondViewController alloc] init];
    vc.transitionOption = FFNavigationTransitionOptionFade;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)click2
{
    ThirdViewController *vc = [[ThirdViewController alloc] init];
    vc.transitionOption = FFNavigationTransitionOptionFlip;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)click3
{
    FourViewController *vc = [[FourViewController alloc] init];
    vc.transitionOption = FFNavigationTransitionOptionScale;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)click4
{
    FiveViewController *vc = [[FiveViewController alloc] init];
    vc.transitionOption = FFNavigationTransitionOptionFromRight;

    [self.navigationController pushViewController:vc animated:YES];
}

- (void)click5
{
    SixViewController *vc = [[SixViewController alloc] init];
    vc.transitionOption = FFNavigationTransitionOptionFromLeft;
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)click6
{
    SevenViewController *vc = [[SevenViewController alloc] init];
    vc.transitionOption = FFNavigationTransitionOptionFromTop;
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)click7
{
    EightViewController *vc = [[EightViewController alloc] init];
    vc.transitionOption = FFNavigationTransitionOptionFromBottom;
    
    [self.navigationController pushViewController:vc animated:YES];
}

@end
