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
    [self.navigationController pushViewController:[[SwichViewController alloc]init] animated:YES];
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

- (IBAction)isRememberTap:(UIButton *)sender {
    
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
-(void)checkAction
{
    if ([yzmText.text isEqualToString:yzmView.changeString]) {
        UIAlertView *alview = [[UIAlertView alloc] initWithTitle:@"ROFLOL" message:@"LOL" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alview show];
    }
    else
    {
        CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
        anim.repeatCount = 1;
        anim.values = @[@-20, @20, @-20];
        [yzmView.layer addAnimation:anim forKey:nil];
        [yzmText.layer addAnimation:anim forKey:nil];
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

@end
