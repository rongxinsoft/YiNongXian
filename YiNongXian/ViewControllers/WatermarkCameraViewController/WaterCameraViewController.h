//
//  WaterCameraViewController.h
//  YiNongXian
//
//  Created by 索金铭 on 15/12/1.
//  Copyright © 2015年 bxlt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WaterCameraViewController : UIViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *CollectionView;
@property(strong,nonatomic) UIImagePickerController *pickerConttroller;
@end
