//
//  EntrustViewModel.m
//  YiNongXian
//
//  Created by 索金铭 on 15/11/23.
//  Copyright © 2015年 bxlt. All rights reserved.
//

#import "EntrustViewModel.h"
#import "AppDelegate.h"
#import "NetRequestClass.h"
@implementation EntrustViewModel
-(void)entrustRequestAnddelegateId:(NSString *)delegateId andDelegatePerson:(NSString *)delegatePerson andBeDelegatedPerson:(NSString *)beDelegatedPerson andType:(int)type
{
    AppDelegate * delegate=DELEGATE;
    NSString * url;
    if (type==201) {
        url=[NSString stringWithFormat:@"%@/survey/delegateSurvey",delegate.POSTURL];
    }else
    {
    url=[NSString stringWithFormat:@"%@/ply/delegatePly",delegate.POSTURL];
    }
    NSDictionary * requestDic=@{@"delegateId":delegateId,@"delegatePerson":delegatePerson,@"beDelegatedPerson":beDelegatedPerson};
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
