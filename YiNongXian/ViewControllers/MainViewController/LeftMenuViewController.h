//
//  LeftMenuViewController.h
//  YiNongXian
//
//  Created by 索金铭 on 15/11/13.
//  Copyright © 2015年 bxlt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeftMenuViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *plantingView;
@property (weak, nonatomic) IBOutlet UIButton *plantTap;
- (IBAction)plantAction:(id)sender;


@property (weak, nonatomic) IBOutlet UIView *farmView;
@property (weak, nonatomic) IBOutlet UIButton *farmTap;
- (IBAction)farmAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *forestryView;
@property (weak, nonatomic) IBOutlet UIButton *forestryTap;
- (IBAction)forestryAction:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end
