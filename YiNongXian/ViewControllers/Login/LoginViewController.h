//
//  LoginViewController.h
//  YiNongXian
//
//  Created by 索金铭 on 15/11/12.
//  Copyright © 2015年 bxlt. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PooCodeView;
@interface LoginViewController : UIViewController<UITextFieldDelegate>
- (IBAction)login:(id)sender;
- (IBAction)changeYzm:(id)sender;
@property (weak, nonatomic) IBOutlet PooCodeView *yzmView;
@property (weak, nonatomic) IBOutlet UITextField *unameText;//用户名
@property (weak, nonatomic) IBOutlet UITextField *upasswordText;//密码
@property (weak, nonatomic) IBOutlet UITextField *yzmText;//验证码

@end
