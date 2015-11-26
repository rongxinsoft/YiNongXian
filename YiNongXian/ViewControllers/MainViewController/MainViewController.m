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
#import "surveyTableViewCell.h"
#import "MainViewModel.h"
#import "MJRefresh.h"
#import "ViewModelClass.h"
#import "SearchViewModel.h"
#import "EntrustViewModel.h"
#import "SXDatabase.h"
#import "DownloadShapeViewModel.h"
#import "LockViewModel.h"


static int RefreshCount = 2;//上拉加载基数
@interface MainViewController ()
@property (strong, nonatomic) NSMutableArray *recerveArray;//获取网络数据数组
@end

@implementation MainViewController
@synthesize recerveArray,shapeAry;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatNav];
    [self freshAction];
    self.swipeController.AgriCategoryType=1;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(StartRefresh) name:@"STARTREQUEST" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(taskAction) name:@"SELECTSQLITE" object:nil];
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
    self.tableView.mj_footer.automaticallyHidden=YES;
    self.tableView.mj_footer=[MJRefreshAutoFooter footerWithRefreshingBlock:^{
        [self footerRequest];
    }];
}
-(void)StartRefresh
{
    
    if (self.swipeController.typeCount==102||self.swipeController.typeCount==201) {
        recerveArray=nil;
        [self.tableView reloadData];
    }else
    {
        recerveArray=nil;
        [self.tableView reloadData];
        
    // 马上进入刷新状态
     [self.tableView.mj_header beginRefreshing];
    }
    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:0];
    [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
}
-(void)headerRequest
{
    if (self.swipeController.typeCount==102||self.swipeController.typeCount==201) {
        recerveArray=nil;
        [self.tableView.mj_header setHidden:YES];
        [self.tableView.mj_footer setHidden:YES];
        return;
    }
    [self.tableView.mj_header setHidden:NO];
    [self.tableView.mj_footer setHidden:NO];
    [self.tableView.mj_footer endRefreshing];
    
    MainViewModel * mainModel = [[MainViewModel alloc] init];
    [mainModel setBlockWithReturnBlock:^(id returnValue)
    {
        if ([returnValue isKindOfClass:[NSArray class]] ) {
            recerveArray=returnValue;
            [self.tableView.mj_header endRefreshing];
            [self.tableView reloadData];
        }else
        {
            [SVProgressHUD showInfoWithStatus:returnValue];
            [self.tableView.mj_header endRefreshing];
             [self.tableView reloadData];
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
    
    if (self.swipeController.typeCount==103||self.swipeController.typeCount==104) {
        [self.tableView.mj_footer endRefreshing];
        return;
    }
    MainViewModel * mainModel = [[MainViewModel alloc] init];
    [mainModel setBlockWithReturnBlock:^(id returnValue) {
        if ([returnValue isKindOfClass:[NSArray class]] ) {
            NSMutableArray * ary=returnValue;
            if (ary!=nil &&ary.count!=0) {
                [recerveArray addObjectsFromArray:ary];
                RefreshCount++;
            }
            else
            {
                [SVProgressHUD showInfoWithStatus:@"没有数据可加载了"];
            }
            [self.tableView.mj_footer endRefreshing];
            [self.tableView reloadData];
        }else
        {
            [SVProgressHUD showInfoWithStatus:returnValue];
            [self.tableView.mj_footer endRefreshing];
        }
        
    } WithErrorBlock:^(id errorCode) {
        [self.tableView.mj_footer endRefreshing];
    } WithFailureBlock:^{
        [self.tableView.mj_footer endRefreshing];
    }];
    NSString * CountStr=[NSString stringWithFormat:@"%d",RefreshCount];
    NSString *AgriCategoryType=[NSString stringWithFormat:@"%i",self.swipeController.AgriCategoryType];
    [mainModel requstMainDataAndUserName:USERNAME andAgriCategory:AgriCategoryType andrtotal:@"20" andPage:CountStr andType:self.swipeController.typeCount];
}
#pragma mark- 待采集数据库本地任务
-(void)taskAction
{
    [self.tableView.mj_header setHidden:YES];
    [self.tableView.mj_footer setHidden:YES];
    
    if (self.swipeController.typeCount==103 ) {
        recerveArray=[SXDatabase getWillcollect:@"1"];
        if (recerveArray.count==0||recerveArray==nil) {
            [SVProgressHUD showInfoWithStatus:@"无数据"];
        }
    }else
    {
        recerveArray=[SXDatabase getWillcollect:@"2"];
        if (recerveArray.count==0||recerveArray==nil) {
            [SVProgressHUD showInfoWithStatus:@"无数据"];
        }
    }
    [self.tableView reloadData];
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
    if (self.swipeController.typeCount>=200) {
        tableView.separatorStyle=UITableViewCellSelectionStyleNone;
        static NSString *CellIdentifier = @"surveyTableViewCell";
        surveyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil)
        {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"surveyTableViewCell" owner:self options:nil] lastObject];
        }
        if (recerveArray!=nil&&recerveArray.count!=0)
        {
            if (recerveArray.count%2==0)
            {
                [cell setcaseValueWithDic:recerveArray [2*indexPath.row] andRightValue:recerveArray [2*indexPath.row+1] andTypeCount:self.swipeController.typeCount];
            }else
            {
                if (indexPath.row==recerveArray.count/2) {
                    cell.rightView.hidden=YES;
                    [cell setcaseValueWithDic:recerveArray [2*indexPath.row] andRightValue:nil andTypeCount:self.swipeController.typeCount];
                }
                else
                {
                    [cell setcaseValueWithDic:recerveArray [2*indexPath.row] andRightValue:recerveArray [2*indexPath.row+1]     andTypeCount:self.swipeController.typeCount];
                }
                
            }
            [cell setBtn:self.swipeController.typeCount];
            //委托按钮
            [cell.L_entrustBtn addTarget:self
                                  action:@selector(entrustTap:) forControlEvents:UIControlEventTouchUpInside];
            cell.L_entrustBtn.tag=2*indexPath.row;
            [cell.R_entrustBtn addTarget:self action:@selector(entrustTap:) forControlEvents:UIControlEventTouchUpInside];
            cell.R_entrustBtn.tag=2*indexPath.row+1;
            if (self.swipeController.typeCount==200) {
                cell.L_entrustBtn.hidden=YES;
                cell.R_entrustBtn.hidden=YES;
            }
         
            //认领按钮
            [cell.L_entrust addTarget:self action:@selector(recerveTap:) forControlEvents:UIControlEventTouchUpInside];
            [cell.L_entrust setTitle:@"认领案件" forState: UIControlStateNormal];
            cell.L_entrust.tag=2*indexPath.row;
            [cell.R_entrust addTarget:self action:@selector(recerveTap:) forControlEvents:UIControlEventTouchUpInside];
            [cell.R_entrust setTitle:@"认领案件" forState: UIControlStateNormal];
            cell.R_entrust.tag=2*indexPath.row+1;
        }
        return cell;
    }else{
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
                [cell setValueWithDic:recerveArray [2*indexPath.row] andRightValue:recerveArray [2*indexPath.row+1] andTypeCount:self.swipeController.typeCount];
            }else
            {
                if (indexPath.row==recerveArray.count/2) {
                    cell.rightView.hidden=YES;
                    [cell setValueWithDic:recerveArray [2*indexPath.row] andRightValue:nil andTypeCount:self.swipeController.typeCount];
                }
                else
                {
                    [cell setValueWithDic:recerveArray [2*indexPath.row] andRightValue:recerveArray [2*indexPath.row+1]     andTypeCount:self.swipeController.typeCount];
                }
                
            }
            [cell setBtn:self.swipeController.typeCount];
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
  
   
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.swipeController.typeCount>=200) {
        return 250;
    }
    return 230;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
        UIView *   ssearchView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, DeviceWidth-80, 50)];
        ssearchView.layer.masksToBounds = YES;
        ssearchView.layer.cornerRadius = 6.0;
        ssearchView.layer.borderWidth = 1.0;
        ssearchView.layer.borderColor = AppLineColor.CGColor;
       self.searchText=[[UITextField alloc]initWithFrame:CGRectMake(0, 0, 500, 50)];
        self.searchText.placeholder=@"请输入搜索的ID";
        self.searchText.backgroundColor=[UIColor whiteColor];
        UIButton * searchBtn=[[UIButton alloc]initWithFrame:CGRectMake(DeviceWidth-50, 0, 50, 50)];
    
        [searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
        [searchBtn setBackgroundColor:AppLineColor];
        [searchBtn addTarget:self action:@selector(searchTap) forControlEvents:UIControlEventTouchUpInside];
        [ssearchView addSubview:searchBtn];
        [ssearchView addSubview:self.searchText];
        return ssearchView;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.swipeController.typeCount==102||self.swipeController.typeCount==201) {
        return 50;
    }
    return 0;
}
#pragma mark-委托点击方法
-(void)entrustTap:(UIButton*)sender
{
    if (self.swipeController.typeCount==100||self.swipeController.typeCount==201)
    {
        [self entrust:sender.tag];
    }
    if (self.swipeController.typeCount==103)
    {
        [self lockAction:sender.tag andStatus:@"0"];
    }
    
}
-(void)entrust:(long)sender
{
    [WCAlertView showAlertWithTitle:@"委托" message:@"请输入要委托的用户名" customizationBlock:^(WCAlertView *alertView)
     {
         alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
     } completionBlock:^(NSUInteger buttonIndex, WCAlertView *alertView)
     {
         if (buttonIndex==alertView.cancelButtonIndex) {
         }else
         {
             //得到输入框
             UITextField *tf=[alertView textFieldAtIndex:0];
             EntrustViewModel * entrustModel = [[EntrustViewModel alloc] init];
             [entrustModel setBlockWithReturnBlock:^(id returnValue) {
                 [SVProgressHUD dismiss];
                 if (returnValue==nil) {
                     [SVProgressHUD showSuccessWithStatus:@"委托成功"];
                 }else
                 {
                     [SVProgressHUD showInfoWithStatus:returnValue];
                 }
             } WithErrorBlock:^(id errorCode) {
                 [SVProgressHUD dismiss];
             } WithFailureBlock:^{
                 [SVProgressHUD dismiss];
             }];
             if (self.swipeController.typeCount==201) {
                 caseModel * mainModel=recerveArray[sender];
                 [entrustModel entrustRequestAnddelegateId:mainModel.accidentId andDelegatePerson:USERNAME andBeDelegatedPerson:tf.text andType:self.swipeController.typeCount];

             }else
             {
                 MainModel * mainModel=recerveArray[sender];
                 [entrustModel entrustRequestAnddelegateId:mainModel.policyId andDelegatePerson:USERNAME andBeDelegatedPerson:tf.text andType:self.swipeController.typeCount];
             }
            [SVProgressHUD showWithStatus:@"请稍后……" maskType:SVProgressHUDMaskTypeBlack];
         }
     } cancelButtonTitle:@"取消" otherButtonTitles:@"委托", nil];

}
#pragma 搜索方法
-(void)searchTap
{
    if ([self.searchText.text isEqualToString:@""]) {
        [SVProgressHUD showInfoWithStatus:@"搜索内容不可为空，请重新输入"];
        return;
    }
        SearchViewModel * searchModel = [[SearchViewModel alloc] init];
        [searchModel setBlockWithReturnBlock:^(id returnValue) {
            [SVProgressHUD dismiss];
           if (![returnValue isKindOfClass:[NSArray class]]||[returnValue isKindOfClass:[NSNull class]]) {
               [SVProgressHUD showInfoWithStatus:returnValue];
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
        [searchModel requestSearchAndsearchId:self.searchText.text andUserName:USERNAME andRtotal:@"1" andAgriCategory:AgriCategoryType andType:self.swipeController.typeCount];
        [SVProgressHUD showWithStatus:@"正在搜索……" maskType:SVProgressHUDMaskTypeBlack];
    
}
#pragma mark-认领--枷锁 删除按钮
-(void)recerveTap:(UIButton *)sender
{
    //承保注销
    MainModel * mainModel=recerveArray[sender.tag];
    if (self.swipeController.typeCount==104) {
        [SXDatabase deletePLYwithPolicyID:mainModel.policyId];
        [self taskAction];
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"reloadTabelData" object:self];
        return;
    }
    //认领
        int a=[SXDatabase checkPLYID:mainModel.policyId];
        switch (a) {
            case 0://下载图班  申请枷锁  存表
        {DownloadShapeViewModel * shapeVM= [[DownloadShapeViewModel alloc]init];
        [shapeVM setBlockWithReturnBlock:^(id returnValue)
        {
        if ([returnValue isKindOfClass:[NSArray class]]&&returnValue
                     !=nil){shapeAry=returnValue;
            [self lockAction:sender.tag andStatus:@"1"];
            }
        else
            { [SVProgressHUD showInfoWithStatus:returnValue];}
             } WithErrorBlock:^(id errorCode) {
             } WithFailureBlock:^{
             }];
            [shapeVM requestShopeAndPly_Id:mainModel.policyId];}
            break;
        case 1:
            [SVProgressHUD showInfoWithStatus:@"该保单已在待采集列表中 不可认领"];
            break;
        case 2: //已上报  更新与这条数据相关的图班数据   申请枷锁 数据存入表
            [SVProgressHUD showInfoWithStatus:@"该保单已完成 不可认领"];
            break;
        case 3:
            break;
        default:
            break;
    }
}
-(void)lockAction:(long)bussinessId andStatus:(NSString *)statusStr
{
    NSString * statueShow;
    if ([statusStr isEqualToString:@"1"]) {
        statueShow=@"认领成功";
    }else if ([statusStr isEqualToString:@"0"])
    {
        statueShow=@"注销成功";
    }
    LockViewModel * lockVM=[[LockViewModel alloc]init];
    MainModel * mainModel=recerveArray[bussinessId];
    [lockVM setBlockWithReturnBlock:^(id returnValue)
     {
         if (returnValue==nil) {
            
             [SXDatabase insertIntoTPLYTableWithPolicyId:mainModel.policyId andProposalNo:mainModel.proposalNo andProposalDate:mainModel.proposalDate andOrgCode:mainModel.orgCode andArea:mainModel.area andProductName:mainModel.productName andOrgName:mainModel.orgName andComminfo:mainModel.commInfo andAgriCategory:mainModel.agriCategory andStatus:statusStr andDelegatePerson:mainModel.delegatePerson];
             [SXDatabase insertIntoTShapeTableWithTID:shapeAry];
             [SVProgressHUD showSuccessWithStatus:statueShow];
             if ([statusStr isEqualToString:@"1"]) {
                 [self StartRefresh];
             }else if ([statusStr isEqualToString:@"0"])
             {
                 [self taskAction];
             }
             
             [[NSNotificationCenter defaultCenter]
              postNotificationName:@"reloadTabelData" object:self];
             
         }else
         {
             [SVProgressHUD showInfoWithStatus:returnValue];
         }
     } WithErrorBlock:^(id errorCode) {
     } WithFailureBlock:^{
     }];
    if ([mainModel.delegatePerson isEqualToString:@"(null)"]) {
        [lockVM LockRequestAndLockType:@"1" andbussinessId:mainModel.policyId andstatus:statusStr andDescription:nil andType:self.swipeController.typeCount];
    }else
    {
        [lockVM LockRequestAndLockType:@"1" andbussinessId:mainModel.policyId andstatus:statusStr andDescription:mainModel.delegatePerson andType:self.swipeController.typeCount];
    }
    
}
#pragma mark-隐藏键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.searchText resignFirstResponder];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
