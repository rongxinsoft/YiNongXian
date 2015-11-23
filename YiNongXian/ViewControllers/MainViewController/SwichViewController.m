//
//  SwichViewController.m
//  YiNongXian
//
//  Created by 索金铭 on 15/11/13.
//  Copyright © 2015年 bxlt. All rights reserved.
//

#import "SwichViewController.h"
#import "MainViewController.h"
#import "LeftMenuViewController.h"
@interface SwichViewController ()

@end

@implementation SwichViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.centerViewController=[[MainViewController alloc]init];
    self.leftViewController=[[LeftMenuViewController alloc]init];
    [self showLeft];

    self.swipeDelegate=self;
    // Do any additional setup after loading the view.
}
#pragma mark - Swipe delegate
- (void)swipeController:(RNSwipeViewController *)swipeController willShowController:(UIViewController *)controller {
    NSLog(@"will show");
}

- (void)swipeController:(RNSwipeViewController *)swipeController didShowController:(UIViewController *)controller {

    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
