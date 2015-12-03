//
//  MapViewController.m
//  YiNongXian
//
//  Created by 索金铭 on 15/11/27.
//  Copyright © 2015年 bxlt. All rights reserved.
//

#import "MapViewController.h"
#import "ArcGis/ArcGis.h"
#import "GoogleTiledLayer.h"
#define kTiledEMapZoneMapServiceURL @"http://service.emapzone.com/arcgis/config=MAPARCGIS&a_k=634a857279d11f4eb8dfda4418dad0676349429f0db9226d9d17d06666242a82f70124097387bff8/rest/services/China-web/MapServer"

@interface MapViewController ()<AGSMapViewLayerDelegate>
@property(nonatomic,strong)IBOutlet AGSMapView *mapView;
@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mapView.layerDelegate=self;
    
    GoogleTiledLayer *tiledLAyer=[[GoogleTiledLayer alloc] initWithMapType: VECTOR_GOOGLE_MAP];
    [self.mapView addMapLayer:tiledLAyer withName:@"Tiled Layer"];
    
    
    //    self.mapView.layerDelegate = self;
    
    //    //create an instance of a tiled map service layer
    //    AGSTiledMapServiceLayer *tiledLayer = [[AGSTiledMapServiceLayer alloc] initWithURL:[NSURL URLWithString:@"http://services.arcgisonline.com/ArcGIS/rest/services/World_Topo_Map/MapServer"]];
    //
    //    //Add it to the map view
    //    [self.mapView addMapLayer:tiledLayer withName:@"Tiled Layer"];
    
    
    //添加代码
    //基础底图,使用的是北京捷泰科技有限公司􏰁供的在线地图,更多地图请登陆 ArcGIS Online 中国网 址查询(http://www.arcgisonline.cn)
    //    NSString *str_URL = @"http://www.arcgisonline.cn/ArcGIS/rest/services/ChinaOnlineCommunity/MapServer";
    //    NSURL *url_Tiled = [NSURL URLWithString:str_URL];
    //    AGSTiledMapServiceLayer *tiledLyr = [AGSTiledMapServiceLayer tiledMapServiceLayerWithURL:url_Tiled];
    //    [self.mapView addMapLayer:tiledLyr withName:@"Tiled Layer"];
    //
    //动态图层,使用ArcGIS Online的全球人口数据
    //    NSString *str_URL_1 =
    //    @"http://sampleserv er1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Population_W orld/Map Server";
    //    NSURL *url_Dynamic = [NSURL URLWithString:str_URL_1];
    //    AGSDynamicMapServiceLayer *dynamicLyr = [AGSDynamicMapServiceLayer dynamicMapServiceLayerWithURL:url_Dynamic];
    //    UIView<AGSLayerView> *dynamicLyrView = [self.mapView addMapLayer:dynamicLyr withName:@"Population Layer"];
    //设置动态图层透明度 dynamicLyrView.alpha = 0.3;
    
    
    
    
    
    
    //    AGSTiledMapServiceLayer *tiledLayer = [[AGSTiledMapServiceLayer alloc] initWithURL:[NSURL URLWithString:kTiledEMapZoneMapServiceURL ]];
    //    [self.mapView addMapLayer:tiledLayer withName:@"Tiled Layer3"];
    //    AGSGoogleMapLayer * googleMapLayer = [[AGSGoogleMapLayer alloc] initWithGoogleMapSchema];
    //    //	NSURL *mapUrl = [NSURL URLWithString:@"http://services.arcgisonline.com/ArcGIS/rest/services/World_Street_Map/MapServer"];
    //    //	AGSTiledMapServiceLayer *tiledLyr = [AGSTiledMapServiceLayer tiledMapServiceLayerWithURL:mapUrl];
    //    [self.mapView addMapLayer:googleMapLayer withName:@"Tiled Layer"];
    
    //	AGSSpatialReference *sr = [AGSSpatialReference spatialReferenceWithWKID:102100];
    //	AGSEnvelope *env = [AGSEnvelope envelopeWithXmin:-13626513.829723023
    //												ymin:4549088.827634182
    //												xmax:-13626131.64458163
    //												ymax:4549638.218774935
    //									spatialReference:sr];
    //	[self.mapView zoomToEnvelope:env animated:YES];
    /* ##################################################### */
    AGSEnvelope *env = [AGSEnvelope envelopeWithXmin:12836931.118569 ymin:4773566.12743336 xmax:13092266.2487341 ymax:5033121.81554815 spatialReference:[AGSSpatialReference spatialReferenceWithWKID:102113]];
    [self.mapView zoomToEnvelope:env animated:YES];
    
    
    
    // //设定地图初始化显示范围为中国
    AGSEnvelope *chinaEnv = [AGSEnvelope envelopeWithXmin:7800000.00
                                                     ymin:44000.00 xmax:15600000.00 ymax:7500000.00
                                         spatialReference:self.mapView.spatialReference]; [self.mapView zoomToEnvelope:chinaEnv animated:YES];
    // Do any additional setup after loading the view, typically from a nib.
}


#pragma mark AGSMapViewLayerDelegate methods

-(void) mapViewDidLoad:(AGSMapView*)mapView {
    
    // Enable location display on the map
    [self.mapView.locationDisplay startDataSource];
    self.mapView.locationDisplay.autoPanMode = AGSLocationDisplayAutoPanModeDefault;
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
