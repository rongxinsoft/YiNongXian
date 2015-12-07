//
//  MeterViewController.m
//  YiNongXian
//
//  Created by 索金铭 on 15/12/4.
//  Copyright © 2015年 bxlt. All rights reserved.
//

#import "MeterViewController.h"
#import "MeterTableViewCell.h"
#import "ArcGis/ArcGis.h"
#import "ChangeTableViewCell.h"
#import "GoogleTiledLayer.h"
#import "Tools.h"
#define kTiledEMapZoneMapServiceURL @"http://service.emapzone.com/arcgis/config=MAPARCGIS&a_k=634a857279d11f4eb8dfda4418dad0676349429f0db9226d9d17d06666242a82f70124097387bff8/rest/services/China-web/MapServer"
@interface MeterViewController ()<AGSMapViewLayerDelegate>
{
    NSInteger geometryType;
    AGSPoint *graphicPoint;
}
@property(nonatomic,strong)IBOutlet AGSMapView *mapView;


@property (nonatomic, strong) AGSGraphicsLayer *graphicsLayer;//保存图层，计算面积和长度
@property (nonatomic, strong) AGSSketchGraphicsLayer *sketchLayer;//可编辑图层
@property (nonatomic, strong) NSMutableArray *lastBuffer;

@property (nonatomic, assign) int bufferDistance;
@end
BOOL isShow;
BOOL hasShow;
@implementation MeterViewController
@synthesize MenuTableView;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mapView.layerDelegate=self;
    
    GoogleTiledLayer *tiledLAyer=[[GoogleTiledLayer alloc] initWithMapType:IMAGE_GOOGLE_MAP];
    [self.mapView addMapLayer:tiledLAyer withName:@"Tiled Layer"];
    
    
    GoogleTiledLayer *tiledLAyers=[[GoogleTiledLayer alloc] initWithMapType:ANNOTATION_GOOGLE_MAP];
    [self.mapView addMapLayer:tiledLAyers withName:@"Tiled Layers"];
    
    // //设定地图初始化显示范围为中国
    AGSEnvelope *chinaEnv  = [AGSEnvelope envelopeWithXmin:7791031.00
                                                     ymin:2205307.00 xmax:15138769.00 ymax:7283172.00
                                         spatialReference:self.mapView.spatialReference]; [self.mapView zoomToEnvelope:chinaEnv animated:YES];
    
    
    self.graphicsLayer = [AGSGraphicsLayer graphicsLayer];
    [self.mapView addMapLayer:self.graphicsLayer withName:@"Graphics Layer"];
   
    
    self.lastBuffer=[NSMutableArray array];
    
    
   
    
    
  
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma marl tableView delegata
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==2) {
        if (isShow==NO) {
            return 0;
        }
        return 6;
    }else{
        return 0;
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        static NSString *CellIdentifier = @"ChangeTableViewCell";
        ChangeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil)
        {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"ChangeTableViewCell" owner:self options:nil] objectAtIndex:0];
        }
        cell.handTap.tag=20;
        cell.DragTap.tag=26;
        [cell.handTap addTarget:self action:@selector(drawAction:) forControlEvents:UIControlEventTouchUpInside];
         [cell.DragTap addTarget:self action:@selector(drawAction:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    static NSString *CellIdentifier = @"MeterTableViewCell";
    MeterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MeterTableViewCell" owner:self options:nil] objectAtIndex:0];
    }
    NSArray * ary=@[@"中心十字打点",@"定位位置打点",@"撤销上一点",@"闭合成形",@"确定"];
    [cell.drawTap setTag:indexPath.row+20];
    [cell.drawTap addTarget:self action:@selector(drawAction:) forControlEvents:UIControlEventTouchUpInside];
   [cell.drawTap setTitle:ary[indexPath.row-1] forState: UIControlStateNormal];
    return cell;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    if (section!=0) {
        UIView * view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, 50)];
        UIButton * Locbtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 200, 49)];
         Locbtn.tag=section+10;
        [Locbtn addTarget:self action:@selector(sectionTap: ) forControlEvents:UIControlEventTouchUpInside];
        UIView * lingView=[[UIView alloc]initWithFrame:CGRectMake(0, 49, 200, 1)];
        lingView.backgroundColor=AppLineColor;

        NSString * title;
        if (section==1) {
            title=@"删除选中";
        }else
        {
            title=@"精准采集";
        }
        [Locbtn setTitle:title forState:UIControlStateNormal];
        [Locbtn setTitleColor:AppMainColor forState:UIControlStateNormal];
        [view addSubview:Locbtn];
        [view addSubview:lingView];
        return view;
    }
    else{
    UIView * view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, 50)];
    UIButton * Locbtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, (view.frame.size.width-1)/2, 48)];
    Locbtn.tag=section+10;
    [Locbtn setTitle:@"定位" forState:UIControlStateNormal];
    [Locbtn setTitleColor:AppMainColor forState:UIControlStateNormal];
    [Locbtn addTarget:self action:@selector(sectionTap: ) forControlEvents:UIControlEventTouchUpInside];
    UIView * lineView=[[UIView alloc]initWithFrame:CGRectMake((view.frame.size.width-2)/2, 1,1 ,48 )];
    lineView.backgroundColor=AppLineColor;
    UIButton * allbtn=[[UIButton alloc]initWithFrame:CGRectMake(lineView.frame.origin.x+1, 0, (view.frame.size.width-1)/2, 50)];
    allbtn.tag=15;
    [allbtn setTitle:@"全幅" forState:UIControlStateNormal];
    [allbtn setTitleColor:AppMainColor forState:UIControlStateNormal];
        [allbtn addTarget:self action:@selector(sectionTap: ) forControlEvents:UIControlEventTouchUpInside];
    UIView * spaceLine=[[UIView alloc]initWithFrame:CGRectMake(0, 49, 200, 1)];
    spaceLine.backgroundColor=AppLineColor;
    [view addSubview:Locbtn];
    [view addSubview:lineView];
    [view addSubview:spaceLine];
    [view addSubview:allbtn];
    return view;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}
