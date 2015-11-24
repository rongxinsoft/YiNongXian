//
//  ShapeModel.h
//  YiNongXian
//
//  Created by 索金铭 on 15/11/24.
//  Copyright © 2015年 bxlt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShapeModel : NSObject
@property(strong,nonatomic)NSString *T_ID;//图斑ID 	保单主信息
@property(strong,nonatomic)NSString *APP_ID;//项目ID	保单主信息
@property(strong,nonatomic)NSString *PLY_ID;//保单ID
@property(strong,nonatomic)NSString *SHAPE;//图斑内容
@property(strong,nonatomic)NSString *WGS84_SHAPE;//图斑内容
@property(strong,nonatomic)NSString *STATUS;//图斑状态
@property(strong,nonatomic)NSString *CREATED_TM;//创建时间
@property(strong,nonatomic)NSString *CREATED_BY;//创建人
@property(strong,nonatomic)NSString *CTEATE_TYPE;//图斑创建模式
@property(strong,nonatomic)NSString *UPLOAD_STATUS;//图斑上报状态
@property(strong,nonatomic)NSString *AREA;//图斑面积
@property(strong,nonatomic)NSString *DAMAGELEVEL;//损失等级

@end
