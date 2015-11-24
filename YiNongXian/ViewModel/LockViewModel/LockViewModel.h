//
//  LockViewModel.h
//  YiNongXian
//
//  Created by 索金铭 on 15/11/24.
//  Copyright © 2015年 bxlt. All rights reserved.
//

#import "ViewModelClass.h"

@interface LockViewModel : ViewModelClass
-(void)LockRequestAndLockType:(NSString *)lockType andbussinessId:(NSString *)bussinessId andstatus:(NSString *)status andDescription:(NSString *)description;
@end
