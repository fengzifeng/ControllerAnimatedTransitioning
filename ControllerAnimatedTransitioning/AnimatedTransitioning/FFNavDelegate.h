//
//  FFNavDelegate.h
//  ControllerAnimatedTransitioning
//
//  Created by fengzifeng on 2018/10/12.
//  Copyright © 2018年 fengzifeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FFNavDelegate : UIView <UINavigationControllerDelegate,UIGestureRecognizerDelegate>

@property (strong, nonatomic) UINavigationController *navigationController;

@end
