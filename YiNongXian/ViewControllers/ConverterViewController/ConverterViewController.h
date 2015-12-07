//
//  ConverterViewController.h
//  YiNongXian
//
//  Created by 索金铭 on 15/12/6.
//  Copyright © 2015年 bxlt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConverterViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *firstText;
@property (weak, nonatomic) IBOutlet UITextField *SecondText;
@property (weak, nonatomic) IBOutlet UIButton *firstTap;
- (IBAction)firstAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *secondTap;
- (IBAction)secondAction:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *firstTable;
@property (weak, nonatomic) IBOutlet UITableView *secondTable;

@end
