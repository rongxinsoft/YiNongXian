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
#import "LeftMenuViewController.h"
#import "MainTableViewCell.h"
#import "MainViewModel.h"
#import "MJRefresh.h"
#import "ViewModelClass.h"
#import "SearchViewModel.h"
#import "EntrustViewModel.h"
#import "SXDatabase.h"
static int RefreshCount = 2;//上拉加载基数
@interface MainViewController ()
@property (strong, nonatomic) NSMutableArray *recerveArray;//获取网络数据数组
@end

@implementation MainViewController
@synthesize recerveArray,searchView;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatNav];
    [self freshAction];
    self.swipeController.AgriCategoryType=1;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(beginRefreshing) name:@"STARTREQUEST" object:nil];
    
}
#pragma 刷新、、、加载
-(void)freshAction
{
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            recerveArray=nil;
        [self.tableView reloadData];
        [self headerRequest];
    }];
    // 马上进入刷新状态
   // [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self footerRequest];
    }];
}
-(void)beginRefreshing
{
    if (self.swipeController.typeCount==102) {
        recerveArray=nil;
        [self.tableView reloadData];
    }else
    {
    // 马上进入刷新状态
     [self.tableView.mj_header beginRefreshing];
    }
}
-(void)headerRequest
{
    MainViewModel * mainModel = [[MainViewModel alloc] init];
    [mainModel setBlockWithReturnBlock:^(id returnValue)
    {
        if ([returnValue isKindOfClass:[NSArray class]] ) {
            recerveArray=returnValue;
            [self.tableView.mj_header endRefreshing];
            [self.tableView reloadData];
        }else
        {
            [WCAlertView showAlertWithTitle:returnValue message:returnValue customizationBlock:nil completionBlock:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [self.tableView.mj_header endRefreshing];
        }
      
    } WithErrorBlock:^(id errorCode) {
        [self.tableView.mj_header endRefreshing];
    } WithFailureBlock:^{
        [self.tableView.mj_header endRefreshing];
    }];
    NSString *AgriCategoryType=[NSString stringWithFormat:@"%i",self.swipeController.AgriCategoryType];
    [mainModel requstMainDataAndUserName:USERNAME andAgriCategory:AgriCategoryType andrtotal:@"20" andPage:@"1" andType:self.swipeController.typeCount];
}
-(void)footerRequest
{
    MainViewModel * mainModel = [[MainViewModel alloc] init];
    [mainModel setBlockWithReturnBlock:^(id returnValue) {
      
        
        if ([returnValue isKindOfClass:[NSArray class]] ) {
            NSMutableArray * ary=returnValue;
            if (ary!=nil &&ary.count!=0) {
                [recerveArray addObjectsFromArray:ary];
                RefreshCount++;
            }
            [self.tableView.mj_footer endRefreshing];
            [self.tableView reloadData];
        }else
        {
            [WCAlertView showAlertWithTitle:returnValue message:returnValue customizationBlock:nil completionBlock:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [self.tableView.mj_footer endRefreshing];
        }
        
    } WithErrorBlock:^(id errorCode) {
        [self.tableView.mj_header endRefreshing];
    } WithFailureBlock:^{
        [self.tableView.mj_header endRefreshing];
    }];
    NSString * CountStr=[NSString stringWithFormat:@"%d",RefreshCount];
    NSString *AgriCategoryType=[NSString stringWithFormat:@"%i",self.swipeController.AgriCategoryType];
    [mainModel requstMainDataAndUserName:USERNAME andAgriCategory:AgriCategoryType andrtotal:@"20" andPage:CountStr andType:self.swipeController.typeCount];
}
#pragma mark-nav
-(void)creatNav
{
     self.automaticallyAdjustsScrollViewInsets=NO;
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
#pragma mark-table delegate
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
        if (recerveArray.count%2==0)
        {
            [cell setValueWithDic:recerveArray [2*indexPath.row] andRightValue:recerveArray [2*indexPath.row+1]];
        }else
        {
            if (indexPath.row==recerveArray.count/2) {
                cell.rightView.hidden=YES;
                [cell setValueWithDic:recerveArray [2*indexPath.row] andRightValue:nil];
            }
            else
            {
                [cell setValueWithDic:recerveArray [2*indexPath.row] andRightValue:recerveArray [2*indexPath.row+1]];
            }
        }
        if (self.swipeController.typeCount==101) {
            cell.L_entrustBtn.hidden=YES;
            cell.R_entrustBtn.hidden=YES;
        }
        //委托按钮
        [cell.L_entrustBtn addTarget:self
                              action:@selector(entrustTap:) forControlEvents:UIControlEventTouchUpInside];
        cell.L_entrustBtn.tag=2*indexPath.row;
        [cell.R_entrustBtn addTarget:self action:@selector(entrustTap:) forControlEvents:UIControlEventTouchUpInside];
        cell.R_entrustBtn.tag=2*indexPath.row+1;
        
        
        
        //认领按钮
        [cell.L_entrust addTarget:self action:@selector(recerveTap:) forControlEvents:UIControlEventTouchUpInside];
        cell.L_entrust.tag=2*indexPath.row;
        [cell.R_entrust addTarget:self action:@selector(recerveTap:) forControlEvents:UIControlEventTouchUpInside];
        cell.R_entrust.tag=2*indexPath.row+1;
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 230;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (self.swipeController.typeCount==102) {
        searchView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, DeviceWidth-80, 50)];
        self.searchText=[[UITextField alloc]initWithFrame:CGRectMake(0, 0, 500, 50)];
        self.searchText.placeholder=@"请输入搜索的ID";
        self.searchText.backgroundColor=AppLineColor;
        UIButton * searchBtn=[[UIButton alloc]initWithFrame:CGRectMake(self.searchText.frame.size.width, 0, 50, 50)];
        searchBtn.backgroundColor=AppLineColor;
        [searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
        [searchBtn addTarget:self action:@selector(searchTap) forControlEvents:UIControlEventTouchUpInside];
        [searchView addSubview:searchBtn];
        [searchView addSubview:self.searchText];
        return searchView;
    }else
    {
        [searchView removeFromSuperview];
        return nil;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.swipeController.typeCount==102) {
        return 50;
    }
    return 0;
}
#pragma mark-委托点击方法
-(void)entrustTap:(UIButton*)sender
{
    [WCAlertView showAlertWithTitle:@"保单委托" message:@"请输入要委托的用户名" customizationBlock:^(WCAlertView *alertView)
     {
         alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
     } completionBlock:^(NSUInteger buttonIndex, WCAlertView *alertView)
    {
        if (buttonIndex==alertView.cancelButtonIndex) {
        }else
        {
              MainModel * mainModel=recerveArray[sender.tag];
            //得到输入框
            UITextField *tf=[alertView textFieldAtIndex:0];
            EntrustViewModel * entrustModel = [[EntrustViewModel alloc] init];
            [entrustModel setBlockWithReturnBlock:^(id returnValue) {
                [SVProgressHUD dismiss];
                if (returnValue==nil) {
                      [WCAlertView showAlertWithTitle:@"委托成功" message:nil customizationBlock:nil completionBlock:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                }else
                {
                     [WCAlertView showAlertWithTitle:returnValue message:nil customizationBlock:nil completionBlock:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                }
            } WithErrorBlock:^(id errorCode) {
                [SVProgressHUD dismiss];
            } WithFailureBlock:^{
                [SVProgressHUD dismiss];
            }];
            [entrustModel entrustRequestAnddelegateId:mainModel.policyId andDelegatePerson:USERNAME andBeDelegatedPerson:tf.text];
            [SVProgressHUD showWithStatus:@"请稍后……" maskType:SVProgressHUDMaskTypeBlack];
        }
     } cancelButtonTitle:@"取消" otherButtonTitles:@"委托", nil];
}


#pragma 搜索方法
-(void)searchTap
{
    if ([self.searchText.text isEqualToString:@""]) {
        [WCAlertView showAlertWithTitle:@"搜索内容不可为空" message:nil customizationBlock:nil completionBlock:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    }
  
        SearchViewModel * searchModel = [[SearchViewModel alloc] init];
        [searchModel setBlockWithReturnBlock:^(id returnValue) {
            [SVProgressHUD dismiss];
           if (![returnValue isKindOfClass:[NSArray class]]||[returnValue isKindOfClass:[NSNull class]]) {
                [WCAlertView showAlertWithTitle:@"未查询到相应结果" message:returnValue customizationBlock:nil completionBlock:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            }else
                {
            recerveArray = returnValue;
            [self.tableView reloadData];
                }
        
        } WithErrorBlock:^(id errorCode) {
            [SVProgressHUD dismiss];
        } WithFailureBlock:^{
            [SVProgressHUD dismiss];
        }];
        NSString *AgriCategoryType=[NSString stringWithFormat:@"%i",self.swipeController.AgriCategoryType];
        [searchModel requestSearchAndsearchId:self.searchText.text andUserName:USERNAME andRtotal:@"1" andAgriCategory:AgriCategoryType];
    [SVProgressHUD showWithStatus:@"正在搜索……" maskType:SVProgressHUDMaskTypeBlack];
    
}
#pragma mark-认领
-(void)recerveTap:(UIButton *)sender
{
    MainModel * mainModel=recerveArray[sender.tag];
    int a=[SXDatabase checkPLYID:mainModel.policyId];
    switch (a) {
        case 0:
            //下载图班  申请枷锁  存表
            break;
        case 1:
            //该保单已在待采集列表中 不可认领
            break;
        case 2:
            //该保单已在上报中 不可认领
            break;
        case 3:
            //已上报  更新与这条数据相关的图班数据   申请枷锁 数据存入表
            
            break;
        default:
            break;
    }
}
#pragma mark-隐藏键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.searchText resignFirstResponder];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
