//
//  EFNavigationControllerTransition.m
//  Demo
//
//  Created by Allen on 16/7/29.
//  Copyright © 2016年 shuai. All rights reserved.
//

#import "ZSNavigationControllerTransition.h"
@interface ZSNavigationControllerTransition()<UINavigationControllerDelegate,UIGestureRecognizerDelegate>
@property (nonatomic, weak) UINavigationController *nav;
@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *interactivePopTransition;
@property (nonatomic, assign)BOOL isGestureTriggerAction;//是否是手势触发了pop动作  default: NO
@end

@implementation ZSNavigationControllerTransition

- (instancetype)initWithViewNavigationController:(UINavigationController *)nav
{
    if (self = [super init]) {
        self.nav = nav;
        [self prepareForTransition];
    }
    return self;
}

-(void)prepareForTransition{
    
    self.nav.delegate = self;
    self.shouldPopPanGesEnable = YES;
    
    UIGestureRecognizer *systemGesture = self.nav.interactivePopGestureRecognizer;
    systemGesture.enabled = NO;
    
    UIPanGestureRecognizer *popRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleControllerPop:)];
    popRecognizer.delegate = self;
    popRecognizer.maximumNumberOfTouches = 1;
    [systemGesture.view addGestureRecognizer:popRecognizer];
}

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.3;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    [containerView insertSubview:toViewController.view belowSubview:fromViewController.view];
    
    toViewController.view.transform = CGAffineTransformMakeTranslation(-[UIScreen mainScreen].bounds.size.width+100, 0);
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration animations:^{
        fromViewController.view.transform = CGAffineTransformMakeTranslation([UIScreen mainScreen].bounds.size.width, 0);
        toViewController.view.transform = CGAffineTransformIdentity;
    }completion:^(BOOL finished) {
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
        toViewController.view.transform = CGAffineTransformIdentity;
    }];
    
}

- (void)handleControllerPop:(UIPanGestureRecognizer *)recognizer {
    
    CGFloat progress = [recognizer translationInView:recognizer.view].x / recognizer.view.bounds.size.width;
    progress = MIN(1.0, MAX(0.0, progress));
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        _isGestureTriggerAction = YES;
        [self.nav popViewControllerAnimated:YES];
    }
    else if (recognizer.state == UIGestureRecognizerStateChanged) {
        [self.interactivePopTransition updateInteractiveTransition:progress];
    }
    else if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled) {
        CGFloat velocityX = [recognizer velocityInView:recognizer.view].x;
        if ((progress > 0.2) && (velocityX >= 0)) {
            [self.interactivePopTransition finishInteractiveTransition];
        }
        else {
            [self.interactivePopTransition cancelInteractiveTransition];
        }
        _isGestureTriggerAction = NO;
    }
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC {
    
    if (operation == UINavigationControllerOperationPop && _isGestureTriggerAction)
        return self;
    return nil;
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                         interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
    
    if ([animationController isKindOfClass:[self class]])
        return self.interactivePopTransition;
    return nil;
}

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    return self.shouldPopPanGesEnable;
}

-(UIPercentDrivenInteractiveTransition *)interactivePopTransition{
    if (_interactivePopTransition == nil) {
        _interactivePopTransition = [[UIPercentDrivenInteractiveTransition alloc]init];
    }
    return _interactivePopTransition;
}

@end