#pragma cell 点击方法
-(void)drawAction:(UIButton *)sender
{
     self.centerImh.hidden=YES;
    long tag=sender.tag-20;
    switch (tag) {//手动打点
        case 0:
        {
            self.bagView.hidden=YES;
        }
            break;
        case 1: //中心十字打点
        {
            self.centerImh.hidden=NO;
            self.sketchLayer.geometry = [[AGSMutablePoint alloc] initWithSpatialReference:self.mapView.spatialReference];
            AGSGraphic *graphic;
            //AGSPoint *graphicPoint;
            NSMutableDictionary *graphicAttributes;
            //            AGSMutablePolyline *  mut=[AGSMutablePolyline]
            AGSSimpleMarkerSymbol *myMarkerSymbol = [AGSSimpleMarkerSymbol simpleMarkerSymbolWithColor:[UIColor colorWithRed:0.0 green:1.0 blue:0.0 alpha:0.25]];
            graphicPoint=self.mapView.visibleAreaEnvelope.center;
            graphic = [AGSGraphic graphicWithGeometry:graphicPoint symbol:myMarkerSymbol attributes:graphicAttributes ];
            [self.sketchLayer addGraphic:graphic];
       
        }
            break;
        case 2: //定位位置打点
           
            break;
        case 3://撤销上一点
            [_sketchLayer selectLastVertex];
            [_sketchLayer removeSelectedVertex];
            break;
        case 4://闭合成形
        {
            [self area];
        }
            break;
        case 5://确定
            break;
        case 6://拖动打点
        {
            self.bagView.hidden=NO;
        }
        default:
            break;
    }
}



