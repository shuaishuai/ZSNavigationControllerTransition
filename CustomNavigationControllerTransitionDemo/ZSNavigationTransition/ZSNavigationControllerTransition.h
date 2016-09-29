//
//  EFNavigationControllerTransition.h
//  Demo
//
//  Created by Allen on 16/7/29.
//  Copyright © 2016年 shuai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ZSNavigationControllerTransition : NSObject<UIViewControllerAnimatedTransitioning>

/**
 是否要打开手势滑动pop操作
 */
@property (nonatomic,assign)BOOL shouldPopPanGesEnable;

/**
 初始化一个转场控制器

 @param nav 需要提供转场功能的导航控制器

 @return 转场控制器实例
 */
- (instancetype)initWithViewNavigationController:(UINavigationController *)nav;
@end
