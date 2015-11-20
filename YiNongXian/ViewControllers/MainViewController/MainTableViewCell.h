//
//  MainTableViewCell.h
//  YiNongXian
//
//  Created by 索金铭 on 15/11/17.
//  Copyright © 2015年 bxlt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainModel.h"

@interface MainTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *leftView;
@property (weak, nonatomic) IBOutlet UIView *rightView;


@property (weak, nonatomic) IBOutlet UILabel *leftProposalNo;
@property (weak, nonatomic) IBOutlet UILabel *leftproductName;
@property (weak, nonatomic) IBOutlet UILabel *leftproposalDate;
@property (weak, nonatomic) IBOutlet UILabel *leftarea;
@property (weak, nonatomic) IBOutlet UIButton *L_entrustBtn;
@property (weak, nonatomic) IBOutlet UIButton *L_entrust;

@property (weak, nonatomic) IBOutlet UILabel *R_ProposalNo;
@property (weak, nonatomic) IBOutlet UILabel *R_productName;
@property (weak, nonatomic) IBOutlet UILabel *R_proposalDate;
@property (weak, nonatomic) IBOutlet UILabel *R_area;
@property (weak, nonatomic) IBOutlet UIButton *R_entrustBtn;
@property (weak, nonatomic) IBOutlet UIButton *R_entrust;
-(void) setValueWithDic : (MainModel *) mainModel  andRightValue:(MainModel *) rightModel;

@end
