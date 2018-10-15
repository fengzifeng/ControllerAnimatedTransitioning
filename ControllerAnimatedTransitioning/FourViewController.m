//
//  FourViewController.m
//  ControllerAnimatedTransitioning
//
//  Created by fengzifeng on 2018/10/12.
//  Copyright © 2018年 fengzifeng. All rights reserved.
//

#import "FourViewController.h"
#import "UIViewController+Navigation.h"

@interface FourViewController ()

@end

@implementation FourViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationBackButtonDefault];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (CGRect)beginRectWithScaleAnimator:(FFScaleAnimatedTransitioning *)animator
{
    return CGRectMake(0, 64, 0, 0);

}

- (CGRect)endRectWithScaleAnimator:(FFScaleAnimatedTransitioning *)animator
{
    return CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64);

}

- (NSArray<UIView *> *)fadeViewsWithScaleAnimator:(FFScaleAnimatedTransitioning *)animator
{
    return nil;
    
}

- (UIView *)snapshotViewWithScaleAnimator:(FFScaleAnimatedTransitioning *)animator{
    UIView *view = [UIView new];
    [self.view addSubview:view];
    view.backgroundColor = [UIColor yellowColor];
    return view;
}

@end
