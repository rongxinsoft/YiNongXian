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
#import "ShapeModel.h"
#import "MainModel.h"
#import "caseModel.h"
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
    
    //用户表
    [db executeUpdate:@"CREATE TABLE P_USER(F_UserName TEXT,F_Password TEXT,F_Rname TEXT,F_OrgCode TEXT,F_Rights TEXT,F_RegionCode TEXT)"];
    //保单表
    [db executeUpdate:@"CREATE TABLE T_PLY(policyId TEXT,proposalNo TEXT,proposalDate TEXT,area TEXT,productName TEXT,organizationCode TEXT,orgName TEXT,commInfo TEXT,agriCategory TEXT,status TEXT,delegatePerson TEXT)"];
    
    //案件表
    [db executeUpdate:@"CREATE TABLE T_Srvy(accidentId TEXT,reportNo TEXT,reporTime TEXT,reportPerson TEXT,reportReason TEXT,accdientAddress TEXT,reperPhone TEXT,accidentTime TEXT,productName TEXT,commInfo TEXT,productType TEXT,orgCode TEXT,orgName TEXT,status TEXT,delegatePerson TEXT)"];
    
    //图斑表
    [db executeUpdate:@"CREATE TABLE T_Shape(T_ID TEXT,APP_ID TEXT,PLY_ID TEXT,SHAPE TEXT,WGS84_SHAPE TEXT,STATUS TEXT,CREATED_TM TEXT,CREATED_BY TEXT,CTEATE_TYPE TEXT,UPLOAD_STATUS TEXT,AREA TEXT,DAMAGELEVEL TEXT)"];
}
#pragma mark-  用户数据
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
        
         [db executeUpdate:[NSString stringWithFormat:@"update P_USER set F_Password = '%@',F_Rname = '%@',F_OrgCode='%@',F_Rights = '%@',F_RegionCode = '%@' where F_UserName = '%@'",F_Password,F_Rname,F_OrgCode,F_Rights,F_RegionCode,F_UserName]];
        return;
    }
    //向数据库中插入一条数据
    else{
         [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO  P_USER ( F_UserName,F_Password ,F_Rname ,F_OrgCode,F_Rights ,F_RegionCode )VALUES ('%@','%@','%@','%@','%@','%@')",F_UserName,F_Password,F_Rname,F_OrgCode,F_Rights,F_RegionCode]];
        
    }
}
#pragma mark-  插入与更新案件数据
+(void)insertIntoTSrvyTableWithaccidentId:(NSString *)accidentId
                                            andreportNo:(NSString * )reportNo
                                            andreporTime:(NSString *)reporTime
                                            andreportPerson:(NSString *)reportPerson
                                            andreportReason:(NSString *)reportReason
                                            andaccdientAddress:(NSString *)accdientAddress
                                            andreperPhone:(NSString *)reperPhone
                                            andaccidentTime:(NSString *)accidentTime
                                            andproductName:(NSString *)productName
                                            andcommInfo:(NSString *)commInfo
                                            andproductType:(NSString *)productType
                                            andorgCode:(NSString *)orgCode
                                            andorgName:(NSString *)orgName
                                            andstatus:(NSString *)status
                                            anddelegatePerson:(NSString *)delegatePerson


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
    //案件表
    [db executeUpdate:@"CREATE TABLE T_Srvy(accidentId TEXT,reportNo TEXT,reporTime TEXT,reportPerson TEXT,reportReason TEXT,accdientAddress TEXT,reperPhone TEXT,accidentTime TEXT,productName TEXT,commInfo TEXT,productType TEXT,orgCode TEXT,orgName TEXT,status TEXT,delegatePerson TEXT)"];
    NSString *sqlStr;
    sqlStr = [NSString stringWithFormat:@"select * from T_Srvy where accidentId= '%@'", accidentId];
    FMResultSet *rs = [db executeQuery:sqlStr];
    
    if([rs next])
    {
        
        [db executeUpdate:[NSString stringWithFormat:@"update T_Srvy set reportNo = '%@',reporTime = '%@',reportReason='%@',accdientAddress = '%@',reperPhone = '%@',accidentTime = '%@',productName = '%@',commInfo = '%@',productType = '%@',orgCode = '%@' ,orgName = '%@',status = '%@',delegatePerson = '%@' where accidentId = '%@'",reportNo,reporTime,reportReason,accdientAddress,reperPhone,accidentTime,productName,commInfo,productType,orgCode,orgName,status,delegatePerson,accidentId]];
        return;
    }
    //向数据库中插入一条数据
    else{
        [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO  T_Srvy (accidentId ,reportNo,reporTime,reportPerson ,reportReason ,accdientAddress,reperPhone,accidentTime,productName,commInfo,productType,orgCode,orgName,status,delegatePerson)VALUES ('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')",accidentId,reportNo,reporTime,reportPerson,reportReason,accdientAddress,reperPhone,accidentTime,productName,commInfo,productType,orgCode,orgName,status,delegatePerson]];
    }

}
#pragma 删除 案件单个数据
+(void)deleteT_SrywithPolicyID:(NSString *)accidentId
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
    BOOL a= [db executeUpdate:[NSString stringWithFormat:@"delete from T_Srvy where accidentId ='%@'", accidentId]];
    //成功则删除对应ID 图斑
    if (a==YES) {
        NSString *sqlStr;
        sqlStr = [NSString stringWithFormat:@"delete from T_Shape where PLY_ID ='%@'", accidentId];
        [db executeUpdate:sqlStr];
    }
    else
    {
        [SVProgressHUD showErrorWithStatus:@"删除失败"];
    }
}
//将要采集数据
+ (NSMutableArray *)getWillcase:(NSString*)status
{
    if (!db) {
        [self creatDatabase];
    }
    
    if (![db open]) {
        NSLog(@"数据库打开失败");
        return nil;
    }
    [db setShouldCacheStatements:YES];
    
    NSMutableArray * allDatarray = [[NSMutableArray alloc] initWithCapacity:50];
    //定义一个结果集，存放查询的数据
    FMResultSet *rs = [db executeQuery:[NSString stringWithFormat:@"select * from T_Srvy where status = '%@'", status]];
    //判断结果集中是否有数据，如果有则取出数据
    while ([rs next]) {
        caseModel *mainModel = [[ caseModel alloc] init];
        mainModel.accidentId=[rs stringForColumn:@"accidentId"];
        mainModel.productName = [rs stringForColumn:@"productName"];
        mainModel.commInfo=[rs stringForColumn:@"commInfo"];
        mainModel.reportNo = [rs stringForColumn:@"reportNo"];
        mainModel.reportPerson= [rs stringForColumn:@"reportPerson"];
        mainModel.reporTime = [rs stringForColumn:@"reporTime"];
        mainModel.reportReason=[rs stringForColumn:@"reportReason"];
        mainModel.accidentTime=[rs stringForColumn:@"accidentTime"];
        mainModel.reperPhone=[rs stringForColumn:@"reperPhone"];
        mainModel.accdientAddress=[rs stringForColumn:@"accdientAddress"];
        mainModel.delegatePerson=[rs stringForColumn:@"delegatePerson"];
        [allDatarray addObject:mainModel];
    }
    return allDatarray ;
}
#pragma  检验案件
+(int)checkTSrvyID:(NSString *)accidentId

