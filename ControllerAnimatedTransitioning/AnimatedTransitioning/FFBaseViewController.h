//
//  FFBaseViewController.h
//  ControllerAnimatedTransitioning
//
//  Created by fengzifeng on 2018/10/12.
//  Copyright © 2018年 fengzifeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FFAnimatedTransitioning.h"
#import "FFNavigationBar.h"

@interface FFBaseViewController : UIViewController

@property (nonatomic, assign) FFNavigationTransitionOption transitionOption;
@property(nonatomic, strong) FFNavigationBar *navigationBar;
@property(nonatomic, strong) UINavigationItem *myNavigationItem;

- (UIViewController *)viewControllerWillPushForLeftDirectionPan;

@end
