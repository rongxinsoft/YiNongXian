//
//  ImageDataViewController.m
//  YiNongXian
//
//  Created by 索金铭 on 15/11/27.
//  Copyright © 2015年 bxlt. All rights reserved.
//

#import "ImageDataViewController.h"
#import "WaterCollectionViewCell.h"
#import "TouchPropagatedScrollView.h"
#import "HomeViewController.h"
#import "QHCommonUtil.h"
#define MENU_HEIGHT 40
#define MENU_BUTTON_WIDTH  180

#define MIN_MENU_FONT  13.f
#define MAX_MENU_FONT  18.f

@interface ImageDataViewController ()<UIScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>
{
    UIView *_navView;
    UIView *_topNaviV;
    UIScrollView *_scrollV;
    
    TouchPropagatedScrollView *_navScrollV;
    
    float _startPointX;
    UIView *_selectTabV;
}
@property(assign,nonatomic)int pageNum;

@end

@implementation ImageDataViewController
@synthesize pageNum;
- (void)viewDidLoad
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    _topNaviV = [[UIView alloc] initWithFrame:CGRectMake(0, _navView.frame.size.height + _navView.frame.origin.y, DeviceWidth, MENU_HEIGHT)];
    _topNaviV.backgroundColor = RGBA(236.f, 236.f, 236.f, 1);
    [self.view addSubview:_topNaviV];
    
    _scrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, _topNaviV.frame.origin.y + _topNaviV.frame.size.height, DeviceWidth, DeviceHeight - _topNaviV.frame.size.height)];
    [_scrollV setPagingEnabled:YES];
    [_scrollV setShowsHorizontalScrollIndicator:NO];
    [self.view insertSubview:_scrollV belowSubview:self.view];
    _scrollV.delegate = self;
    // [_scrollV.panGestureRecognizer addTarget:self action:@selector(scrollHandlePan:)];
    
    _selectTabV = [[UIView alloc] initWithFrame:CGRectMake(0, _scrollV.frame.origin.y - _scrollV.frame.size.height, _scrollV.frame.size.width, _scrollV.frame.size.height)];
    [_selectTabV setBackgroundColor:RGBA(236.f, 236.f, 236.f, 1)];
    [_selectTabV setHidden:YES];
    [self.view insertSubview:_selectTabV belowSubview:self.view];
    [self createTwo];
}

- (void)createTwo
{
    float btnW = 30;
    NSArray *arT = @[@"全部(0)｜", @"投保单(0)｜", @"投保单的清单(0)｜", @"验标、查勘照片(0)｜", @"地号图／地形图／平面图(0)｜", @"公示照片(0)｜", @"被保险人信息(0) ｜", @"全属资料(0)｜", @"内部审批材料及其他(0)｜", @"反洗钱材料(0)|"];
    _navScrollV = [[TouchPropagatedScrollView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth - btnW, MENU_HEIGHT)];
    [_navScrollV setShowsHorizontalScrollIndicator:NO];
    for (int i = 0; i < [arT count]; i++)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake(MENU_BUTTON_WIDTH * i, 0, MENU_BUTTON_WIDTH, MENU_HEIGHT)];
        [btn setTitle:[arT objectAtIndex:i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.tag = i + 1;
        if(i==0)
        {
            [self changeColorForButton:btn red:1];
            btn.titleLabel.font = [UIFont systemFontOfSize:MAX_MENU_FONT];
        }else
        {
            btn.titleLabel.font = [UIFont systemFontOfSize:MIN_MENU_FONT];
            [self changeColorForButton:btn red:0];
        }
        [btn addTarget:self action:@selector(actionbtn:) forControlEvents:UIControlEventTouchUpInside];
        [_navScrollV addSubview:btn];
    }
    [_navScrollV setContentSize:CGSizeMake(MENU_BUTTON_WIDTH * [arT count], MENU_HEIGHT)];
    [_topNaviV addSubview:_navScrollV];
    [self addView2Page:_scrollV count:[arT count] frame:CGRectZero];
}

- (void)addView2Page:(UIScrollView *)scrollV count:(NSUInteger)pageCount frame:(CGRect)frame
{
    for (int i = 0; i < pageCount; i++)
    {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(scrollV.frame.size.width * i, 0, scrollV.frame.size.width, scrollV.frame.size.height)];
        view.tag = i + 1;
        view.userInteractionEnabled = YES;
        UITapGestureRecognizer *singleTapRecognizer = [[UITapGestureRecognizer alloc] init];
        singleTapRecognizer.numberOfTapsRequired = 1;
        [view addGestureRecognizer:singleTapRecognizer];
        
        [self initPageView:view andPage:i];
        
        [scrollV addSubview:view];
    }
    [scrollV setContentSize:CGSizeMake(scrollV.frame.size.width * pageCount, scrollV.frame.size.height)];
}
#pragma mark-   PAGE VIew
- (void)initPageView:(UIView *)view andPage:(int)page
{
    
    UICollectionViewFlowLayout * flowLayout= [self setCollectionViewFlowLayout];
    UICollectionView * colView  =[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, DeviceWidth, DeviceHeight) collectionViewLayout:flowLayout];
    colView.tag=page+30;
    colView.backgroundColor=[UIColor whiteColor];
    colView.delegate=self;
    colView.dataSource=self;
     [colView registerClass:[WaterCollectionViewCell class]forCellWithReuseIdentifier:@"WaterCollectionViewCell"];
    [view addSubview:colView];
}


