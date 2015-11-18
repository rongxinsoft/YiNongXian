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
    [self.yzmView changeView];
    // Do any additional setup after loading the view from its nib.
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
    int a=[self loginValidation];
    if (a==1) {
        LoginViewModel *publicViewModel = [[LoginViewModel alloc] init];
        [publicViewModel setBlockWithReturnBlock:^(id returnValue)
         {
             [SVProgressHUD dismiss];
             [self.navigationController pushViewController:[[SwichViewController alloc]init] animated:YES];
             //        [self.tableView reloadData];
             //        DDLog(@"%@",_publicModelArray);
             
         } WithErrorBlock:^(id errorCode) {
             
             [SVProgressHUD dismiss];
         } WithFailureBlock:^{
             [SVProgressHUD dismiss];
             

         }];
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
//        self.getCodeOutlet.enabled=NO;
//        self.getCodeOutlet.backgroundColor = [UIColor lightGrayColor];
        isTap = YES;
    }else{
        [ self.isAgreeImage setImage:[UIImage imageNamed:@"no"]  forState:UIControlStateNormal];
//        self.getCodeOutlet.enabled=YES;
//        self.getCodeOutlet.backgroundColor = MAINCOLOR;
        isTap = NO;
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
    BOOL a=[self checkAction];
    if ([unameText.text isEqualToString:@""]||unameText.text==nil) {
        [WCAlertView showAlertWithTitle:@"帐号不可为空" message:@"请输入" customizationBlock:nil completionBlock:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
      
    }else if ([upasswordText.text isEqualToString:@""]||upasswordText.text==nil)
    {
        [WCAlertView showAlertWithTitle:@"密码不可为空" message:@"请输入" customizationBlock:nil completionBlock:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
      
    }else if (a==NO)
    {
        [WCAlertView showAlertWithTitle:@"验证码错误" message:@"请重新输入" customizationBlock:nil completionBlock:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
    }else
    {
        return 1;
    }
    return 0;
}
@end
