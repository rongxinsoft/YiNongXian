//
//  LoginViewController.m
//  YiNongXian
//
//  Created by 索金铭 on 15/11/12.
//  Copyright © 2015年 bxlt. All rights reserved.
//

#import "LoginViewController.h"
#import "MainViewController.h"
#import "PooCodeView.h"
@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize unameText,upasswordText,yzmText,yzmView;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden=YES;

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark-登录方法/换二维码图片
- (IBAction)login:(id)sender {
    [self.navigationController pushViewController:[[MainViewController alloc]init] animated:YES];
}

- (IBAction)changeYzm:(id)sender {
    PooCodeView * pooView=[[PooCodeView alloc]init];
    [pooView changeView];
}
#pragma mark-隐藏键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [unameText resignFirstResponder];
    [upasswordText resignFirstResponder];
    [yzmText resignFirstResponder];
}
#pragma mark-键盘上移
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self animateTextField:textField up:YES];
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self animateTextField:textField up:NO];
}
-(void)animateTextField:(UITextField *)textField up:(BOOL)up
{
    const int movementDistance = 80;
    const float movementDuration = 0.3f;
    int movement = (up?-movementDistance:movementDistance);
    [UIView beginAnimations:@"anim" context:nil];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}

@end
