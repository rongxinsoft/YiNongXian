//
//  MainTableViewCell.m
//  YiNongXian
//
//  Created by 索金铭 on 15/11/17.
//  Copyright © 2015年 bxlt. All rights reserved.
//

#import "MainTableViewCell.h"

@implementation MainTableViewCell

- (void)awakeFromNib
{
    self.leftView.layer.borderWidth=1;
    self.leftView.layer.borderColor=[UIColor groupTableViewBackgroundColor].CGColor;
    self.rightView.layer.borderWidth=1;
    self.rightView.layer.borderColor=[UIColor groupTableViewBackgroundColor].CGColor;
}
-(void) setValueWithDic : (MainModel *) mainModel  andRightValue:(MainModel *) rightModel andTypeCount:(int)type
{
    
    if (![mainModel.productName isKindOfClass:[NSNull class]])
    {
        self.leftproductName.text=[NSString stringWithFormat:@"产品名称:%@",mainModel.productName];
    }
    if (![mainModel.proposalNo isKindOfClass:[NSNull class]])
    {
        self.leftProposalNo.text=[NSString stringWithFormat:@"投保单号:%@",mainModel.proposalNo];

    }
    if (![mainModel.area isKindOfClass:[NSNull class]])
    {
        self.leftarea.text=[NSString stringWithFormat:@"投保区域:%@",mainModel.area];
    }
    if (![mainModel.proposalDate isKindOfClass:[NSNull class]])
    {
        self.leftproposalDate.text=[NSString stringWithFormat:@"投保日期:%@",mainModel.proposalDate];
    }
    if (![rightModel.productName isKindOfClass:[NSNull class]])
    {
        self.R_productName.text=[NSString stringWithFormat:@"产品名称:%@",rightModel.productName];
;
    }
   if (![rightModel.proposalNo isKindOfClass:[NSNull class]])
    {
        self.R_ProposalNo.text=[NSString stringWithFormat:@"投保单号:%@", rightModel.proposalNo];
    }
    if (![rightModel.area isKindOfClass:[NSNull class]])
    {
        self.R_area.text=[NSString stringWithFormat:@"投保区域:%@",rightModel.area];;
    }
    if (![rightModel.proposalDate isKindOfClass:[NSNull class]])
    {
        self.R_proposalDate.text=[NSString stringWithFormat:@"投保日期:%@",rightModel.proposalDate];
    }
    if (type==103||type==104) {
        if (![mainModel.delegatePerson isEqualToString:@"(null)"]) {
            self.entrustLable.hidden=NO;
        }else{
            self.entrustLable.hidden=YES;
        }
        if (![rightModel.delegatePerson isEqualToString:@"(null)"]) {
            self.R_entrustLab.hidden=NO;
        }else{
            self.R_entrustLab.hidden=YES;
        }
    }
}

-(void)setBtn:(int)type
{
    type-=100;
    switch (type) {
        case 1:
            self.L_entrustBtn.hidden=YES;
            self.R_entrustBtn.hidden=YES;
            break;
        case 3:
            [self.L_entrustBtn setTitle:@"注销" forState:UIControlStateNormal];
            [self.L_entrust setTitle:@"上报" forState:UIControlStateNormal];
            [self.L_details setHidden:NO];
            [self.R_details setHidden:NO];
            [self.R_entrustBtn setTitle:@"注销" forState:UIControlStateNormal];
            [self.R_entrust setTitle:@"上报" forState:UIControlStateNormal];
            break;
        case 4:
            [self.L_entrustBtn setHidden:YES];
            [self.L_details setHidden:NO];
            [self.R_details setHidden:NO];
            [self.L_entrust setTitle:@"删除" forState:UIControlStateNormal];
            [self.L_entrust setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            [self.R_entrustBtn setHidden:YES];
            [self.R_entrust setTitle:@"删除" forState:UIControlStateNormal];
            [self.R_entrust setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            break;
        default:
            break;
    }
    
}
-(void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
