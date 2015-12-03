//
//  SetingViewController.m
//  YiNongXian
//
//  Created by 索金铭 on 15/11/13.
//  Copyright © 2015年 bxlt. All rights reserved.
//

#import "SetingViewController.h"
#import "AppDelegate.h"
@interface SetingViewController ()

@end

@implementation SetingViewController
@synthesize iPtext;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden=NO;
    self.navigationItem.title=@"系统设置";
     AppDelegate * del=DELEGATE;
    iPtext.text=del.POSTURL;
    

    
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


- (IBAction)StartAction:(id)sender {
    AppDelegate * del=DELEGATE;
    del.POSTURL=iPtext.text;
    [iPtext resignFirstResponder];
}
@end
