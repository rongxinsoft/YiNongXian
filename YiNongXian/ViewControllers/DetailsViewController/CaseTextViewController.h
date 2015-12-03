//
//  CaseTextViewController.h
//  YiNongXian
//
//  Created by 索金铭 on 15/11/27.
//  Copyright © 2015年 bxlt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CaseTextViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *Tag_lab;

@property (weak, nonatomic) IBOutlet UILabel *No_lab;

@property (weak, nonatomic) IBOutlet UILabel *Data_lab;
@property (weak, nonatomic) IBOutlet UILabel *address_lab;
@property (weak, nonatomic) IBOutlet UILabel *product_lab;
@property (weak, nonatomic) IBOutlet UILabel *org_lab;
@property (weak, nonatomic) IBOutlet UILabel *info_lab;

@property (weak, nonatomic) IBOutlet UITextField *No_text;
@property (weak, nonatomic) IBOutlet UITextField *Time_text;
@property (weak, nonatomic) IBOutlet UITextField *address_text;
@property (weak, nonatomic) IBOutlet UITextField *product_name;
@property (weak, nonatomic) IBOutlet UITextField *Org_text;
@property (weak, nonatomic) IBOutlet UITextField *info_text;


@property (weak, nonatomic) IBOutlet UITextField *caseTime_text;
@property (weak, nonatomic) IBOutlet UITextField *caseName;
@property (weak, nonatomic) IBOutlet UITextField *caseInfo;
@property (weak, nonatomic) IBOutlet UILabel *caseTime_lab;
@property (weak, nonatomic) IBOutlet UILabel *caseName_Lab;
@property (weak, nonatomic) IBOutlet UILabel *caseInfo_lab;


@end
