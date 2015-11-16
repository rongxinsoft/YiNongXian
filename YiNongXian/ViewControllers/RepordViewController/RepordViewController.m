//
//  RepordViewController.m
//  YiNongXian
//
//  Created by 索金铭 on 15/11/16.
//  Copyright © 2015年 bxlt. All rights reserved.
//

#import "RepordViewController.h"
#import "RepordTableViewCell.h"
@interface RepordViewController ()

@property(strong,nonatomic)UITableView * repordTableview;
@property(strong,nonatomic)UITableView * claimsTableview;

@end

@implementation RepordViewController
@synthesize repordTableview,claimsTableview;
- (void)viewDidLoad {
    [super viewDidLoad];
    
        [self initTableView];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark init tableView
-(void)initTableView
{
    self.automaticallyAdjustsScrollViewInsets=NO;
    repordTableview=[[UITableView alloc]initWithFrame:CGRectMake(2,66, 508, 698)];
    repordTableview.dataSource=self;
    repordTableview.delegate=self;
  
    [self.view addSubview:repordTableview];
    claimsTableview=[[UITableView alloc]initWithFrame:CGRectMake(514, 66, 508, 698)];
    claimsTableview.dataSource=self;
    claimsTableview.delegate=self;
    [self.view addSubview:claimsTableview];
    
    //设置列表边框
    repordTableview.layer.borderWidth = 1;
    repordTableview.layer.borderColor = AppLineColor.CGColor; claimsTableview.layer.borderWidth = 1;
    claimsTableview.layer.borderColor = AppLineColor.CGColor;
    
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
     tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
  //这个cell测试  需从写
    static NSString *CellIdentifier = @"RepordTableViewCell";
    RepordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"RepordTableViewCell" owner:self options:nil] objectAtIndex:0];
    }
        cell.lineView.hidden=YES;
       

   
    return cell;
    
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * repordView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, DeviceWidth, 43)];
    UILabel * lab=[[UILabel alloc]initWithFrame:CGRectMake(16, 8, DeviceWidth-16, 25)];
    if ([tableView isEqual:repordTableview]) {
        lab.text=@"承保上报";
    }else
    {
        lab.text=@"理赔上报";
    }
    lab.textColor=AppMainColor;
    
    UIView * lineView=[[UIView alloc]initWithFrame:CGRectMake(16, 35, DeviceWidth-16, 0.5)];
    lineView.backgroundColor=AppLineColor;
    [repordView addSubview:lab];
    [repordView addSubview:lineView];
    return repordView;

}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 45;
}
@end