#pragma mark 组头点击方法
-(void)sectionTap:(UIButton *)sender
{
    long tag=sender.tag-10;
    switch (tag) {
            case 0:
        {
                [self.mapView.locationDisplay startDataSource];
               self.mapView.locationDisplay.autoPanMode = AGSLocationDisplayAutoPanModeDefault;
        }
            //定位
            break;
            case 1:
            //删除选中
             break;
            case 2:
             self.sketchLayer.geometry = [[AGSMutablePolygon alloc] initWithSpatialReference:self.mapView.spatialReference];
            if (isShow==NO) {
                isShow=YES;
            }else
            {
                isShow=NO;
            }
            [self.MenuTableView reloadData];
            break;
            case 5:
            //全幅
            {
           //设定地图初始化显示范围为中国
            AGSEnvelope *chinaEnv  = [AGSEnvelope envelopeWithXmin:7791031.00
                                                              ymin:2205307.00 xmax:15138769.00 ymax:7283172.00
                                                  spatialReference:self.mapView.spatialReference]; [self.mapView zoomToEnvelope:chinaEnv animated:YES];
            }
            break;
        default:
            break;
    }
}
- (void)area {
    AGSGeometry* sketchGeometry = [self.sketchLayer.geometry copy];
    
    //Geometry 转换为json数据，  也可以通过后台传过来的数据点拼装程json数据，逆向转换为Geometry
    NSDictionary *dic =[sketchGeometry encodeToJSON];
    NSLog(@"%@",[sketchGeometry encodeToJSON]);
    /**
     *  自定义面的样式
     */
    AGSSimpleFillSymbol *innerSymbol = [AGSSimpleFillSymbol simpleFillSymbol];
    innerSymbol.color = [[UIColor greenColor] colorWithAlphaComponent:0.40];
    innerSymbol.outline.color = [UIColor yellowColor];
    // Create the buffer graphics using the geometry engine
    AGSGeometryEngine *geometryEngine = [AGSGeometryEngine defaultGeometryEngine];
    AGSGeometry *newGeometry = [geometryEngine bufferGeometry:sketchGeometry byDistance:_bufferDistance];
    AGSGraphic *newGraphic = [AGSGraphic graphicWithGeometry:newGeometry symbol:innerSymbol attributes:nil infoTemplateDelegate:self];
    [self.lastBuffer addObject:newGraphic];
    [self.graphicsLayer addGraphic:newGraphic];
        /**
        *  面上的面积
        */
    double a=  fabsl([geometryEngine areaOfGeometry:sketchGeometry]);
    a=[Tools SquareTurn:a];
    AGSTextSymbol *textSymbol= [AGSTextSymbol textSymbolWithText:[NSString stringWithFormat:@"%lf亩",a]color:[UIColor redColor]];
    textSymbol.fontFamily = @"Heiti SC";
    AGSGraphic* graphic2 = [AGSGraphic graphicWithGeometry:sketchGeometry symbol:textSymbol attributes:nil];
    [self.graphicsLayer addGraphic:graphic2];
    [self.sketchLayer clear];
}

#pragma mark AGSMapViewLayerDelegate methods

-(void) mapViewDidLoad:(AGSMapView*)mapView {
    // Enable location display on the map
    graphicPoint=self.mapView.visibleAreaEnvelope.center;
    self.sketchLayer = [AGSSketchGraphicsLayer graphicsLayer];
    self.sketchLayer.geometry = [[AGSMutablePoint alloc] initWithSpatialReference:self.mapView.spatialReference];
    [self.mapView addMapLayer:self.sketchLayer withName:@"Sketch layer"];
    self.mapView.touchDelegate = self.sketchLayer;
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc]
                                                    initWithTarget:self
                                                    action:@selector(handlePan:)];
    [self.mapView addGestureRecognizer:panGestureRecognizer];
}

