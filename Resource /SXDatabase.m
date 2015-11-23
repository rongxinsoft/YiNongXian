//
//  SXDatabase.m
//  SXUniversity
//
//  Created by sxwt9 on 15/5/8.
//  Copyright (c) 2015年 sxwt. All rights reserved.
//

#import "SXDatabase.h"
#import "FMDatabase.h"
#import "Encrpt.h"
FMDatabase * db;
@implementation SXDatabase

//获得存放数据库文件的沙盒地址
+(NSString *)databaseFilePath
{
    NSArray *filePath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [filePath objectAtIndex:0];
    NSLog(@"%@",filePath);
    NSString *dbFilePath = [documentPath stringByAppendingPathComponent:@"ENXDB.sqlite"];
    return dbFilePath;
}
//创建数据库的操作
+(void)creatDatabase
{
    db = [FMDatabase databaseWithPath:[self databaseFilePath]];
}
//创建表
+(void)creatTable
{
    //先判断数据库是否存在，如果不存在，创建数据库
    if (!db) {
       	[self creatDatabase];
    }
    //判断数据库是否已经打开，如果没有打开，提示失败
    if (![db open]) {
        NSLog(@"数据库打开失败");
        return;
    }
    
    //为数据库设置缓存，提高查询效率
    [db setShouldCacheStatements:YES];
    
    //判断数据库中是否已经存在这个表，如果不存在则创建该表
    [db executeUpdate:@"CREATE TABLE P_USER(F_UserName TEXT,F_Password TEXT,F_Rname TEXT,F_OrgCode TEXT,F_Rights TEXT,F_RegionCode TEXT)"];
    //保单表
    [db executeUpdate:@"CREATE TABLE T_PLY(policyId TEXT,proposalNo TEXT,proposalDate TEXT,area TEXT,productName TEXT,organizationCode TEXT,orgName TEXT,commInfo TEXT,agriCategory TEXT,status TEXT,delegatePerson TEXT)"];
    //图斑表
    [db executeUpdate:@"CREATE TABLE T_Shape(T_ID TEXT,APP_ID TEXT,PLY_ID TEXT,SHAPE TEXT,WGS84_SHAPE TEXT,STATUS TEXT,CREATED_TM TEXT,CREATED_BY TEXT,CTEATE_TYPE TEXT,UPLOAD_STATUS TEXT,AREA TEXT,DAMAGELEVEL TEXT)"];
}
//插入与更新用户数据
+(void)insertIntoUserTableWithUserName:(NSString *)F_UserName
                            andPassword:(NSString * )F_Password
                               andRname:(NSString *)F_Rname
                             andOrgCode:(NSString *)F_OrgCode
                              andRights:(NSString *)F_Rights
                          andRegionCode:(NSString *)F_RegionCode

{
    if (!db) {
        [self creatDatabase];
    }
    
    if (![db open]) {
        NSLog(@"数据库打开失败");
        return;
    }
    
    [db setShouldCacheStatements:YES];
    [self creatTable];
      NSString *sqlStr;
    sqlStr = [NSString stringWithFormat:@"select * from P_USER where F_UserName = '%@'", F_UserName];
     FMResultSet *rs = [db executeQuery:sqlStr];
    if([rs next])
    {
        
        int result = [db executeUpdate:[NSString stringWithFormat:@"update P_USER set F_UserName = '%@',F_Password = '%@',F_Rname = '%@',F_OrgCode='%@',F_Rights = '%@',F_RegionCode = '%@'",F_UserName,F_Password,F_Rname,F_OrgCode,F_Rights,F_RegionCode]];
        return;
    }
    //向数据库中插入一条数据
    else{
        int result = [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO  P_USER ( F_UserName,F_Password ,F_Rname ,F_OrgCode,F_Rights ,F_RegionCode )VALUES ('%@','%@','%@','%@','%@','%@')",F_UserName,F_Password,F_Rname,F_OrgCode,F_Rights,F_RegionCode]];
        
    }
}


//插入与更新保单数据
+(void)insertIntoTPLYTableWithPolicyId:(NSString *)policyId
                            andProposalNo:(NSString * )proposalNo
                            andProposalDate:(NSString *)proposalDate
                            andOrgCode:(NSString *)OrgCode
                            andArea:(NSString *)area
                            andProductName:(NSString *)productName
                            andOrgName:(NSString *)orgName
                            andComminfo:(NSString *)comminfo
                            andAgriCategory:(NSString *)agriCategory
                            andStatus:(NSString *)status
                           andDelegatePerson:(NSString *)delegatePerson


{
    if (!db) {
        [self creatDatabase];
    }
    
    if (![db open]) {
        NSLog(@"数据库打开失败");
        return;
    }
    
    [db setShouldCacheStatements:YES];
    [self creatTable];
    NSString *sqlStr;
    sqlStr = [NSString stringWithFormat:@"select * from T_PLY where policyId = '%@'", policyId];
    FMResultSet *rs = [db executeQuery:sqlStr];
    
    if([rs next])
    {
        
        int result = [db executeUpdate:[NSString stringWithFormat:@"update T_PLY set policyId = '%@',proposalNo = '%@',proposalDate = '%@',area='%@',productName = '%@',organizationCode = '%@',orgName = '%@',commInfo = '%@',agriCategory = '%@',status = '%@',delegatePerson = '%@' " ,policyId,proposalNo,proposalDate,area,productName,OrgCode,orgName,comminfo,agriCategory,status,delegatePerson]];
        return;
    }
    //向数据库中插入一条数据
    else{
        int result = [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO  T_PLY (policyId,proposalNo,proposalDate,area,productName ,organizationCode ,orgName,commInfo ,agriCategory ,status,delegatePerson)VALUES ('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')",policyId,proposalNo,proposalDate,area,productName,OrgCode,orgName,comminfo,agriCategory,status,delegatePerson]];
        
    }
}
//检验保单
+(int)checkPLYID:(NSString *)policyId

{
    
    if (!db) {
        [self creatDatabase];
    }
    
    if (![db open]) {
        NSLog(@"数据库打开失败");
        return nil;
    }
    [db setShouldCacheStatements:YES];
    
    FMResultSet *rs = [db executeQuery:[NSString stringWithFormat:@"select * from T_PLY where policyId = '%@'", policyId]];
    if ([rs next])
    {
        //stastus  1待采集  2上报中  3  已上报
        NSString * status=[rs stringForColumn:@"status"];
        
        
        if ([status isEqualToString:@"1"])
        {
            return 1;
        }
        else if ([status isEqualToString:@"2"])
        {
            return 2;
        }else
        {
            return 3;
        }
    }else
    {
        return 0;
    }
    
    return 0;
}
//验证本地登录
+(int)LocalCheckandUname:(NSString *)username andPassword:(NSString *)passWord

{
    if (!db) {
        [self creatDatabase];
    }
    
    if (![db open]) {
        NSLog(@"数据库打开失败");
        return nil;
    }
    [db setShouldCacheStatements:YES];
    
    FMResultSet *rs = [db executeQuery:[NSString stringWithFormat:@"select * from P_USER where F_UserName = '%@'", username]];
    if ([rs next])
    {
        NSString * Upassword=[rs stringForColumn:@"F_Password"];
        
        
        if ([passWord isEqualToString:Upassword])
        {
            return 1;
        }
        else
        {
            return 2;
        }

    }else
    {
        return 0;
    }
    
    return 0;
}
@end