{
    
    if (!db) {
        [self creatDatabase];
    }
    
    if (![db open]) {
        NSLog(@"数据库打开失败");
        return nil;
    }
    [db setShouldCacheStatements:YES];
    
    FMResultSet *rs = [db executeQuery:[NSString stringWithFormat:@"select * from T_Srvy where accidentId = '%@'", accidentId]];
    if ([rs next])
    {
        //stastus  1待采集  2已上报  3  上报中
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

#pragma mark 插入与更新保单数据
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
    if ([status isEqualToString:@"0"]) {
        status=@"2";
    }
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
        
         [db executeUpdate:[NSString stringWithFormat:@"update T_PLY set proposalNo = '%@',proposalDate = '%@',area='%@',productName = '%@',organizationCode = '%@',orgName = '%@',commInfo = '%@',agriCategory = '%@',status = '%@',delegatePerson = '%@' where policyId = '%@'",proposalNo,proposalDate,area,productName,OrgCode,orgName,comminfo,agriCategory,status,delegatePerson,policyId]];
        return;
    }
    //向数据库中插入一条数据
    else{
        [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO  T_PLY (policyId,proposalNo,proposalDate,area,productName ,organizationCode ,orgName,commInfo ,agriCategory ,status,delegatePerson)VALUES ('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')",policyId,proposalNo,proposalDate,area,productName,OrgCode,orgName,comminfo,agriCategory,status,delegatePerson]];
        
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
        //stastus  1待采集  2已上报  3  上报中
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
#pragma mark-删除  保单
+(void)deletePLYwithPolicyID:(NSString *)policyId
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
    BOOL a=   [db executeUpdate:[NSString stringWithFormat:@"delete from T_PLY where policyId ='%@'", policyId]];
    if (a==YES) {
        NSString *sqlStr;
        sqlStr = [NSString stringWithFormat:@"delete from T_Shape where PLY_ID ='%@'", policyId];
        [db executeUpdate:sqlStr];
    }
    else
    {
        [SVProgressHUD showErrorWithStatus:@"删除失败"];
    }
}
#pragma mark-图斑
+(void)insertIntoTShapeTableWithTID:(NSMutableArray *)shapeAry
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
    if (shapeAry!=nil&&[shapeAry isKindOfClass:[NSArray class]]&&shapeAry.count!=0) {
        ShapeModel * shapeModel=shapeAry[0];
        NSString *sqlStr;
        sqlStr = [NSString stringWithFormat:@"delete from T_Shape where PLY_ID ='%@'", shapeModel.PLY_ID];
        [db executeUpdate:sqlStr];
        for (int i=0; i<shapeAry.count; i++) {
            ShapeModel * shapModel=shapeAry[i];
             [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO  T_Shape (T_ID,APP_ID,PLY_ID,SHAPE,WGS84_SHAPE,STATUS,CREATED_TM,CREATED_BY,CTEATE_TYPE,UPLOAD_STATUS,AREA,DAMAGELEVEL)VALUES ('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')",shapModel.T_ID,shapModel.APP_ID ,shapModel.PLY_ID,shapModel.SHAPE,shapModel.WGS84_SHAPE,shapModel.STATUS,shapModel.CREATED_TM,shapModel.CREATED_BY,shapModel.CTEATE_TYPE,shapModel.UPLOAD_STATUS,shapModel.AREA,shapModel.DAMAGELEVEL]];
        }
    }

}
//将要采集数据
+ (NSMutableArray *)getWillcollect:(NSString*)status
{
    if (!db) {
        [self creatDatabase];
    }
    
    if (![db open]) {
        NSLog(@"数据库打开失败");
        return nil;
    }
    [db setShouldCacheStatements:YES];
    
    NSMutableArray * allDatarray = [[NSMutableArray alloc] initWithCapacity:50];
    //定义一个结果集，存放查询的数据
    FMResultSet *rs = [db executeQuery:[NSString stringWithFormat:@"select * from T_PLY where status = '%@'", status]];
    //判断结果集中是否有数据，如果有则取出数据
    while ([rs next]) {
        MainModel *mainModel = [[MainModel alloc] init];
        mainModel.productName = [rs stringForColumn:@"productName"];
        mainModel.proposalDate = [rs stringForColumn:@"proposalDate"];
        mainModel.proposalNo= [rs stringForColumn:@"proposalNo"];
        mainModel.orgName=[rs stringForColumn:@"orgName"];
        mainModel.area = [rs stringForColumn:@"area"];
        mainModel.policyId=[rs stringForColumn:@"policyId"];
        mainModel.delegatePerson=[rs stringForColumn:@"delegatePerson"];
        [allDatarray addObject:mainModel];
    }
    return allDatarray ;
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
