//
//  FFAnimatedTransitioning.h
//  ControllerAnimatedTransitioning
//
//  Created by fengzifeng on 2018/10/12.
//  Copyright © 2018年 fengzifeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, FFNavigationTransitionOption) {
    FFNavigationTransitionOptionNone = 0,       //系统默认动画
    FFNavigationTransitionOptionFade,           //渐隐渐现动画
    FFNavigationTransitionOptionFlip,           //3D翻转动画
    FFNavigationTransitionOptionScale,          //类似相册的缩放动画
    FFNavigationTransitionOptionSystem,         //模拟系统动画
    FFNavigationTransitionOptionFromRight,      //从右边弹出动画
    FFNavigationTransitionOptionFromLeft,       //从左边弹出动画
    FFNavigationTransitionOptionFromTop,        //从顶部弹出动画
    FFNavigationTransitionOptionFromBottom,     //从底部弹出动画
};


@interface FFAnimatedTransitioning : NSObject <UIViewControllerAnimatedTransitioning>
//防止子类不能调用
{
    BOOL _reversed;
    BOOL _interactive;
}

@property (nonatomic, assign) BOOL reversed;
@property (nonatomic, assign) BOOL interactive;

@end

@interface FFFadeAnimatedTransitioning : FFAnimatedTransitioning

@end

@interface FFFlipAnimatedTransitioning : FFAnimatedTransitioning

@end

@class FFScaleAnimatedTransitioning;
@protocol FFScaleTransitionAnimatorDataSource <NSObject>
@required
- (CGRect)beginRectWithScaleAnimator:(FFScaleAnimatedTransitioning *)animator;
- (CGRect)endRectWithScaleAnimator:(FFScaleAnimatedTransitioning *)animator;
- (NSArray<UIView *> *)fadeViewsWithScaleAnimator:(FFScaleAnimatedTransitioning *)animator;
- (UIView *)snapshotViewWithScaleAnimator:(FFScaleAnimatedTransitioning *)animator;

@optional
- (void)snapshotViewDidPresented:(FFScaleAnimatedTransitioning *)animator;
- (void)snapshotViewDidDismiss:(FFScaleAnimatedTransitioning *)animator;

@end

@interface FFScaleAnimatedTransitioning : FFAnimatedTransitioning

@property (nonatomic, assign) BOOL cancel;
@property (nonatomic, weak) id<FFScaleTransitionAnimatorDataSource> dataSource;

@end

@interface FFSysAnimatedTransitioning : FFAnimatedTransitioning

@end

@interface FFPresentAnimatedTransitioning : FFAnimatedTransitioning

@property (nonatomic, assign) FFNavigationTransitionOption option;

@end

