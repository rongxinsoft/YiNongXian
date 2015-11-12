//
//  MainViewController.m
//  YiNongXian
//
//  Created by 索金铭 on 15/11/12.
//  Copyright © 2015年 bxlt. All rights reserved.
//

#import "MainViewController.h"
#import "SlideViewController.h"
@interface MainViewController ()
@property (nonatomic, retain) SlideViewController* sidebarVC;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    self.sidebarVC.view.frame  = self.view.bounds;
    self.navigationController.navigationBar.hidden=NO;
    
    UIImage* backImage = [UIImage imageNamed:@"no.png"];
    CGRect backframe = CGRectMake(0,0,54,30);
    UIButton* backButton= [[UIButton alloc] initWithFrame:backframe];
    [backButton setBackgroundImage:backImage forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(show:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem * leftBar=[[UIBarButtonItem alloc]initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = leftBar;
    // 左侧边栏开始
    UIPanGestureRecognizer* panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panDetected:)];
    [panGesture delaysTouchesBegan];
    
    [self.view addGestureRecognizer:panGesture];
    self.sidebarVC = [[SlideViewController alloc] init];
    [self.sidebarVC setBgRGB:0x000000];
    [self.view addSubview:self.sidebarVC.view];
}
- (void )show:(id)sender {
    [self.sidebarVC showHideSidebar];
}
- (void)panDetected:(UIPanGestureRecognizer*)recoginzer
{
    [self.sidebarVC panDetected:recoginzer];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
