//
//  ConverterViewController.m
//  YiNongXian
//
//  Created by 索金铭 on 15/12/6.
//  Copyright © 2015年 bxlt. All rights reserved.
//

#import "ConverterViewController.h"
BOOL iShow;
@interface ConverterViewController ()
@property(strong,nonatomic)NSArray * ary;
@end

@implementation ConverterViewController
@synthesize ary;
static int a,b;
- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    [self.firstText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark-tableView Delegata
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (iShow) {
        return 0;
    }
    return 3;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    static NSString *TableSampleIdentifier = @"TableSampleIdentifier";
    //    用TableSampleIdentifier表示需要重用的单元
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TableSampleIdentifier];
    //    如果如果没有多余单元，则需要创建新的单元
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:TableSampleIdentifier];
    }
    
        ary =@[@"平方米",@"公顷",@"亩"];
        cell.textLabel.text = ary[indexPath.row];
        return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.firstTable==tableView) {
          [self.firstTap setTitle:ary[indexPath.row] forState:UIControlStateNormal];
        self.firstTable.hidden=YES;
        a=(int)indexPath.row+1;
    }else
    {
        [self.secondTap setTitle:ary[indexPath.row] forState:UIControlStateNormal];
        b =(int)indexPath.row+1;
        self.secondTable.hidden=YES;
    }
        
    [self changeNum];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
#pragma textFieldDelegata
//第二步,实现回调函数
- (void) textFieldDidChange:(id) sender {
    [self changeNum];
}
- (IBAction)firstAction:(id)sender {
    [self changeNum];
        if (iShow) {
        self.firstTable.hidden=YES;
    }else
    {
        self.firstTable.hidden=NO;
    }
   
}
- (IBAction)secondAction:(id)sender {
    [self changeNum];
    if (iShow) {
        self.secondTable.hidden=YES;
    }else
    {
        self.secondTable.hidden=NO;
    }
   
}
-(void)changeNum
{
    if (a==1) {
        switch (b) {
               
            case 1:
                self.SecondText.text=self.firstText.text;
                break;
            case 2:
            {
                 float aa=[self.firstText.text  floatValue]*0.0001;
                self.SecondText.text =[NSString stringWithFormat:@"%lf",aa];
            }
                break;
            case 3:
            {
                 float aa=[self.firstText.text  floatValue]*0.0015;
                self.SecondText.text =[NSString stringWithFormat:@"%lf",aa];
            }
                break;
            default:
                break;
        }
    }
    
    if (a==2) {
        switch (b) {
            case 1:
            {
                 float aa=[self.firstText.text  floatValue]*10000;
                self.SecondText.text =[NSString stringWithFormat:@"%lf",aa];
            }
                break;
            case 2:
            {
                 float aa=[self.firstText.text  floatValue]*1;
                self.SecondText.text =[NSString stringWithFormat:@"%lf",aa];
            }
                break;
            case 3:
            {
                 float aa=[self.firstText.text  floatValue]*15;
                self.SecondText.text =[NSString stringWithFormat:@"%lf",aa];
            }
                break;
            default:
                break;
        }
    }
    if (a==3) {
        switch (b) {
            case 1:
            {
                 float aa=[self.firstText.text  floatValue]*666.6666667;
                self.SecondText.text =[NSString stringWithFormat:@"%lf",aa];
            }
                break;
            case 2:
            {
                 float aa=[self.firstText.text  floatValue]*0.0666667;
                self.SecondText.text =[NSString stringWithFormat:@"%lf",aa];
            }
                break;
            case 3:
            {
                 float aa=[self.firstText.text  floatValue]*1;
                self.SecondText.text =[NSString stringWithFormat:@"%lf",aa];
            }
                break;
            default:
                break;
        }
    }
}
@end
