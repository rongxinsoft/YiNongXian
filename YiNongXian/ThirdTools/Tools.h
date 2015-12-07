//
//  Tools.h
//  YiNongXian
//
//  Created by 索金铭 on 15/11/30.
//  Copyright © 2015年 bxlt. All rights reserved.
//

#import <Foundation/Foundation.h>
@class caseModel,MainModel;
@interface Tools : NSObject
//平方米转亩
+(double)SquareTurn:(double)square;


+(void)isCaseOrMain:(BOOL )isCase;
+(BOOL)isORno;
+(void)saveCase:(caseModel *)caseModel;
+(caseModel *)caseM;
+(void)saveMainModel:(MainModel *)MainModel;
+(MainModel *)main;
@end
