//
//  MainViewController.m
//  YiNongXian
//
//  Created by 索金铭 on 15/11/12.
//  Copyright © 2015年 bxlt. All rights reserved.
//

#import "MainViewController.h"
#import "UIViewController+RNSwipeViewController.h"
#import "RNSwipeViewController.h"
#import "ListSearchTableViewController.h"
#import "TaskpoolsTableViewController.h"
#import "LeftMenuViewController.h"
#import "MainTableViewCell.h"
@interface MainViewController ()


@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
   
//    TaskpoolsTableViewController *  taskpoolsVC=[[TaskpoolsTableViewController alloc]init];
//    taskpoolsVC.view.frame=self.view.frame;
//    [self addChildViewController:taskpoolsVC];
//    ListSearchTableViewController* listVC=[[ListSearchTableViewController alloc]init];
//     listVC.view.frame=self.view.frame;
//    [self addChildViewController:listVC];
//    self.currentVC=taskpoolsVC;
//    [self.view addSubview:taskpoolsVC.view];
    [self creatNav];
    
}
#pragma mark-nav
-(void)creatNav
{
    
    self.swipeController.navigationController.navigationBar.hidden=NO;
    self.swipeController.navigationItem.title=@"首页";
    UIImage* backImage = [UIImage imageNamed:@"leftButoom@2x.png"];
    CGRect backframe = CGRectMake(0,0,25,25);
    UIButton* backButton= [[UIButton alloc] initWithFrame:backframe];
    [backButton setBackgroundImage:backImage forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(leftShow) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem * leftBar=[[UIBarButtonItem alloc]initWithCustomView:backButton];
    self.swipeController.navigationItem.leftBarButtonItem = leftBar;
}
-(void)leftShow
{
    if (self.swipeController.visibleState == RNSwipeVisibleLeft)
    {
       
        [self.swipeController resetView];
        
    }else
    {
        if (! self.swipeController) {
            NSLog(@"swipe controller not found");
        }
        [self.swipeController showLeft];
    }
    
    
  
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    tableView.separatorStyle=UITableViewCellSelectionStyleNone;
    static NSString *CellIdentifier = @"MainTableViewCell";
    MainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MainTableViewCell" owner:self options:nil] objectAtIndex:0];
    }
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 230;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath

{
    
}


@end
