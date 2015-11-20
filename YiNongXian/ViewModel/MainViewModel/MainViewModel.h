//
//  MainViewModel.h
//  YiNongXian
//
//  Created by 索金铭 on 15/11/20.
//  Copyright © 2015年 bxlt. All rights reserved.
//

#import "ViewModelClass.h"

@interface MainViewModel : ViewModelClass
//任务池查询请求
-(void)requstMainDataAndUserName:(NSString *)userName andAgriCategory:(NSString *)agriCategory andrtotal:(NSString *)rtotal andPage:(NSString *)page andType:(int)typeCount;
@end
