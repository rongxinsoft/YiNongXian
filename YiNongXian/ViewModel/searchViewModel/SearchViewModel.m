//
//  SearchViewModel.m
//  YiNongXian
//
//  Created by 索金铭 on 15/11/22.
//  Copyright © 2015年 bxlt. All rights reserved.
//

#import "SearchViewModel.h"
#import "AppDelegate.h"
#import "NetRequestClass.h"
#import "MainModel.h"
#import "caseModel.h"
@implementation SearchViewModel
-(void)requestSearchAndsearchId:(NSString *)searchId andUserName:(NSString *)userName andRtotal:(NSString *)rtotal andAgriCategory:(NSString*)agriCategory  andType:(int)type
{
    AppDelegate * delegate=DELEGATE;
    NSString * url;
    NSDictionary * requestDic;
    if (type==201) {
        url =[NSString stringWithFormat:@"%@/survey/querySurveyList",delegate.POSTURL];
    requestDic=@{@"reportNo":searchId,@"userName":userName,@"rtotal":@"20"};
    }else
    {
        url =[NSString stringWithFormat:@"%@/ply/queryPolicy",delegate.POSTURL];
    requestDic=@{@"policyNo":searchId,@"userLoginCode":userName,@"rtotal":@"20",@"agriCategory":agriCategory};
    }
    NSDictionary * encryDic=[NetRequestClass dataProcessing:requestDic];
    if (encryDic !=nil) {
        [NetRequestClass NetRequestPOSTWithRequestURL:url WithParameter:encryDic WithReturnValeuBlock:^(id returnValue) {
            DDLog(@"0909009%@", returnValue);
            [self fetchValueSuccessWithDic:returnValue andType:type ];
            
        } WithErrorCodeBlock:^(id errorCode) {
            DDLog(@"%@", errorCode);
            [self errorCodeWithDic:errorCode];
            
        } WithFailureBlock:^{
            [self netFailure];
            DDLog(@"网络异常");
            
        }];
    }else
    {
        [SVProgressHUD showInfoWithStatus:@"数据错误,请稍候重试"];
    }
    
}

-(void)fetchValueSuccessWithDic: (NSDictionary *) returnValue andType:(int)type
{
    
    if (returnValue!=nil) {
        NSString * errcodeStr=[[returnValue objectForKey:@"Head"]objectForKey:@"ErrCode"];
        if ([errcodeStr isEqualToString:@"200"])
        {
            NSDictionary * bodyDic=[returnValue objectForKey:@"Body"];
            NSArray * policyAry;
            NSMutableArray *returnArray = [[NSMutableArray alloc] initWithCapacity:100];
            if (type==201) {
                policyAry=[bodyDic objectForKey:@"eappSurveyListResponse"];
                for (NSDictionary * dic  in policyAry) {
                    caseModel * model=[[caseModel alloc]init];
                    model.accdientAddress=[dic objectForKey:@"accdientAddress"];
                    model.accidentId=[dic objectForKey:@"accidentId"];
                    model.commInfo=[dic objectForKey:@"commInfo"];
                    model.delegatePerson=[dic objectForKey:@"delegatePerson"];
                    model.orgCode=[dic objectForKey:@"orgCode"];
                    model.orgName=[dic objectForKey:@"orgName"];
                    model.productName=[dic objectForKey:@"productName"];
                    model.productType=[dic objectForKey:@"productType"];
                    model.reperPhone=[dic objectForKey:@"reperPhone"];
                    model.reporTime=[dic objectForKey:@"reporTime"];
                    model.reportNo=[dic objectForKey:@"reportNo"];
                    model.reportPerson=[dic objectForKey:@"reportPerson"];
                    model.reportReason=[dic objectForKey:@"reportReason"];
                    model.status=[dic objectForKey:@"status"];
                    [returnArray addObject:model];
                }

            }else
            {
                policyAry =[bodyDic objectForKey:@"policyResponseList"];
                for (NSDictionary * dic  in policyAry) {
                    MainModel * model=[[MainModel alloc]init];
                    model.policyId=[dic objectForKey:@"policyId"];
                    model.proposalNo=[dic objectForKey:@"proposalNo"];
                    model.proposalDate=[dic objectForKey:@"proposalDate"];
                    model.area=[dic objectForKey:@"area"];
                    model.productName=[dic objectForKey:@"productName"];
                    model.orgCode=[dic objectForKey:@"organizationCode"];
                    model.orgName=[dic objectForKey:@"orgName"];
                    model.commInfo=[dic objectForKey:@"commInfo"];
                    model.agriCategory=[dic objectForKey:@"agriCategory"];
                    [returnArray addObject:model];
                }
            }
           
                       self.returnBlock(returnArray);
        } else
        {
            NSString * emsg=[[returnValue objectForKey:@"Head"]objectForKey:@"ErrMsg"];
            self.returnBlock(emsg);
        }
    }
}

#pragma 对ErrorCode进行处理
-(void) errorCodeWithDic: (NSDictionary *) errorDic
{
    self.errorBlock(errorDic);
}

#pragma 对网路异常进行处理
-(void) netFailure
{
    [SVProgressHUD showInfoWithStatus:@"网络异常,请检查网络"];
    self.failureBlock();
}


@end
