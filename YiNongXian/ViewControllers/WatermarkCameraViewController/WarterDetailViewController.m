//
//  WarterDetailViewController.m
//  YiNongXian
//
//  Created by 索金铭 on 15/12/2.
//  Copyright © 2015年 bxlt. All rights reserved.
//

#import "WarterDetailViewController.h"

@interface WarterDetailViewController ()

@end

@implementation WarterDetailViewController
@synthesize photosAry,num;
- (void)viewDidLoad {
    [super viewDidLoad];
     self.goodImgScro.pagingEnabled = YES;
    self.goodImgScro.scrollEnabled=YES;
    self.goodImgScro.showsHorizontalScrollIndicator = FALSE;
    self.goodImgScro.showsVerticalScrollIndicator = FALSE;
    
    
    for (int a=0; a<photosAry.count; a++) {
        UIImageView *imagesView=[[UIImageView alloc]init];
        imagesView.image=[UIImage imageNamed:photosAry[a]];
        imagesView.frame=CGRectMake(DeviceWidth*a, 0, DeviceWidth,DeviceWidth*3/4) ;
        [self.goodImgScro addSubview:imagesView];
    }
    [self.goodImgScro setContentOffset:CGPointMake(DeviceWidth*num, 0) animated:NO];

    
    //显示图片张数
    NSString * count=[NSString stringWithFormat:@"%f",self.goodImgScro.contentOffset.x/DeviceWidth];
    int a=count.intValue+1;
    if (photosAry.count==0) {
        a=0;
    }
    self.imagesCount.text=[NSString stringWithFormat:@"%d/%i",a,(int)photosAry.count];

    self.goodImgScro.contentSize=CGSizeMake(DeviceWidth*photosAry.count, 0);
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.goodImgScro ==scrollView)
    {
        NSString * count=[NSString stringWithFormat:@"%f",scrollView.contentOffset.x/DeviceWidth];
        int a=count.intValue+1;
        self.imagesCount.text=[NSString stringWithFormat:@"%d/%i",a,(int)photosAry.count];
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
 
}



- (IBAction)cancelTap:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
