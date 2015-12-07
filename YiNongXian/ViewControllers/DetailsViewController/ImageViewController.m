//
//  ImageViewController.m
//  LLSimpleCameraExample
//
//  Created by Ömer Faruk Gül on 15/11/14.
//  Copyright (c) 2014 Ömer Faruk Gül. All rights reserved.
//

#import "ImageViewController.h"
#import "ViewUtils.h"
#import "UIImage+Crop.h"

@interface ImageViewController ()
@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UILabel *infoLabel;
@property (strong, nonatomic) UIButton *cancelButton;
@end

@implementation ImageViewController

- (instancetype)initWithImage:(UIImage *)image {
    self = [super initWithNibName:nil bundle:nil];
    if(self) {
        _image = image;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageView.backgroundColor = [UIColor blackColor];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.size.width,  self.view.size.height-50)];
   // self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.imageView.backgroundColor = [UIColor clearColor];
    self.imageView.image = self.image;
    [self.view addSubview:self.imageView];
    
//    NSString *info = [NSString stringWithFormat:@"Size: %@  -  Orientation: %ld", NSStringFromCGSize(self.image.size), (long)self.image.imageOrientation];
//    
//    self.infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
//    self.infoLabel.backgroundColor = [[UIColor darkGrayColor] colorWithAlphaComponent:0.7];
//    self.infoLabel.textColor = [UIColor whiteColor];
//    self.infoLabel.font = [UIFont fontWithName:@"AvenirNext-Regular" size:13];
//    self.infoLabel.textAlignment = NSTextAlignmentCenter;
//    self.infoLabel.text = info;
//    [self.view addSubview:self.infoLabel];
    UIView * sureView=[[UIView alloc]initWithFrame:CGRectMake(0, self.imageView.frame.size.height, self.view.size.width, 50)];
    UIButton * cancelBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width/2, 50)];
    [cancelBtn addTarget:self action:@selector(viewTapped:) forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor redColor] forState: UIControlStateNormal];
    UIButton * chooceBtn=[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2, 0, self.view.frame.size.width/2, 50)];
    [chooceBtn setTitle:@"使用" forState:UIControlStateNormal];
      [chooceBtn setTitleColor:[UIColor blueColor] forState: UIControlStateNormal];
    [sureView addSubview:cancelBtn];
    [sureView addSubview:chooceBtn];
    sureView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:sureView];
}

- (void)viewTapped:(UIGestureRecognizer *)gesture {
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    self.imageView.frame = self.view.contentBounds;
    
    [self.infoLabel sizeToFit];
    self.infoLabel.width = self.view.contentBounds.size.width;
    self.infoLabel.top = 0;
    self.infoLabel.left = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
