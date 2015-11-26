//
//  LeftMenuViewController.m
//  YiNongXian
//
//  Created by 索金铭 on 15/11/13.
//  Copyright © 2015年 bxlt. All rights reserved.
//

#import "LeftMenuViewController.h"
#import "RepordViewController.h"
#import "LeftTableViewCell.h"
#import "UIViewController+RNSwipeViewController.h"
#import "RNSwipeViewController.h"
#import "MainViewController.h"
#import "MJRefresh.h"
#import "SXDatabase.h"
@interface LeftMenuViewController ()

@property(strong,nonatomic)UIViewController * currentVC;
@end

@implementation LeftMenuViewController
- (void)viewDidLoad {
    [super viewDidLoad];
   
   [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadTabelData) name:@"reloadTabelData" object:nil];
}
#pragma mark-nav

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark-tableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 5;
            break;
        case 2:
            return 4;
            break;
        case 3:
            return 4;
            break;
        default:
            break;
    }
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"LeftTableViewCell";
    LeftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"LeftTableViewCell" owner:self options:nil] objectAtIndex:0];
    }
    switch (indexPath.section) {
        case 0:
        {
            cell.celltitle.text=@"上报中心(0)";
        }
            break;
        case 1:{
            NSArray * arys=[SXDatabase getWillcollect:@"1"];
            NSString * willCollet=[NSString stringWithFormat:@"待采集任务(%lu)",(unsigned long)arys.count];
            NSArray * didAry=[SXDatabase getWillcollect:@"2"];
            NSString * didCollet=[NSString stringWithFormat:@"已上报任务(%lu)",(unsigned long)didAry.count];
            NSArray * ary=@[@"任务池查询",@"委托任务池查询",@"投保单查询",willCollet,didCollet];
            cell.celltitle.text=ary[indexPath.row];
        }
             break;
        case 2:{
            NSArray * ary1=@[@"委托任务池查询",@"案件查询",@"处理中(0)",@"已完成(0)"];
            cell.celltitle.text=ary1[indexPath.row];
        }
             break;
        case 3:
        {
            NSArray * ary2=@[@"测亩仪",@"水印相机",@"航拍助手",@"面积换算器"];
            cell.celltitle.text=ary2[indexPath.row];
        }
             break;
        default:
            break;
    }
    
  //  改变UITableViewCell选中时背景色：
    UIColor *color = [[UIColor alloc]initWithRed:153/255.0 green:204/255.0 blue:255/255.0 alpha:1.0];
    //通过RGB来定义自己的颜色
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = color;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}
-(UIView* )tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSArray * titleAry=@[@"上报",@"承保",@"理赔",@"工具"];
    NSArray * imgAry=@[@"shangbao",@"chengbao",@"chakan",@"tool"];
    UIView * headerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, DeviceWidth, 60)];
    headerView.backgroundColor=AppMainColor;
    UIImageView * iconImg=[[UIImageView alloc]initWithFrame:CGRectMake(22, 15, 30, 30)];
    iconImg.image=[UIImage imageNamed:imgAry[section]];
    [headerView addSubview:iconImg];
    UILabel * titlelab=[[UILabel alloc]initWithFrame:CGRectMake(70, 15, DeviceWidth-70, 30)];
    titlelab.text= titleAry[section];
    titlelab.textAlignment=NSTextAlignmentLeft;
    titlelab.textColor=[UIColor whiteColor];
    [titlelab setFont:[UIFont systemFontOfSize:17]];
    [headerView addSubview:titlelab];
    return headerView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60;
}
#pragma 点击方法 种植、养殖 、林业
- (IBAction)plantAction:(id)sender {
    [self changeColor:0];
    self.swipeController.AgriCategoryType=1;
    if (self.swipeController.typeCount>=100) {
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"STARTREQUEST" object:self];
    }
}
- (IBAction)farmAction:(id)sender {
    self.swipeController.AgriCategoryType=2;
    [self changeColor:1];
    if (self.swipeController.typeCount>=100) {
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"STARTREQUEST" object:self];
    }
}
- (IBAction)forestryAction:(id)sender {
    self.swipeController.AgriCategoryType=3;
    [self changeColor:2];
    if (self.swipeController.typeCount>=100) {
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"STARTREQUEST" object:self];
    }
}
-(void) changeColor:(int)i
{
    switch (i) {
        case 0:
            self.plantingView.backgroundColor=[UIColor colorWithRed:123/255.0 green:199/255.0 blue:220/255.0 alpha:1.0];
            self.plantTap.backgroundColor=[UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1.0];
            self.farmTap.backgroundColor=[UIColor whiteColor];
            self.farmView.backgroundColor=[UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1.0];
            self.forestryTap.backgroundColor=[UIColor whiteColor];;
            self.forestryView.backgroundColor=[UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1.0];
            break;
        case 1:
            self.farmView.backgroundColor=[UIColor colorWithRed:123/255.0 green:199/255.0 blue:220/255.0 alpha:1.0];
            self.farmTap.backgroundColor=[UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1.0];
            self.forestryTap.backgroundColor=[UIColor whiteColor];;
            self.forestryView.backgroundColor=[UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1.0];
            
            self.plantTap.backgroundColor=[UIColor whiteColor];;
            self.plantingView.backgroundColor=[UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1.0];
            break;
        case 2:
            self.forestryView.backgroundColor=[UIColor colorWithRed:123/255.0 green:199/255.0 blue:220/255.0 alpha:1.0];
            self.forestryTap.backgroundColor=[UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1.0];
            self.plantTap.backgroundColor=[UIColor whiteColor];;
            self.plantingView.backgroundColor=[UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1.0];
            self.farmTap.backgroundColor=[UIColor whiteColor];
            self.farmView.backgroundColor=[UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1.0];
            break;
        default:
            break;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
           self.swipeController.typeCount=0;
         RepordViewController * respordVc=[[RepordViewController alloc]init];
        [self.navigationController pushViewController:respordVc animated:YES];
    }
    else if(indexPath.section==1)
    {
        if (self.swipeController.visibleState == RNSwipeVisibleLeft)
        {
            self.swipeController.typeCount=(int)indexPath.row+100;
            [self.swipeController resetView];
            if (indexPath.row==3||indexPath.row==4) {
                [[NSNotificationCenter defaultCenter]
                 postNotificationName:@"SELECTSQLITE" object:self];
            }else
            {
            [[NSNotificationCenter defaultCenter]
             postNotificationName:@"STARTREQUEST" object:self];
            }

        }
    }else if (indexPath.section==2)
    {
        if (self.swipeController.visibleState == RNSwipeVisibleLeft)
        {
            self.swipeController.typeCount=(int)indexPath.row+200;
            [self.swipeController resetView];
           
                [[NSNotificationCenter defaultCenter]
                 postNotificationName:@"STARTREQUEST" object:self];
            
           
            

//            if (indexPath.row==3||indexPath.row==4) {
//                [[NSNotificationCenter defaultCenter]
//                 postNotificationName:@"SELECTSQLITE" object:self];
//            }else
//            {
//                [[NSNotificationCenter defaultCenter]
//                 postNotificationName:@"STARTREQUEST" object:self];
//            }
//            
        }
    }
}
-(void)reloadTabelData
{
    [self.tableView reloadData];
}

@end
