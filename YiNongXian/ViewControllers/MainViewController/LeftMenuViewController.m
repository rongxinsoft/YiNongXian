//
//  LeftMenuViewController.m
//  YiNongXian
//
//  Created by 索金铭 on 15/11/13.
//  Copyright © 2015年 bxlt. All rights reserved.
//

#import "LeftMenuViewController.h"
#import "LeftTableViewCell.h"
@interface LeftMenuViewController ()

@end

@implementation LeftMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
}

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
}
- (IBAction)farmAction:(id)sender {
     [self changeColor:1];
}
- (IBAction)forestryAction:(id)sender {
     [self changeColor:2];
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


@end
