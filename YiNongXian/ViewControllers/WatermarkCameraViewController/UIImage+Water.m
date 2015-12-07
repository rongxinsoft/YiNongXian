//
//  UIImage+Water.m
//  YiNongXian
//
//  Created by 索金铭 on 15/12/3.
//  Copyright © 2015年 bxlt. All rights reserved.
//

#import "UIImage+Water.h"

@implementation UIImage (Water)

#pragma mark -也是文字水印
- (UIImage *) imageWithStringWaterMark:(NSArray *)markAry  color:(UIColor *)color font:(UIFont *)font
{
   

    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 40000
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 4.0)
    {
        UIGraphicsBeginImageContextWithOptions([self size], NO, 0.0); // 0.0 for scale means "scale for device's main screen".
    }
#else
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 4.0)
    {
        UIGraphicsBeginImageContext([self size]);
    }
#endif
    //原图
    [self drawInRect:CGRectMake(0, 50, self.size.width, self.size.height-150)];
    //文字颜色
    [color set];
    //水印文字
    
    UIImage * image=[self createImageWithColor:[UIColor colorWithWhite:1 alpha:1]];
    for (int a=0; a<markAry.count; a++) {
        NSString *markString=markAry[a];
        switch (a) {
            case 0:
                 [image  drawInRect:CGRectMake(0, 0,self.size.width , 50)];
                 markString =[NSString stringWithFormat:@"用户名:%@",markString];
                 [markString drawInRect:CGRectMake((self.size.width-500)/2, 0,500 , 50) withFont:font];
                break;
            case 1:
                
                 [image drawInRect:CGRectMake(0, self.size.height-210,500, 100) ];
                 markString =[NSString stringWithFormat:@"经度:%@",markString];
                [markString drawInRect:CGRectMake(0, self.size.height-210,500, 100) withFont:font];
                 break;
            case 2:
                [image drawInRect:CGRectMake(self.size.width-500, self.size.height-210,500, 100) ];
                 markString =[NSString stringWithFormat:@"纬度:%@",markString];
                [markString drawInRect:CGRectMake(self.size.width-500, self.size.height-210,500, 100) withFont:font];
                break;
            case 3:
                 markString =[NSString stringWithFormat:@"来源:%@",markString];
                [image drawInRect:CGRectMake(0, self.size.height-100,self.size.width, 100) ];
                 [markString drawInRect:CGRectMake(0, self.size.height-100,500, 100) withFont:font];
                break;
            case 4:
                 markString =[NSString stringWithFormat:@"时间:%@",markString];
                [markString drawInRect:CGRectMake(self.size.width-1000, self.size.height-100,1000, 100) withFont:font];
                break;

                
            default:
                break;
        }
    
    }
    
    
    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    newPic=  [newPic thumbnailWithImageWithoutScale:newPic size:CGSizeMake(3000, 2250)];
    return newPic;
    
}
-(UIImage *)fixOrientation:(UIImage *)aImage {
    if (aImage==nil || !aImage) {
        return  nil;
    }
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp) return aImage;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    UIImageOrientation orientation=aImage.imageOrientation;
    int orientation_=orientation;
    switch (orientation_) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
    }
    
    switch (orientation_) {
        case UIImageOrientationUpMirrored:{
            
        }
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    aImage=img;
    img=nil;
    
    return aImage;
}


//缩略图
- (UIImage *)thumbnailWithImageWithoutScale:(UIImage *)image size:(CGSize)asize

{
    
    UIImage *newimage;
    
    
    if (nil == image) {
        
        newimage = nil;
        
    }
    
    else{
        
        CGSize oldsize = image.size;
        
        CGRect rect;
        
        if (asize.width/asize.height > oldsize.width/oldsize.height) {
            
            rect.size.width = asize.height*oldsize.width/oldsize.height;
            
            rect.size.height = asize.height;
            
            rect.origin.x = (asize.width - rect.size.width)/2;
            
            rect.origin.y = 0;
            
        }
        
        else{
            
            rect.size.width = asize.width;
            
            rect.size.height = asize.width*oldsize.height/oldsize.width;
            
            rect.origin.x = 0;
            
            rect.origin.y = (asize.height - rect.size.height)/2;
            
        }
        
        
        UIGraphicsBeginImageContext(asize);
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
        
        UIRectFill(CGRectMake(0, 0, asize.width, asize.height));//clear background
        
        [image drawInRect:rect];
        
        newimage = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
    }
    
    
    return newimage;
    
}
//将颜色转换成img
-(UIImage*) createImageWithColor:(UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
@end
