//
//  GoogleTiledLayer.m
//  TestEsri
//
//  Created by liangguowei on 15/11/25.
//  Copyright © 2015年 liangguowei. All rights reserved.
//

#import "GoogleTiledLayer.h"

@implementation GoogleTiledLayer

-(id)initWithMapType:(GoogleMapLayerType)mapType
{
    self =[super init];
    if (self) {
        _spatialReference=[[AGSSpatialReference alloc] initWithWKID:102113];
        _fullEnvelope=[[AGSEnvelope alloc] initWithXmin:-22041257.773878 ymin: -32673939.6727517 xmax:22041257.773878 ymax:20851350.0432886 spatialReference:[[AGSSpatialReference alloc] initWithWKID:102113]];
        
        AGSPoint *origin=[[AGSPoint alloc] initWithX: -20037508.342787 y:20037508.342787 spatialReference:[[AGSSpatialReference alloc] initWithWKID:102113]];
        _tiledInfo1=[[AGSTileInfo alloc] initWithDpi:96 format:@"PNG" lods:[self getLods] origin:origin spatialReference:[[AGSSpatialReference alloc] initWithWKID:102113] tileSize:CGSizeMake(256, 256)];
        
        
        _queue=[[NSOperationQueue alloc] init];
        _queue.maxConcurrentOperationCount=19;
        
        _mapType=mapType;
        
        [self.tileInfo computeTileBounds:_fullEnvelope];
        
        
        [super layerDidLoad];
    }
    
    return self;
}


-(AGSTileInfo *)tileInfo
{
    return _tiledInfo1;
}

-(AGSEnvelope *)fullEnvelope
{
    return _fullEnvelope;
}

-(AGSSpatialReference *)spatialReference
{
    return _spatialReference;
}



-(NSArray *)getLods
{
    NSMutableArray *lods=[NSMutableArray array];
    [lods addObject:[[AGSLOD alloc] initWithLevel:0  resolution:156543.03392800014  scale:   591657527.591555]   ];
    [lods addObject:[[AGSLOD alloc] initWithLevel:1  resolution:78271.516963999937  scale: 295828763.79577702]   ];
    [lods addObject:[[AGSLOD alloc] initWithLevel:2  resolution:39135.758482000092  scale: 147914381.89788899]   ];
    [lods addObject:[[AGSLOD alloc] initWithLevel:3  resolution:19567.879240999919  scale: 73957190.948944002]   ];
    [lods addObject:[[AGSLOD alloc] initWithLevel:4  resolution:9783.9396204999593  scale: 36978595.474472001]   ];
    [lods addObject:[[AGSLOD alloc] initWithLevel:5  resolution:4891.9698102499797  scale: 18489297.737236001]   ];
    [lods addObject:[[AGSLOD alloc] initWithLevel:6  resolution:2445.9849051249898  scale: 9244648.8686180003]   ];
    [lods addObject:[[AGSLOD alloc] initWithLevel:7  resolution:1222.9924525624949  scale: 4622324.4343090001]   ];
    [lods addObject:[[AGSLOD alloc] initWithLevel:8  resolution:611.49622628138     scale:     2311162.217155]   ];
    [lods addObject:[[AGSLOD alloc] initWithLevel:9  resolution:305.748113140558    scale:     1155581.108577]   ];
    [lods addObject:[[AGSLOD alloc] initWithLevel:10 resolution:152.874056570411    scale:      577790.554289]   ];
    [lods addObject:[[AGSLOD alloc] initWithLevel:11 resolution:76.4370282850732    scale:      288895.277144]   ];
    [lods addObject:[[AGSLOD alloc] initWithLevel:12 resolution:38.2185141425366    scale:      144447.638572]   ];
    [lods addObject:[[AGSLOD alloc] initWithLevel:13 resolution:19.1092570712683    scale:       72223.819286]   ];
    [lods addObject:[[AGSLOD alloc] initWithLevel:14 resolution:9.55462853563415    scale:       36111.909643]   ];
    [lods addObject:[[AGSLOD alloc] initWithLevel:15 resolution:4.7773142679493699  scale:       18055.954822]   ];
    [lods addObject:[[AGSLOD alloc] initWithLevel:16 resolution:2.3886571339746849  scale: 9027.9774109999998]   ];
    [lods addObject:[[AGSLOD alloc] initWithLevel:17 resolution:1.1943285668550503  scale: 4513.9887049999998]   ];
    [lods addObject:[[AGSLOD alloc] initWithLevel:18 resolution:0.59716428355981721 scale:        2256.994353]   ];
    [lods addObject: [[AGSLOD alloc] initWithLevel:19 resolution:0.29858214164761665 scale: 1128.4971760000001] ];
    
    return lods;
}


-(void)didFinishedOperation:(GoogleLayerOperation *)operation
{
    [super setTileData:operation.imageData forKey:operation.tileKey];
}


-(void)requestTileForKey:(AGSTileKey *)key
{
    GoogleLayerOperation *operation=[[GoogleLayerOperation alloc] initWithTileKey:key andMapType:_mapType andTiledLayer:self];
    [_queue addOperation:operation];
}


-(void)cancelRequestForKey:(AGSTileKey *)key
{
    
    for (NSOperation *op in [AGSRequestOperation sharedOperationQueue].operations) {
        if ([op isKindOfClass:[GoogleLayerOperation class]]) {
            GoogleLayerOperation *offOp=(GoogleLayerOperation *)op;
            if ([offOp.tileKey isEqualToTileKey:key]) {
                [offOp cancel];
            }
        }
    }
}

@end
