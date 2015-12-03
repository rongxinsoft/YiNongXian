//
//  SXDatabase.h
//  SXUniversity
//
//  Created by sxwt9 on 15/5/8.
//  Copyright (c) 2015年 sxwt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SXDatabase : NSObject
//插入与更新用户数据
+(void)insertIntoUserTableWithUserName:(NSString *)F_UserName
                           andPassword:(NSString * )F_Password
                              andRname:(NSString *)F_Rname
                            andOrgCode:(NSString *)F_OrgCode
                             andRights:(NSString *)F_Rights
                         andRegionCode:(NSString *)F_RegionCode;
//本地验证
+(int)LocalCheckandUname:(NSString *)username andPassword:(NSString *)passWord;


//插入与更新任务数据
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
                     andDelegatePerson:(NSString *)delegatePerson;
//认领校验
+(int)checkPLYID:(NSString *)policyId;
// 图斑表数据更新插入数据
+(void)insertIntoTShapeTableWithTID:(NSMutableArray *)shapeAry;
//获取待采集任务
+ (NSMutableArray *)getWillcollect:(NSString*)status;
//删除数据库与policyId有关所有数据
+(void)deletePLYwithPolicyID:(NSString *)policyId;




//插入与更新案件数据
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
                        anddelegatePerson:(NSString *)delegatePerson;
// 删除 案件单个数据
+(void)deleteT_SrywithPolicyID:(NSString *)accidentId;
//检验案件
+(int)checkTSrvyID:(NSString *)accidentId;

+ (NSMutableArray *)getWillcase:(NSString*)status;
@end
