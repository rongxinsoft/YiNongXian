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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
