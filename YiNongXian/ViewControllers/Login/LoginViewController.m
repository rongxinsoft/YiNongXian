//
//  LoginViewController.m
//  YiNongXian
//
//  Created by 索金铭 on 15/11/12.
//  Copyright © 2015年 bxlt. All rights reserved.
//

#import "LoginViewController.h"
#import "SwichViewController.h"
#import "PooCodeView.h"
#import "SetingViewController.h"
#import "LoginViewModel.h"

@interface LoginViewController ()

@end
BOOL isTap;
@implementation LoginViewController
@synthesize unameText,upasswordText,yzmText,yzmView;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self remPassword];
    [self.yzmView changeView];
}
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden=YES;
    self.navigationItem.title=@"登 录";
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark-登录方法/换二维码图片
- (IBAction)login:(id)sender {
      NSUserDefaults * userDefalts=[NSUserDefaults standardUserDefaults];
    int a=[self loginValidation];
    if (a==1) {
        LoginViewModel *publicViewModel = [[LoginViewModel alloc] init];
        [publicViewModel setBlockWithReturnBlock:^(id returnValue)
         {
             [SVProgressHUD dismiss];
             if (returnValue==nil) {
                 [userDefalts setObject:unameText.text forKey:@"USERNAME"];
                 [userDefalts setObject:upasswordText.text forKey:@"PASSWORD"];
                 [self.navigationController pushViewController:[[SwichViewController alloc]init] animated:YES];
             
             } else
             {
                 [WCAlertView showAlertWithTitle:returnValue message:@"请重新输入" customizationBlock:nil completionBlock:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
             }
         } WithErrorBlock:^(id errorCode) {
             [SVProgressHUD dismiss];
         } WithFailureBlock:^(int failertrValue)
        {
            [SVProgressHUD dismiss];
            int a=failertrValue;
            if (a==1) {
                [userDefalts setObject:unameText.text forKey:@"USERNAME"];
                [userDefalts setObject:upasswordText.text forKey:@"PASSWORD"];
            [self.navigationController pushViewController:[[SwichViewController alloc]init] animated:YES];
            }else if (a==2)
            {
                [SVProgressHUD showErrorWithStatus:@"账户密码本地验证失败,请重试"];
            } else
            {
                 [SVProgressHUD showErrorWithStatus:@"数据库无此用户,请重试"];
            }
         }];
        if (isTap==YES) {
            [userDefalts setObject:@"Y" forKey:@"HASPASSWORD"];
        }else
        {
             [userDefalts setObject:@"N" forKey:@"HASPASSWORD"];
        }
        
        [publicViewModel loginRequstAndUname:unameText.text andPassword:upasswordText.text];
        [SVProgressHUD showWithStatus:@"正在登录……" maskType:SVProgressHUDMaskTypeBlack];
    }
}

- (IBAction)changeYzm:(id)sender {
    [self.yzmView changeView];
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
#pragma mark-设置按钮 ／记住密码按钮

- (IBAction)setTap:(id)sender
{
    SetingViewController * setVc=[[SetingViewController alloc]init];
    [self.navigationController pushViewController:setVc  animated:YES];
}
- (IBAction)isRememberTap:(UIButton *)sender
{
    
    if (isTap == NO) {
        [ self.isAgreeImage setImage:[UIImage imageNamed:@"ok"]  forState:UIControlStateNormal];
        isTap = YES;
    }else{
        [ self.isAgreeImage setImage:[UIImage imageNamed:@"no"]  forState:UIControlStateNormal];
        isTap = NO;
    }
}
-(void)remPassword
{
    NSString * userName=[[NSUserDefaults standardUserDefaults]objectForKey:@"USERNAME"];
        unameText.text=userName;
       NSString * passWord=[[NSUserDefaults standardUserDefaults]objectForKey:@"PASSWORD"];
        NSString * ISRemb=[[NSUserDefaults standardUserDefaults]objectForKey:@"HASPASSWORD"];
        if ([ISRemb isEqualToString: @"Y"]) {
             [ self.isAgreeImage setImage:[UIImage imageNamed:@"ok"]  forState:UIControlStateNormal];
            upasswordText.text=passWord;
            isTap=YES;
        }else
        {
             [ self.isAgreeImage setImage:[UIImage imageNamed:@"no"]  forState:UIControlStateNormal];
            upasswordText.text=@"";
            isTap=NO;
        }
}
#pragma mark-验证码检查／验证码只允许4位
-(BOOL )checkAction
{
    if ([yzmText.text isEqualToString:yzmView.changeString]) {
        return YES;
    }
    else
    {
        [self.yzmView changeView];
        return NO;
    }
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{
    if (yzmText ==textField) {
        NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        if (yzmText)
        {
            if ([toBeString length] > 4) {
                yzmText.text = [toBeString substringToIndex:4];
                return NO;
            }
        }
    }
    return YES;
}
-(int)loginValidation
{
    return 1;//开发阶段 不用验证
    
    
    BOOL a=[self checkAction];
    if ([unameText.text isEqualToString:@""]||unameText.text==nil) {
        [SVProgressHUD showInfoWithStatus:@"帐号不可为空,请输入"];
    }else if ([upasswordText.text isEqualToString:@""]||upasswordText.text==nil)
    {
        [SVProgressHUD showInfoWithStatus:@"密码不可为空,请输入"];
    }else if (a==NO)
    {
        [SVProgressHUD showInfoWithStatus:@"验证码错误,请重新输入"];
    }else
    {
        return 1;
    }
    return 0;
}
@end
