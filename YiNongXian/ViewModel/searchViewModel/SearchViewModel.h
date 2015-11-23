//
//  SearchViewModel.h
//  YiNongXian
//
//  Created by 索金铭 on 15/11/22.
//  Copyright © 2015年 bxlt. All rights reserved.
//

#import "ViewModelClass.h"

@interface SearchViewModel : ViewModelClass
-(void)requestSearchAndsearchId:(NSString *)searchId andUserName:(NSString *)userName andRtotal:(NSString *)rtotal andAgriCategory:(NSString*)agriCategory;
@end
