//
//  Tools.m
//  YiNongXian
//
//  Created by 索金铭 on 15/11/30.
//  Copyright © 2015年 bxlt. All rights reserved.
//

#import "Tools.h"
#import "caseModel.h"
#import "MainModel.h"

@implementation Tools
static caseModel * caseM;
static MainModel * main;
static bool isORno;

+(void)isCaseOrMain:(BOOL )isCase
{
    isORno=isCase;
}
+(BOOL)isORno
{
    return isORno;
}

+(void)saveCase:(caseModel *)caseModel
{
    caseM=  caseModel;
}
+(caseModel *)caseM;
{
    return caseM;
}
+(void)saveMainModel:(MainModel *)MainModel
{
    main=MainModel;
}
+(MainModel *)main
{
    return main;
}
@end
