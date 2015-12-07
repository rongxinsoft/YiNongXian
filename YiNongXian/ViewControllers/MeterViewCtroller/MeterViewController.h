//
//  MeterViewController.h
//  YiNongXian
//
//  Created by 索金铭 on 15/12/4.
//  Copyright © 2015年 bxlt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MeterViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *MenuTableView;
- (IBAction)searchTap:(id)sender;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UIButton *searchBtn;
@property (weak, nonatomic) IBOutlet UIView *bagView;
- (IBAction)moveTap:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIImageView *centerImh;

@end
