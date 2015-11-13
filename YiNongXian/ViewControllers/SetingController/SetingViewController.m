//
//  SetingViewController.m
//  YiNongXian
//
//  Created by 索金铭 on 15/11/13.
//  Copyright © 2015年 bxlt. All rights reserved.
//

#import "SetingViewController.h"

@interface SetingViewController ()

@end

@implementation SetingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden=NO;
    self.navigationItem.title=@"系统设置";

    [self.navigationController.navigationBar setTitleTextAttributes:
     
  @{NSFontAttributeName:[UIFont systemFontOfSize:18],
    
    NSForegroundColorAttributeName:[UIColor whiteColor]}];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark-隐藏键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.iPtext resignFirstResponder];
   
}


@end
