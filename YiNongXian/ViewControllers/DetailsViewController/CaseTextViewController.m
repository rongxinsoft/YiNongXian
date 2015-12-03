//
//  CaseTextViewController.m
//  YiNongXian
//
//  Created by 索金铭 on 15/11/27.
//  Copyright © 2015年 bxlt. All rights reserved.
//

#import "CaseTextViewController.h"
#import "Tools.h"
#import "caseModel.h"
#import "MainModel.h"
@interface CaseTextViewController ()

@end

@implementation CaseTextViewController
@synthesize No_text,Time_text,address_text,product_name,Org_text,info_text,No_lab,Tag_lab,Data_lab,address_lab,product_lab,org_lab,info_lab;
- (void)viewDidLoad {
    [super viewDidLoad];
    if ([Tools isORno]==YES) {
        No_lab.text=@"报 案 号";
        Data_lab.text=@"报案时间";
        address_lab.text=@"报案人";
        product_lab.text=@"报案原因";
        org_lab.text=@"出险地点";
        info_lab.text=@"报案人电话";
        self.caseTime_lab.hidden=NO;
        self.caseName_Lab.hidden=NO;
        self.caseInfo_lab.hidden=NO;
        self.caseTime_text.hidden=NO;
        self.caseName.hidden=NO;
        self.caseInfo.hidden=NO;
        caseModel * caseM=[Tools caseM];
        if (![caseM.reportNo isEqualToString:@"<null>"]&&![caseM.reportNo isEqualToString:@"(null)"]) {
            No_text.text=caseM.reportNo;
        }
        if (![caseM.reporTime isEqualToString:@"<null>"]&&![caseM.reporTime isEqualToString:@"(null)"]) {
             Time_text.text=caseM.reporTime;
        }
        if (![caseM.reportPerson isEqualToString:@"<null>"]&&![caseM.reportPerson isEqualToString:@"(null)"]) {
              address_text.text=caseM.reportPerson;
        }
        if (![caseM.reportReason isEqualToString:@"<null>"]&&![caseM.reportReason isEqualToString:@"(null)"]) {
            product_name.text=caseM.reportReason;
        }
        if (![caseM.accdientAddress isEqualToString:@"<null>"]&&![caseM.accdientAddress isEqualToString:@"(null)"]) {
             Org_text.text=caseM.accdientAddress;
        }
        if (![caseM.reperPhone isEqualToString:@"<null>"]&&![caseM.reperPhone isEqualToString:@"(null)"]) {
            info_text.text=caseM.reperPhone;
        }
        if (![caseM.accidentTime isEqualToString:@"<null>"]&&![caseM.accidentTime isEqualToString:@"(null)"]) {
            self.caseTime_text.text=caseM.accidentTime;
        }
        if (![caseM.productName isEqualToString:@"<null>"]&&![caseM.productName isEqualToString:@"(null)"]) {
              self.caseName.text=caseM.productName;
        }
        if (![caseM.commInfo isEqualToString:@"<null>"]&&![caseM.commInfo isEqualToString:@"(null)"]) {
             self.caseInfo.text=caseM.commInfo;
        }
    }else
    {
        MainModel * mmod=[Tools main];
        if (![mmod.proposalNo isEqualToString:@"<null>"]&&![mmod.proposalNo isEqualToString:@"(null)"]) {
           No_text.text=mmod.proposalNo;
        }
        if (![mmod.proposalDate isEqualToString:@"<null>"]&&![mmod.proposalDate isEqualToString:@"(null)"]) {
           Time_text.text=mmod.proposalDate;
        }
        if (![mmod.area isEqualToString:@"<null>"]&&![mmod.area isEqualToString:@"(null)"]) {
             address_text.text=mmod.area;
        }
        if (![mmod.productName isEqualToString:@"<null>"]&&![mmod.productName isEqualToString:@"(null)"]) {
              product_name.text=mmod.productName;
        }
        if (![mmod.orgName isEqualToString:@"<null>"]&&![mmod.orgName isEqualToString:@"(null)"]) {
               Org_text.text=mmod.orgName;
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
