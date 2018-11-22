//
//  FFNavigationBar.m
//  swfans
//
//  Created by fengzifeng on 2017/9/22.
//  Copyright © 2017年 fengzifeng. All rights reserved.
//

#import "FFNavigationBar.h"
#import "UIView+Addition.h"
#define ShortSystemVersion   [[UIDevice currentDevice].systemVersion floatValue]
#define SCREEN_HEIGHT        ([[UIScreen mainScreen] bounds].size.height)
#define IS_IPHONE_X (SCREEN_HEIGHT == 812.0f) ? YES : NO

@implementation FFNavigationBar

- (void)layoutSubviews {
    [super layoutSubviews];
    if (ShortSystemVersion >= 11.0) {
        for (UIView *view in self.subviews) {
            if([NSStringFromClass([view class]) containsString:@"Background"]) {
                view.frame = self.bounds;
            }
            else if ([NSStringFromClass([view class]) containsString:@"ContentView"]) {
                CGRect frame = view.frame;
                frame.origin.y = 20;
                if (IS_IPHONE_X) frame.origin.y = 44;
                
                frame.size.height = self.bounds.size.height - frame.origin.y;
                view.frame = frame;
            }
        }
    }
}

@end