- (UICollectionViewFlowLayout *)setCollectionViewFlowLayout
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.sectionInset            = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.minimumInteritemSpacing = 0.0;
    layout.minimumLineSpacing      = 0.0;
    
    return layout;
}
#pragma mark UIcollectionDelegata
//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 1;
}
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    static NSString * CellIdentifier = @"WaterCollectionViewCell";
    WaterCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
  //  cell.photo_Img.image=[[UIImage alloc] initWithContentsOfFile:photosAry[indexPath.row]];
    NSLog(@"#######%ld",collectionView.tag);
    if (collectionView.tag!=30) {
        if (indexPath.row==0) {
            cell.photo_Img.image=[UIImage imageNamed:@"list"];
            cell.photo_Img.userInteractionEnabled=YES;
            UITapGestureRecognizer* singleRecognizer;
            singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(SingleTap:)];
            //点击的次数
            singleRecognizer.numberOfTapsRequired = 1; // 单击
            [cell.photo_Img addGestureRecognizer:singleRecognizer];
            
            UIView *singleTapView = [singleRecognizer view];
            singleTapView.tag = collectionView.tag;
        }
    }
   
   
    cell.backgroundColor = [UIColor colorWithRed:((10 * indexPath.row) / 255.0) green:((20 * indexPath.row)/255.0) blue:((30 * indexPath.row)/255.0) alpha:1.0f];
    return cell;
}
-(void)SingleTap:(id)sender
{
    UITapGestureRecognizer *singleTap = (UITapGestureRecognizer *)sender;
    int j=(int)[singleTap view].tag;
    [self.navigationController pushViewController:[[HomeViewController alloc]init] animated:YES];
    
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(200, 150);
}






- (void)changeView:(float)x
{
    float xx = x * (MENU_BUTTON_WIDTH / self.view.frame.size.width);
    
    float startX = xx;
    float endX = xx + MENU_BUTTON_WIDTH;
    int sT = (x)/_scrollV.frame.size.width + 1;
    
    if (sT <= 0)
    {
        return;
    }
    UIButton *btn = (UIButton *)[_navScrollV viewWithTag:sT];
    float percent = (startX - MENU_BUTTON_WIDTH * (sT - 1))/MENU_BUTTON_WIDTH;
    float value = [QHCommonUtil lerp:(1 - percent) min:MIN_MENU_FONT max:MAX_MENU_FONT];
    btn.titleLabel.font = [UIFont systemFontOfSize:value];
    [self changeColorForButton:btn red:(1 - percent)];
    
    if((int)xx%MENU_BUTTON_WIDTH == 0)
        return;
    UIButton *btn2 = (UIButton *)[_navScrollV viewWithTag:sT + 1];
    float value2 = [QHCommonUtil lerp:percent min:MIN_MENU_FONT max:MAX_MENU_FONT];
    btn2.titleLabel.font = [UIFont systemFontOfSize:value2];
    [self changeColorForButton:btn2 red:percent];
}

- (void)changeColorForButton:(UIButton *)btn red:(float)nRedPercent
{
    float value = [QHCommonUtil lerp:nRedPercent min:0 max:212];
    [btn setTitleColor:RGBA(value,25,38,1) forState:UIControlStateNormal];
}

#pragma mark - action

- (void)actionbtn:(UIButton *)btn
{
    [_scrollV scrollRectToVisible:CGRectMake(_scrollV.frame.size.width * (btn.tag - 1), _scrollV.frame.origin.y, _scrollV.frame.size.width, _scrollV.frame.size.height) animated:YES];
    
    float xx = _scrollV.frame.size.width * (btn.tag - 1) * (MENU_BUTTON_WIDTH / self.view.frame.size.width) - MENU_BUTTON_WIDTH;
    [_navScrollV scrollRectToVisible:CGRectMake(xx, 0, _navScrollV.frame.size.width, _navScrollV.frame.size.height) animated:YES];
}
#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    _startPointX = scrollView.contentOffset.x;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self changeView:scrollView.contentOffset.x];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    float xx = scrollView.contentOffset.x * (MENU_BUTTON_WIDTH / self.view.frame.size.width) - MENU_BUTTON_WIDTH;
    [_navScrollV scrollRectToVisible:CGRectMake(xx, 0, _navScrollV.frame.size.width, _navScrollV.frame.size.height) animated:YES];
}


@end
