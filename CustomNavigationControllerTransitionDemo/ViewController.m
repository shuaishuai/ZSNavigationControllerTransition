//
//  ViewController.m
//  CustomNavigationControllerTransitionDemo
//
//  Created by Allen on 16/9/29.
//  Copyright © 2016年 Allen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    NSString *title = [NSString stringWithFormat:@"第%ld层",self.navigationController.viewControllers.count];
    self.title = title;
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)pushController:(id)sender {
    
    ViewController *vc = [[ViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
