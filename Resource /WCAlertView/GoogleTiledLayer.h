//
//  GoogleTiledLayer.h
//  TestEsri
//
//  Created by liangguowei on 15/11/25.
//  Copyright © 2015年 liangguowei. All rights reserved.
//

#import <ArcGIS/ArcGIS.h>
#import "MapLayerTypes.h"
#import "GoogleLayerOperation.h"

@interface GoogleTiledLayer : AGSTiledServiceLayer
{
    AGSSpatialReference *_spatialReference;
    AGSEnvelope *_fullEnvelope;
    AGSTileInfo *_tiledInfo1;
    
    GoogleMapLayerType _mapType;
    
    NSOperationQueue *_queue;
}

-(id)initWithMapType:(GoogleMapLayerType)mapType;

-(void)didFinishedOperation:(GoogleLayerOperation *)operation;

@end
