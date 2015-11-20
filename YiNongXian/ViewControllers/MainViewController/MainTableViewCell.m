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
-(void) setValueWithDic : (MainModel *) mainModel  andRightValue:(MainModel *) rightModel
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
}
-(void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
