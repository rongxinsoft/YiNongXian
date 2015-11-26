//
//  noCopytextFiled.m
//  YiNongXian
//
//  Created by 索金铭 on 15/11/26.
//  Copyright © 2015年 bxlt. All rights reserved.
//

#import "noCopytextFiled.h"

@implementation noCopytextFiled

-(BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    UIMenuController *menuController = [UIMenuController sharedMenuController];
    if (menuController) {
        [UIMenuController sharedMenuController].menuVisible = NO;
    }
    return NO;
}

@end
