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
#import "MainViewModel.h"
#import "MJRefresh.h"
#import "ViewModelClass.h"
static int RefreshCount = 2;//上拉加载基数
@interface MainViewController ()
@property (strong, nonatomic) NSMutableArray *recerveArray;//获取网络数据数组
@end

@implementation MainViewController
@synthesize recerveArray;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatNav];
    
}
-(void)viewDidAppear:(BOOL)animated
{
    
    if (self.swipeController.typeCount!=0) {
         [self freshAction];
    }
   
}
#pragma 刷新、、、加载
-(void)freshAction
{
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self headerRequest];
    }];
    // 马上进入刷新状态
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self footerRequest];
    }];
}
-(void)headerRequest
{
    MainViewModel * mainModel = [[MainViewModel alloc] init];
    [mainModel setBlockWithReturnBlock:^(id returnValue) {
        
       
        recerveArray = returnValue;
        if (recerveArray.count==0) {
            [WCAlertView showAlertWithTitle:@"结果为空" message:@"" customizationBlock:nil completionBlock:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        }
        [self.tableView.mj_header endRefreshing];
        [self.tableView reloadData];
    } WithErrorBlock:^(id errorCode) {
        [self.tableView.mj_header endRefreshing];
    } WithFailureBlock:^{
        [self.tableView.mj_header endRefreshing];
    }];
    
    [mainModel requstMainDataAndUserName:[[NSUserDefaults standardUserDefaults] objectForKey:@"USERNAME"] andAgriCategory:@"1" andrtotal:@"20" andPage:@"1" andType:self.swipeController.typeCount];
}
-(void)footerRequest
{
    MainViewModel * mainModel = [[MainViewModel alloc] init];
    [mainModel setBlockWithReturnBlock:^(id returnValue) {
      
        NSMutableArray * ary=returnValue;
        if (ary!=nil &&ary.count!=0) {
            [recerveArray addObjectsFromArray:ary];
            RefreshCount++;
        }
     
        [self.tableView.mj_footer endRefreshing];
        [self.tableView reloadData];
        
        DDLog(@"%@",recerveArray);
        
    } WithErrorBlock:^(id errorCode) {
        [self.tableView.mj_header endRefreshing];
    } WithFailureBlock:^{
        [self.tableView.mj_header endRefreshing];
    }];
    NSString * CountStr=[NSString stringWithFormat:@"%d",RefreshCount];
    [mainModel requstMainDataAndUserName:[[NSUserDefaults standardUserDefaults] objectForKey:@"USERNAME"] andAgriCategory:@"1" andrtotal:@"20" andPage:CountStr andType:self.swipeController.typeCount];
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
#pragma mark-table
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (recerveArray.count%2==0&&recerveArray.count!=0)
    {
        return recerveArray.count/2;
    }else if (recerveArray.count==0)
    {
        return 0;
    }else
    {
        return recerveArray.count/2+1;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    tableView.separatorStyle=UITableViewCellSelectionStyleNone;
    static NSString *CellIdentifier = @"MainTableViewCell";
    MainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MainTableViewCell" owner:self options:nil] lastObject];
    }
    if (recerveArray!=nil&&recerveArray.count!=0)
    {
        
        [cell setValueWithDic:recerveArray [2*indexPath.row] andRightValue:recerveArray [2*indexPath.row+1]];
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
