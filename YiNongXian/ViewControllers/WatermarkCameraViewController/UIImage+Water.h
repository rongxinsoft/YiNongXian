//
//  UIImage+Water.h
//  YiNongXian
//
//  Created by 索金铭 on 15/12/3.
//  Copyright © 2015年 bxlt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Water)

//将颜色转换成img
-(UIImage*) createImageWithColor:(UIColor*) color;
//图片水印
- (UIImage *) imageWithStringWaterMark:(NSArray *)markAry  color:(UIColor *)color font:(UIFont *)font;

//图片翻转
-(UIImage *)fixOrientation:(UIImage *)aImage;

//缩略图
- (UIImage *)thumbnailWithImageWithoutScale:(UIImage *)image size:(CGSize)asize;
@end
