//
//  FFBaseViewController.m
//  ControllerAnimatedTransitioning
//
//  Created by fengzifeng on 2018/10/12.
//  Copyright © 2018年 fengzifeng. All rights reserved.
//

#import "FFBaseViewController.h"
#define HexColor(hexValue)  [UIColor colorWithRed:((float)(((hexValue) & 0xFF0000) >> 16))/255.0 green:((float)(((hexValue) & 0xFF00) >> 8))/255.0 blue:((float)((hexValue) & 0xFF))/255.0 alpha:1]   //16进制颜色值，如：#000000 , 注意：在使用的时候hexValue写成：0x000000

@interface FFBaseViewController ()

@end

@implementation FFBaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.navigationBar = [[FFNavigationBar alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44)];
        self.myNavigationItem = [[UINavigationItem alloc] initWithTitle:@""];
        NSLog(@"init 创建类 %@", NSStringFromClass([self class]));
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationBar.barTintColor = HexColor(0xaa2d1b);
    self.navigationBar.clipsToBounds = true;
    self.navigationBar.translucent = false;
    self.navigationBar.tag = 100000001;
    NSShadow *shadow = [NSShadow new];
    [shadow setShadowColor: [UIColor clearColor]];
    
    NSDictionary * dict = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSShadowAttributeName:shadow};
    self.navigationBar.titleTextAttributes = dict;
    [self.view addSubview:self.navigationBar];
    [self.navigationBar pushNavigationItem:self.myNavigationItem animated:false];
//    [self.navigationBar autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeBottom];
}


- (UIViewController *)viewControllerWillPushForLeftDirectionPan
{
    return nil;
}



@end
