//
//  caseModel.h
//  YiNongXian
//
//  Created by 索金铭 on 15/11/26.
//  Copyright © 2015年 bxlt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface caseModel : NSObject
@property(strong,nonatomic)NSString * accidentId;// 案件ID 保单主信息
@property(strong,nonatomic)NSString * reportNo;// 报案号 保单主信息
@property(strong,nonatomic)NSString * reporTime;// 报案时间
@property(strong,nonatomic)NSString * reportPerson;// 报案人
@property(strong,nonatomic)NSString *  reportReason;// 报案原因
@property(strong,nonatomic)NSString *  accdientAddress;// 出险地点
@property(strong,nonatomic)NSString *   reperPhone;// 报案人电话
@property(strong,nonatomic)NSString * accidentTime;// 出险时间
@property(strong,nonatomic)NSString * productName;// 险种名称
@property(strong,nonatomic)NSString * commInfo;// 备注
@property(strong,nonatomic)NSString * productType;// 险种大类
@property(strong,nonatomic)NSString * orgCode;//投保机构代码
@property(strong,nonatomic)NSString * orgName;// 投保机构名称


@property(strong,nonatomic)NSString * status;
@property(strong,nonatomic)NSString * delegatePerson;
@end
