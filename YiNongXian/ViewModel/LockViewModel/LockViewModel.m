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
-(void)LockRequestAndLockType:(NSString *)lockType andbussinessId:(NSString *)bussinessId andstatus:(NSString *)status andDescription:(NSString *)description
{
    AppDelegate * delegate=DELEGATE;
    NSString * url;
    url=[NSString stringWithFormat:@"%@/ply/lock",delegate.POSTURL];
    
    NSDictionary * requestDic=@{@"userLoginCode":USERNAME,@"lockType":lockType,@"bussinessId":bussinessId,@"status":status,@"description":@""};
    NSDictionary * encryDic=[NetRequestClass dataProcessing:requestDic];
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
