//
//  ZSNavigationController.m
//  CustomNavigationControllerTransitionDemo
//
//  Created by Allen on 16/9/29.
//  Copyright © 2016年 Allen. All rights reserved.
//

#import "ZSNavigationController.h"
#import "ZSNavigationControllerTransition.h"

@interface ZSNavigationController ()
@property (nonatomic, strong)ZSNavigationControllerTransition *navTransition;
@end

@implementation ZSNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    _navTransition = [[ZSNavigationControllerTransition alloc]initWithViewNavigationController:self];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
