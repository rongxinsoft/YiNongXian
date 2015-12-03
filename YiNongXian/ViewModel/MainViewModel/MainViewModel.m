//
//  MainViewModel.m
//  YiNongXian
//
//  Created by 索金铭 on 15/11/20.
//  Copyright © 2015年 bxlt. All rights reserved.
//

#import "MainViewModel.h"
#import "NetRequestClass.h"
#import "AppDelegate.h"
#import "MainModel.h"
#import "caseModel.h"
@implementation MainViewModel
-(void)requstMainDataAndUserName:(NSString *)userName andAgriCategory:(NSString *)agriCategory andrtotal:(NSString *)rtotal andPage:(NSString *)page andType:(int)typeCount
{
    AppDelegate * delegate=DELEGATE;
    NSString * url;
    if (typeCount==100)
    {
       url =[NSString stringWithFormat:@"%@/ply/queryPolicyList",delegate.POSTURL];
    }else if(typeCount==101)
    {
        url=[NSString stringWithFormat:@"%@/ply/queryDelegatePly",delegate.POSTURL];
    }else if(typeCount==200)
    {
        url=[NSString stringWithFormat:@"%@/survey/queryDelegateSurveyList",delegate.POSTURL];
    }
    
    NSDictionary * requestDic=@{@"userLoginCode":userName,@"agriCategory":agriCategory,@"rtotal":rtotal,@"pageNum":page};
    NSDictionary * encryDic=[NetRequestClass dataProcessing:requestDic];
    if (encryDic !=nil) {
      
        [NetRequestClass NetRequestPOSTWithRequestURL:url WithParameter:encryDic WithReturnValeuBlock:^(id returnValue) {
            DDLog(@"0909009%@", returnValue);
            [self fetchValueSuccessWithDic:returnValue andType:typeCount ];
            
        } WithErrorCodeBlock:^(id errorCode) {
            DDLog(@"%@", errorCode);
            [self errorCodeWithDic:errorCode];
            
        } WithFailureBlock:^{
            [self netFailure];
            DDLog(@"网络异常");
            
        }];
    }else
    {
        [SVProgressHUD showInfoWithStatus:@"数据错误，请稍候重试"];
    }
    
}
-(void)fetchValueSuccessWithDic: (NSDictionary *) returnValue andType:(int)typeCount
{
    
    if (returnValue!=nil) {
        NSString * errcodeStr=[[returnValue objectForKey:@"Head"]objectForKey:@"ErrCode"];
        if ([errcodeStr isEqualToString:@"200"])
        {
            NSDictionary * bodyDic=[returnValue objectForKey:@"Body"];
            NSArray * policyAry;
            if (typeCount==100) {
              policyAry  =[bodyDic objectForKey:@"policyResponseList"];
            }else
            {
                 policyAry  =[bodyDic objectForKey:@"Items"];
            }
            
            NSMutableArray *returnArray = [[NSMutableArray alloc] initWithCapacity:100];
            if (typeCount==200) {
                for (NSDictionary * dic  in policyAry) {
                    caseModel * model=[[caseModel alloc]init];
                    model.accdientAddress=[dic objectForKey:@"accdientAddress"];
                    model.accidentId=[dic objectForKey:@"accidentId"];
                    model.accidentTime=[dic objectForKey:@"accidentTime"];
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
                model.delegatePerson=[dic objectForKey:@"delegatePerson"];
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
    [SVProgressHUD showErrorWithStatus:@"网络异常"];
    self.failureBlock();
}


@end
