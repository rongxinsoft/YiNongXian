//
//  GoogleLayerOperation.h
//  TestEsri
//
//  Created by liangguowei on 15/11/25.
//  Copyright © 2015年 liangguowei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MapLayerTypes.h"
#import <ArcGIS/ArcGIS.h>

@class GoogleTiledLayer;

@interface GoogleLayerOperation : NSOperation
{

}
@property(nonatomic,strong) GoogleTiledLayer *fatherView;
@property(nonatomic,strong)AGSTileKey *tileKey;
@property(nonatomic,strong)NSData *imageData;
@property(nonatomic,assign)GoogleMapLayerType mapType;

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
       andTiledLayer:(GoogleTiledLayer *)fatherView;

@end
