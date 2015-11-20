//
//  MainModel.h
//  YiNongXian
//
//  Created by 索金铭 on 15/11/20.
//  Copyright © 2015年 bxlt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MainModel : NSObject
@property (strong,nonatomic)NSString * policyId;//投保单ID保单主信息
@property (strong,nonatomic)NSString * proposalNo;//投保单号保单主信息
@property (strong,nonatomic)NSString * proposalDate;//投保日期
@property (strong,nonatomic)NSString * area;//投保行政区域名称
@property (strong,nonatomic)NSString * productName;//投保产品名称
@property (strong,nonatomic)NSString * orgCode;//投保机构名称
@property (strong,nonatomic)NSString * commInfo;//备注信息
@property (strong,nonatomic)NSString * orgName;//投保机构名称
@property (strong,nonatomic)NSString * agriCategory;//险种大类


@property (strong,nonatomic)NSString * status;//案件状态
@property (strong,nonatomic)NSString * delegatePerson;//案件委托人

@end
