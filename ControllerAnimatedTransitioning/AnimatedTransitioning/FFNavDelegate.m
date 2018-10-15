//
//  FFNavDelegate.m
//  ControllerAnimatedTransitioning
//
//  Created by fengzifeng on 2018/10/12.
//  Copyright © 2018年 fengzifeng. All rights reserved.
//

#import "FFNavDelegate.h"
#import "FFAnimatedTransitioning.h"
#import "FFBaseViewController.h"

@interface FFNavDelegate ()

@property (strong, nonatomic) FFSysAnimatedTransitioning *sysTransition;
@property (strong, nonatomic) FFFlipAnimatedTransitioning *flipTransition;
@property (strong, nonatomic) FFFadeAnimatedTransitioning *fadeTransition;
@property (strong, nonatomic) FFScaleAnimatedTransitioning *scaleTransition;
@property (strong, nonatomic) FFPresentAnimatedTransitioning *presentTransition;

@property (strong, nonatomic) UIPanGestureRecognizer *panGestureRecognizer;
@property (strong, nonatomic) UIPercentDrivenInteractiveTransition *interactiveTransition;

@end

@implementation FFNavDelegate

- (instancetype)init
{
    self = [super init];
    if (self) {
        // init your code
        self.hidden = YES;
        _panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureHandler:)];
        _panGestureRecognizer.delegate = self;
        
        _sysTransition = [FFSysAnimatedTransitioning new];
        _flipTransition = [FFFlipAnimatedTransitioning new];
        _fadeTransition = [FFFadeAnimatedTransitioning new];
        _scaleTransition = [FFScaleAnimatedTransitioning new];
        _presentTransition = [FFPresentAnimatedTransitioning new];
    }
    return self;
}

- (void)setNavigationController:(UINavigationController *)navigationController
{
    _navigationController = navigationController;
    
    [_navigationController.view insertSubview:self atIndex:0];
    [_navigationController.view addGestureRecognizer:_panGestureRecognizer];
}

- (void)panGestureHandler:(UIPanGestureRecognizer*)recognizer
{
    // Calculate how far the user has dragged across the view
    UIView *view = _navigationController.view;
    CGPoint translation = [recognizer translationInView:view];
    CGFloat progress = translation.x / CGRectGetWidth(view.bounds);
    progress = MIN(1.0, MAX(0.0, fabs(progress)));
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        CGPoint location = [recognizer locationInView:view];
        CGPoint velocity = [recognizer velocityInView:view];
        NSInteger count = _navigationController.viewControllers.count;
        
        if (location.x <  CGRectGetMidX(view.bounds) && velocity.x > 0 && count > 1) { // left half went right
            // Create a interactive transition and pop the view controller
            _interactiveTransition = [UIPercentDrivenInteractiveTransition new];
            [_navigationController popViewControllerAnimated:YES];
        }
        else if (location.x >  CGRectGetMidX(view.bounds) && velocity.x < 0) { // right half went left
            //Need topViewController implementation selector
            //push出一个新页面
            FFBaseViewController *topViewController = (id)_navigationController.topViewController;
            if ([topViewController respondsToSelector:@selector(viewControllerWillPushForLeftDirectionPan)]) {
                UIViewController *viewController = [topViewController viewControllerWillPushForLeftDirectionPan];
                if (viewController) {
                    // Create a interactive transition and push the view controller
                    _interactiveTransition = [UIPercentDrivenInteractiveTransition new];
                    [_navigationController pushViewController:viewController animated:YES];
                }
            }
        }
    }
    else if (recognizer.state == UIGestureRecognizerStateChanged) {
        // Update the interactive transition's progress
        [_interactiveTransition updateInteractiveTransition:progress];
    }
    else if (recognizer.state == UIGestureRecognizerStateEnded ||
             recognizer.state == UIGestureRecognizerStateCancelled) {
        // Finish or cancel the interactive transition
        if (progress < 0.4  || recognizer.state == UIGestureRecognizerStateCancelled) {
            [_interactiveTransition cancelInteractiveTransition];
        } else {
            [_interactiveTransition finishInteractiveTransition];
        }
        _interactiveTransition = nil;
    }
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    FFAnimatedTransitioning *transition = nil;
    
    BOOL reversed = operation==UINavigationControllerOperationPop;
    FFBaseViewController *targetVC = (FFBaseViewController *)(reversed?fromVC:toVC);
    
    if ([targetVC respondsToSelector:@selector(transitionOption)]) {
        switch (targetVC.transitionOption) {
            case FFNavigationTransitionOptionFade:
                transition = _fadeTransition;
                break;
            case FFNavigationTransitionOptionSystem:
                transition = _sysTransition;
                break;
            case FFNavigationTransitionOptionFlip:
//                transition = _flipTransition;//动画不太流畅
                transition = _interactiveTransition?_sysTransition:_flipTransition;
                break;
            case FFNavigationTransitionOptionScale:
                if ([targetVC conformsToProtocol:@protocol(FFScaleTransitionAnimatorDataSource)]) {
                    _scaleTransition.dataSource = (id)targetVC;
                    transition = _scaleTransition;
                } else {
                    targetVC.transitionOption = FFNavigationTransitionOptionNone;
                }
                break;
                
            case FFNavigationTransitionOptionFromRight:
            case FFNavigationTransitionOptionFromLeft:
            case FFNavigationTransitionOptionFromTop:
            case FFNavigationTransitionOptionFromBottom:
                transition = _presentTransition;
                _presentTransition.option = targetVC.transitionOption;
                break;
                
            default:
                break;
        }
    }
    transition.reversed = reversed;
    transition.interactive = _interactiveTransition?YES:NO;
    
    return transition;
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController
{
    if ([animationController isKindOfClass:[FFAnimatedTransitioning class]]) {
        _panGestureRecognizer.enabled = YES;
        return _interactiveTransition;
    }
    
    _panGestureRecognizer.enabled = NO;
    return nil;
}

#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(FFBaseViewController *)viewController animated:(BOOL)animated
{
    if ([viewController respondsToSelector:@selector(transitionOption)] &&
        viewController.transitionOption != FFNavigationTransitionOptionNone) {
        _panGestureRecognizer.enabled = YES;
    }
    else {
        _panGestureRecognizer.enabled = NO;
    }
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (_navigationController.viewControllers.count == 1) {
        return NO;
    }
    
    return YES;
}


@end
