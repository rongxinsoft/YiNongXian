//
//  WaterCameraViewController.m
//  YiNongXian
//
//  Created by 索金铭 on 15/12/1.
//  Copyright © 2015年 bxlt. All rights reserved.
//

#import "WaterCameraViewController.h"
#import "WaterCollectionViewCell.h"
#import "UIImage+Water.h"
#import "MLCameraViewController.h"
#import "WarterDetailViewController.h"
@interface WaterCameraViewController ()
@property(strong,nonatomic)NSMutableArray * photosAry;
@end

@implementation WaterCameraViewController
@synthesize pickerConttroller,photosAry;
- (void)viewDidLoad {
    [super viewDidLoad];

    
    NSString * lat=  [[NSUserDefaults standardUserDefaults]objectForKey:@"jing"];
    NSString * lon=[[NSUserDefaults standardUserDefaults]objectForKey:@"wei"];
    if ([lat isEqualToString:@""]&&[lon isEqualToString:@""]) {
        [WCAlertView showAlertWithTitle:@"提示" message:@"水印相机需要定位服务，请您在设置中打开定位服务" customizationBlock:nil completionBlock:nil cancelButtonTitle:@"OK " otherButtonTitles:nil, nil];
    }
    
    [self.CollectionView registerClass:[WaterCollectionViewCell class]forCellWithReuseIdentifier:@"WaterCollectionViewCell"];
    [self setCollectionViewFlowLayout];
    [self setNav];
}
-(void)viewWillAppear:(BOOL)animated
{
    //获取沙盒目录图片
    [self getNSDocument];
}
-(void)getNSDocument
{
    NSArray  *paths  =  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *docDir = [paths objectAtIndex:0];
    
    NSArray *fileList = [[[NSFileManager defaultManager] contentsOfDirectoryAtPath:docDir error:nil]pathsMatchingExtensions:[NSArray arrayWithObject:@"png"]];
    photosAry=[[NSMutableArray alloc]initWithCapacity:100];
    for (int i=0; i<fileList.count; i++) {
        NSString* str=[NSString stringWithFormat:@"%@/%@",docDir,fileList [i]];
        [photosAry addObject:str];
    }
    [self.CollectionView reloadData];
}
#pragma mark UIcollectionDelegata
//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return photosAry.count;
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
    
    cell.photo_Img.image=[[UIImage alloc] initWithContentsOfFile:photosAry[indexPath.row]];
  
    UILongPressGestureRecognizer * longPressGr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressToDo:)];
    longPressGr.minimumPressDuration = 1.0;
    
   
    [cell.photo_Img addGestureRecognizer:longPressGr];
    
    UIView *singleTapView = [longPressGr view];
    singleTapView.tag = indexPath.row;
    cell.photo_Img.userInteractionEnabled=YES;
    cell.backgroundColor = [UIColor colorWithRed:((10 * indexPath.row) / 255.0) green:((20 * indexPath.row)/255.0) blue:((30 * indexPath.row)/255.0) alpha:1.0f];
    return cell;
}
#pragma mark-删除
-(void)longPressToDo:(id)sender
{
    UILongPressGestureRecognizer *singleTap = (UILongPressGestureRecognizer *)sender;
    int j=(int)[singleTap view].tag;
    if (singleTap.state==UIGestureRecognizerStateBegan) {
        [WCAlertView showAlertWithTitle:@"删除操作" message:@"确定删除该图片" customizationBlock:nil completionBlock:^(NSUInteger buttonIndex, WCAlertView *alertView)
         {
             if (buttonIndex==alertView.cancelButtonIndex) {
             }else
             {
                 NSFileManager* fileManager=[NSFileManager defaultManager];
                 
                 BOOL blHave=[[NSFileManager defaultManager] fileExistsAtPath:photosAry[j]];
                 if (!blHave) {
                     NSLog(@"no  have");
                     return ;
                 }else {
                     BOOL blDele= [fileManager removeItemAtPath:photosAry[j] error:nil];
                     if (blDele) {
                         [SVProgressHUD showSuccessWithStatus:@"删除成功"];
                         [self getNSDocument];
                         [self.CollectionView reloadData];
                         return;
                     }else {
                         [SVProgressHUD showErrorWithStatus:@"删除失败"];
                     }
                     return;
                 }
             }
         } cancelButtonTitle:@"取消" otherButtonTitles:@"删除", nil];
    }
}
#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(200, 150);
}


- (UICollectionViewFlowLayout *)setCollectionViewFlowLayout
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.sectionInset            = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.minimumInteritemSpacing = 0.0;
    layout.minimumLineSpacing      = 0.0;
    
    return layout;
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    WarterDetailViewController * WDVC=[[WarterDetailViewController alloc]init];
     WDVC.photosAry=photosAry;
     WDVC.num=(int)indexPath.row;
    [self presentViewController:WDVC animated:YES completion:nil];

}
//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

#pragma mark-Nav
-(void)setNav
{
      self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"拍照" style:UIBarButtonItemStyleDone target:self action:@selector(StartCamer)];
}
#pragma  mark-Camer
-(void)StartCamer
{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
    {
        pickerConttroller = [[UIImagePickerController alloc] init];
        
        pickerConttroller.delegate = self;
        //设置拍照后的图片可被编辑
        pickerConttroller.allowsEditing = NO;
        pickerConttroller.sourceType = sourceType;
        [self presentModalViewController:pickerConttroller animated:YES];
    }else
    {
        [SVProgressHUD showInfoWithStatus:@"相机功能无法使用"];
    }
 
}

//当选择一张图片后进入这里
-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info

{
    //时间
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    
    
    NSDate* dateCap = [NSDate date];
    NSDateFormatter* formatters = [[NSDateFormatter alloc] init];
    [formatters setDateFormat:@"yyyy年MM月dd日HH点MM分SS秒"];
    NSString* timestr = [formatters stringFromDate:dateCap];
    //获得图片
    UIImage *baseImage = [info objectForKey:UIImagePickerControllerOriginalImage];

    NSString * lat=  [[NSUserDefaults standardUserDefaults]objectForKey:@"jing"];
    NSString * lon=[[NSUserDefaults standardUserDefaults]objectForKey:@"wei"];
    NSArray * markAry=@[USERNAME,lat,lon,@"WI-FI",timestr];
     baseImage =[baseImage imageWithStringWaterMark:markAry color:[UIColor redColor] font:[UIFont systemFontOfSize:50]];
    UIImage * img=  [baseImage fixOrientation:baseImage];//图片反转
    
    NSData * newImg=  UIImageJPEGRepresentation(img, 0.0);
    long length=[newImg length]/1024; 
     UIImage * new=[[UIImage alloc]initWithData:newImg];
    
    
    
    
    NSDate* date = [NSDate date];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMddHHMMSS"];
    NSString* str = [formatter stringFromDate:date];
    
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"pic_%@.png", str]];   // 保存文件的名称
    [UIImagePNGRepresentation(new)writeToFile: filePath    atomically:YES];
    if ([UIImagePickerController isSourceTypeAvailable:
         UIImagePickerControllerSourceTypePhotoLibrary])  {
        // Set source to the Photo Library
        picker.sourceType =UIImagePickerControllerSourceTypePhotoLibrary;
        
        if (pickerConttroller==picker)  {
        
            //**继续回到take camera的页面
            pickerConttroller.sourceType =    UIImagePickerControllerSourceTypeCamera;
        } else {
            [picker dismissViewControllerAnimated:YES completion:nil];
        }
    }
    
 }
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
