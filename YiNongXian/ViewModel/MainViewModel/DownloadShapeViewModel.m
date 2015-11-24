//
//  DownloadShapeViewModel.m
//  YiNongXian
//
//  Created by 索金铭 on 15/11/24.
//  Copyright © 2015年 bxlt. All rights reserved.
//

#import "DownloadShapeViewModel.h"
#import "AppDelegate.h"
#import "NetRequestClass.h"
#import "ShapeModel.h"
@implementation DownloadShapeViewModel
-(void)requestShopeAndPly_Id:(NSString *)Ply_Id
{
    AppDelegate * delegate=DELEGATE;
    NSString * url =[NSString stringWithFormat:@"%@/Shape/FindShapes",delegate.POSTURL];
    NSDictionary * requestDic=@{@"Ply_Id":Ply_Id};
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
        [SVProgressHUD showInfoWithStatus:@"数据错误，请稍候重试"];
    }
    
}
-(void)fetchValueSuccessWithDic: (NSDictionary *) returnValue
{
    
    if (returnValue!=nil) {
        NSString * errcodeStr=[[returnValue objectForKey:@"Head"]objectForKey:@"ErrCode"];
        if ([errcodeStr isEqualToString:@"200"])
        {
            NSDictionary * bodyDic=[returnValue objectForKey:@"Body"];
            NSArray *  policyAry  =[bodyDic objectForKey:@"Items"];
            NSMutableArray *returnArray = [[NSMutableArray alloc] initWithCapacity:100];
            for (NSDictionary * dic  in policyAry) {
                ShapeModel * model=[[ShapeModel alloc]init];
                model.APP_ID=[dic objectForKey:@"APP_ID"];
                model.CREATED_BY=[dic objectForKey:@"CREATED_BY"];
                model.CREATED_TM=[dic objectForKey:@"CREATED_TM"];
                model.DAMAGELEVEL=[dic objectForKey:@"DAMAGELEVEL"];
                model.SHAPE=[dic objectForKey:@"SHAPE"];
                model.T_ID=[dic objectForKey:@"T_ID"];
                model.WGS84_SHAPE=[dic objectForKey:@"WGS84_SHAPE"];
                model.PLY_ID=[dic objectForKey:@"PLY_ID"];
                model.STATUS=[dic objectForKey:@"STATUS"];
                model.AREA=[dic objectForKey:@"AREA"];
                [returnArray addObject:model];
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
