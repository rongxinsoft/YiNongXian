//
//  WarterDetailViewController.h
//  YiNongXian
//
//  Created by 索金铭 on 15/12/2.
//  Copyright © 2015年 bxlt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WarterDetailViewController : UIViewController<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *goodImgScro;

@property (weak, nonatomic) IBOutlet UILabel *imagesCount;



- (IBAction)cancelTap:(id)sender;
@property(strong,nonatomic)NSMutableArray * photosAry;
@property(assign,nonatomic)int num;
@end