-(void)handlePan:(id)sender
{
    self.centerImh.hidden=NO;
    self.sketchLayer.geometry = [[AGSMutablePoint alloc] initWithSpatialReference:self.mapView.spatialReference];
    AGSGraphic *graphic;
    NSMutableDictionary *graphicAttributes;
    AGSSimpleMarkerSymbol *myMarkerSymbol = [AGSSimpleMarkerSymbol simpleMarkerSymbolWithColor:[UIColor colorWithRed:0.0 green:1.0 blue:0.0 alpha:0.25]];
    AGSMutablePolyline* poly = [[AGSMutablePolyline alloc] initWithSpatialReference:self.mapView.spatialReference];
    //添加轨迹
    [poly addPathToPolyline];
    [poly addPointToPath:graphicPoint];
    //往轨迹中添加节点
    [poly addPointToPath:[AGSPoint pointWithX:10 y:10 spatialReference:nil]];
    [poly addPointToPath:[AGSPoint pointWithX:30 y:10 spatialReference:nil]];
    [poly addPointToPath:[AGSPoint pointWithX:30 y:30 spatialReference:nil]];
    //往轨迹中添加节点
    graphic = [AGSGraphic graphicWithGeometry:poly symbol:myMarkerSymbol attributes:graphicAttributes];
    [self.sketchLayer addGraphic:graphic];
    
}
#pragma 搜索

- (IBAction)searchTap:(id)sender {
    if (hasShow==NO) {
        [self.searchBtn setTitle:@"收起" forState:UIControlStateNormal];
         self.searchBar.hidden=NO;
        hasShow=YES;
    }else
    {
        [self.searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
        self.searchBar.hidden=YES;
        hasShow=NO;
    }
}
//经纬度转墨卡托
-(CGPoint )lonLat2Mercator:(CGPoint ) lonLat
{
    CGPoint  mercator;
    double x = lonLat.x *20037508.34/180;
    double y = log(tan((90+lonLat.y)*M_PI/360))/(M_PI/180);
    y = y *20037508.34/180;
    mercator.x = x;
    mercator.y = y;
    return mercator ;
}
- (IBAction)moveTap:(UIButton *)sender {
    //上下左右
    switch (sender.tag-50) {
        case 0:
        {
            // //设定地图初始化显示范围为中国
            AGSEnvelope *chinaEnv  = [AGSEnvelope envelopeWithXmin:self.mapView.visibleAreaEnvelope.xmin
                                                              ymin:self.mapView.visibleAreaEnvelope.ymin+100 xmax:self.mapView.visibleAreaEnvelope.xmax
                                                              ymax:self.mapView.visibleAreaEnvelope.ymax+100
                                                  spatialReference:self.mapView.spatialReference]; [self.mapView zoomToEnvelope:chinaEnv animated:YES];
        }
            break;
        case 1:
        {
            AGSEnvelope *chinaEnv  = [AGSEnvelope envelopeWithXmin:self.mapView.visibleAreaEnvelope.xmin
                                                              ymin:self.mapView.visibleAreaEnvelope.ymin-100 xmax:self.mapView.visibleAreaEnvelope.xmax
                                                              ymax:self.mapView.visibleAreaEnvelope.ymax-100
                                                  spatialReference:self.mapView.spatialReference]; [self.mapView zoomToEnvelope:chinaEnv animated:YES];
        }
            break;
        case 2:
        {
            AGSEnvelope *chinaEnv  = [AGSEnvelope envelopeWithXmin:self.mapView.visibleAreaEnvelope.xmin-100
                                                              ymin:self.mapView.visibleAreaEnvelope.ymin xmax:self.mapView.visibleAreaEnvelope.xmax-100
                                                              ymax:self.mapView.visibleAreaEnvelope.ymax
                                                  spatialReference:self.mapView.spatialReference]; [self.mapView zoomToEnvelope:chinaEnv animated:YES];
               }
            break;
        case 3:
        {
            //设定地图初始化显示范围为中国
            AGSEnvelope *chinaEnv  = [AGSEnvelope envelopeWithXmin:self.mapView.visibleAreaEnvelope.xmin+100
                                                              ymin:self.mapView.visibleAreaEnvelope.ymin xmax:self.mapView.visibleAreaEnvelope.xmax+100
                                                              ymax:self.mapView.visibleAreaEnvelope.ymax
                                                  spatialReference:self.mapView.spatialReference]; [self.mapView zoomToEnvelope:chinaEnv animated:YES];
        }
            break;
        default:
            break;
    }
    
}
@end
