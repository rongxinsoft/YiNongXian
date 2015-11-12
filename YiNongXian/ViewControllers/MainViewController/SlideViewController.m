//
//  SlideViewController.m
//  YiNongXian
//
//  Created by 索金铭 on 15/11/12.
//  Copyright © 2015年 bxlt. All rights reserved.
//

#import "SlideViewController.h"

@interface SlideViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, retain) UITableView* menuTableView;
@end

@implementation SlideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 列表
    self.menuTableView = [[UITableView alloc] initWithFrame:self.contentView.bounds];
    [self.menuTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.menuTableView.backgroundColor = [UIColor redColor];
    self.menuTableView.delegate = self;
    self.menuTableView.dataSource = self;
    [self.contentView addSubview:self.menuTableView];
    // Do any additional setup after loading the view.
}

#pragma mark - TableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *sidebarMenuCellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:sidebarMenuCellIdentifier];
    if(!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:sidebarMenuCellIdentifier] ;
        cell.backgroundColor = [UIColor clearColor];
        
    }
    
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.text = [NSString stringWithFormat:@"菜单%ld", indexPath.row];
    
    return cell;
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
