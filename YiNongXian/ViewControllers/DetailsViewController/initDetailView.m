//
//  initDetailView.m
//  YiNongXian
//
//  Created by 索金铭 on 15/11/27.
//  Copyright © 2015年 bxlt. All rights reserved.
//

#import "initDetailView.h"
#import "CaseTextViewController.h"
#import "MapViewController.h"
#import "ImageDataViewController.h"
#import <WMPageController.h>
@implementation initDetailView
+(WMPageController*)initDetailVC
{
    NSArray *viewControllers = @[[CaseTextViewController class], [MapViewController class], [ImageDataViewController class]];
    NSArray *titles = @[@"案件文本", @"地理信息", @"影像资料"];
    WMPageController *pageVC = [[WMPageController alloc] initWithViewControllerClasses:viewControllers andTheirTitles:titles];
    pageVC.menuBGColor=AppMainColor;
    pageVC.menuHeight=44;
    pageVC.progressColor = [UIColor whiteColor];
    pageVC.titleColorNormal=[UIColor whiteColor];
    pageVC.titleColorSelected=[UIColor whiteColor];
    pageVC.pageAnimatable = NO;
    pageVC.menuViewStyle = WMMenuViewStyleFooldHollow;
    pageVC.menuItemWidth = DeviceWidth/4;
    //pageVC.postNotification = YES;
    pageVC.bounces = YES;
    return pageVC;
}
@end
