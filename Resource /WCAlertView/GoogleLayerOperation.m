//
//  GoogleLayerOperation.m
//  TestEsri
//
//  Created by liangguowei on 15/11/25.
//  Copyright © 2015年 liangguowei. All rights reserved.
//

#import "GoogleLayerOperation.h"
#import "GoogleTiledLayer.h"


@implementation GoogleLayerOperation

/**
 *  初始化方法
 *
 *  @param tileKey    切片key
 *  @param mapType    地图类型
 *  @param fatherView 父view
 *
 *  @return
 */
-(id)initWithTileKey:(AGSTileKey *)tileKey
          andMapType:(GoogleMapLayerType)mapType
       andTiledLayer:(GoogleTiledLayer *)fatherView
{
    self=[super init];
    
    if (self) {
        _tileKey=tileKey;
        _fatherView=fatherView;
        _mapType=mapType;
    }
    return self;
}



-(void)main
{
    @autoreleasepool {
        if (self.isCancelled) {
            return;
        }
        
        NSString *ns=@"Galileo";
        NSString *s=[ns substringWithRange:NSMakeRange(0, (3*_tileKey.column+_tileKey.row)%8)];
        if (!self.isCancelled) {
            NSString *baseUrl;
            
            switch (_mapType) {
                case IMAGE_GOOGLE_MAP:
                {
                    baseUrl=[NSString stringWithFormat:@"http://mt%@.google.cn/vt/lyrs=s&hl=zh-CN&gl=cn&x=%@&y=%@&z=%@&s=%@",@(_tileKey.column%4),@(_tileKey.column),@(_tileKey.row),@(_tileKey.level),(s)];
                }
                    break;
                case VECTOR_GOOGLE_MAP:
                {
                    baseUrl=[NSString stringWithFormat:@"http://mt%@.google.cn/vt/lyrs=m@158000000&hl=zh-CN&gl=cn&x=%@&y=%@&z=%@&s=%@",@(_tileKey.column%4),@(_tileKey.column),@(_tileKey.row),@(_tileKey.level),(s)];
                }
                    break;
                case TERRAIN_GOOGLE_MAP:
                {
                    baseUrl=[NSString stringWithFormat:@"http://mt%@.google.cn/vt/lyrs=t@131,r@227000000&hl=zh-CN&gl=cn&x=%@&y=%@&z=%@&s=%@",@(_tileKey.column%4),@(_tileKey.column),@(_tileKey.row),@(_tileKey.level),(s)];
                }
                    break;
                case ANNOTATION_GOOGLE_MAP:
                {
                    baseUrl=[NSString stringWithFormat:@"http://mt%@.google.cn/vt/imgtp=png32&lyrs=h@169000000&hl=zh-CN&gl=cn&x=%@&y=%@&z=%@&s=%@",@(_tileKey.column%4),@(_tileKey.column),@(_tileKey.row),@(_tileKey.level),(s)];
                }
                    break;
                    
                default:
                    break;
            }
            
            
            NSURL *aUrl=[NSURL URLWithString:baseUrl];
            NSData *data=[NSData dataWithContentsOfURL:aUrl];
            if (data) {
                _imageData=data;
            }
            
            if (!self.isCancelled) {
                [_fatherView didFinishedOperation:self];
            }
            
        }
    }
}

@end
