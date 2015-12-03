//
//  LockViewModel.m
//  YiNongXian
//
//  Created by 索金铭 on 15/11/24.
//  Copyright © 2015年 bxlt. All rights reserved.
//

#import "LockViewModel.h"
#import "AppDelegate.h"
#import "NetRequestClass.h"
@implementation LockViewModel
-(void)LockRequestAndLockType:(NSString *)lockType andbussinessId:(NSString *)bussinessId andstatus:(NSString *)status andDescription:(NSString *)description andType:(int)type
{
    AppDelegate * delegate=DELEGATE;
    
    NSString * url;
    NSDictionary * requestDic;
    NSDictionary * encryDic;
    if (type==100 ||description==nil) {
        url=[NSString stringWithFormat:@"%@/ply/lock",delegate.POSTURL];
        requestDic=@{@"userLoginCode":USERNAME,@"lockType":lockType,@"bussinessId":bussinessId,@"status":status,@"description":@""};
        encryDic=[NetRequestClass dataProcessing:requestDic];
    }else if(type==103||type==202)
    {
        if (type==103) {
                url=[NSString stringWithFormat:@"%@/ply/canceldgplyonmobile",delegate.POSTURL];
                encryDic=[NetRequestClass dataStrProcessing:bussinessId];
            
        }else
        {
                url=[NSString stringWithFormat:@"%@/survey/canceldgsurveyonmobile",delegate.POSTURL];
                encryDic=[NetRequestClass dataStrProcessing:bussinessId];
        }
    }
    else
    {
        if (type>=200) {
            url=[NSString stringWithFormat:@"%@/survey/claimSrvy",delegate.POSTURL];
            encryDic=[NetRequestClass dataStrProcessing:bussinessId];

        }else
        {
        url=[NSString stringWithFormat:@"%@/ply/claimPly",delegate.POSTURL];
        encryDic=[NetRequestClass dataStrProcessing:bussinessId];
        }
    }
    if (encryDic !=nil) {
        [NetRequestClass NetRequestPOSTWithRequestURL:url WithParameter:encryDic WithReturnValeuBlock:^(id returnValue) {
            DDLog(@"0909009%@", returnValue);
            [self fetchValueSuccessWithDic:returnValue];
            
        } WithErrorCodeBlock:^(id errorCode) {
            DDLog(@"%@", errorCode);
            [self errorCodeWithDic:errorCode];
        } WithFailureBlock:^{
            [self netFailure];
            DDLog(@"网络异常");
        }];
    }else
    {
        [WCAlertView showAlertWithTitle:@"数据错误" message:@"请重新操作" customizationBlock:nil completionBlock:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    }
}
-(void)fetchValueSuccessWithDic: (NSDictionary *) returnValue
{
    
    if (returnValue!=nil) {
        NSString * errcodeStr=[[returnValue objectForKey:@"Head"]objectForKey:@"ErrCode"];
        if ([errcodeStr isEqualToString:@"200"])
        {
            self.returnBlock(nil);
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
    [SVProgressHUD showErrorWithStatus:@"网络异常，请检查网络"];
    self.failureBlock();
}


@end
