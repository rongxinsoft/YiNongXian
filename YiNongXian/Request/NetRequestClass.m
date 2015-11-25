//
//  NetRequestClass.m
//  MVVMTest
//
//  Created by 李泽鲁 on 15/1/6.
//  Copyright (c) 2015年 李泽鲁. All rights reserved.
//

#import "NetRequestClass.h"
#import "Encrpt.h"

@interface NetRequestClass ()

@end


@implementation NetRequestClass

+(NSDictionary *)dataProcessing:(NSDictionary *)dic
{    
    Encrpt * encrpy=[[Encrpt alloc]initWithKey:nil];
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    NSString * josnStr=[[NSString alloc]
                        initWithData:jsonData encoding:NSUTF8StringEncoding];
    if (josnStr!=nil&&![josnStr isEqualToString:@""]) {
        NSString * postEncrpy=[encrpy encryptWithString:josnStr];
        NSDictionary * dic=@{@"json":postEncrpy};
        return dic;
    }else
    {
        return nil;
    }
}
+(NSDictionary *)dataStrProcessing:(NSString *)Str
{
    Encrpt * encrpy=[[Encrpt alloc]initWithKey:nil];
    
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:Str options:NSJSONWritingPrettyPrinted error:nil];
//    NSString * josnStr=[[NSString alloc]
//                        initWithData:jsonData encoding:NSUTF8StringEncoding];
    if (Str!=nil&&![Str isEqualToString:@""]) {
        NSString * postEncrpy=[encrpy encryptWithString:Str];
        NSDictionary * dic=@{@"json":postEncrpy};
        return dic;
    }else
    {
        return nil;
    }
}

#pragma 监测网络的可链接性
+ (BOOL) netWorkReachabilityWithURLString:(NSString *) strUrl
{
    __block BOOL netState = NO;
    
    NSURL *baseURL = [NSURL URLWithString:strUrl];
    
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseURL];
    
    NSOperationQueue *operationQueue = manager.operationQueue;
    
    [manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:
            case AFNetworkReachabilityStatusReachableViaWiFi:
                [operationQueue setSuspended:NO];
                netState = YES;
                break;
            case AFNetworkReachabilityStatusNotReachable:
                netState = NO;
            default:
                [operationQueue setSuspended:YES];
                break;
        }
    
    }];
    
    [manager.reachabilityManager startMonitoring];
    
    return netState;
}


/***************************************
 在这做判断如果有dic里有errorCode
 调用errorBlock(dic)
 没有errorCode则调用block(dic
 ******************************/

#pragma --mark GET请求方式
+ (void) NetRequestGETWithRequestURL: (NSString *) requestURLString
                       WithParameter: (NSDictionary *) parameter
                WithReturnValeuBlock: (ReturnValueBlock) block
                  WithErrorCodeBlock: (ErrorCodeBlock) errorBlock
                    WithFailureBlock: (FailureBlock) failureBlock
{
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] init];
    
    AFHTTPRequestOperation *op = [manager GET:requestURLString parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        DDLog(@"%@", dic);
        
        block(dic);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failureBlock();
    }];
    
    op.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [op start];
    
}

#pragma --mark POST请求方式

+ (void) NetRequestPOSTWithRequestURL: (NSString *) requestURLString
                        WithParameter: (NSDictionary *) parameter
                 WithReturnValeuBlock:(ReturnValueBlock)block
                   WithErrorCodeBlock: (ErrorCodeBlock)errorBlock
                     WithFailureBlock: (FailureBlock)failureBlock
{
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] init];
 
    //版本
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    
    [ manager.requestSerializer setValue:[infoDictionary objectForKey:@"CFBundleShortVersionString"] forHTTPHeaderField:@"VersionCode"];
    //设备号
    [manager.requestSerializer setValue: [UIDevice currentDevice].model forHTTPHeaderField:@"EquipmentType"];
    //唯一标识
    NSString *identifierForVendor = [[UIDevice currentDevice].identifierForVendor UUIDString];
    [ manager.requestSerializer setValue:identifierForVendor forHTTPHeaderField:@"ClientId"];
    
    
    NSString * SessionKey=[[NSUserDefaults standardUserDefaults]objectForKey:@"SessionKey"];
    [ manager.requestSerializer setValue:SessionKey forHTTPHeaderField:@"SessionKey"];
    AFHTTPRequestOperation *op = [manager POST:requestURLString parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject){
         NSMutableString *str=[[NSMutableString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        if(![str isEqualToString:@""]&&str!=nil)
        {
            Encrpt * encrpt=[[Encrpt alloc]initWithKey:nil];
            NSString * dsencrpt=[encrpt decryptWithString:str];
            NSData * data=[dsencrpt dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            DDLog(@"%@", dic);
            
            block(dic);
        }
       
        
        
        /***************************************
         在这做判断如果有dic里有errorCode
         调用errorBlock(dic)
         没有errorCode则调用block(dic
         ******************************/
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failureBlock();
    }];
    
    op.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [op start];

}

-(NSString *)URLDecodedString:(NSString *)str
{
    NSString *decodedString=(__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL, (__bridge CFStringRef)str, CFSTR(""), CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    
    return decodedString;
}


@end
