//
//  AppDelegate.m
//  YiNongXian
//
//  Created by 索金铭 on 15/11/10.
//  Copyright © 2015年 bxlt. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import <CoreLocation/CoreLocation.h>
@interface AppDelegate ()<CLLocationManagerDelegate>
{
    CLLocationManager * _locationmanager;
}

@end

@implementation AppDelegate
@synthesize POSTURL;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self getLoactionServer];
    
    POSTURL=@"http://116.228.131.241:8080/aims";
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
      LoginViewController * LogvC=[[LoginViewController alloc]init];
    UINavigationController * navC=[[UINavigationController alloc]initWithRootViewController:LogvC];
    navC.navigationBar.barTintColor=AppMainColor;
    [navC.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:18],
       
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.window.rootViewController=navC;
    
    [self.window makeKeyAndVisible];
    // Override point for customization after application launch.
    return YES;
}
- (void)getLoactionServer{
    
    // 获取GPS信息
    [UIApplication sharedApplication].idleTimerDisabled = TRUE;
    _locationmanager = [[CLLocationManager alloc] init];
    
    if([_locationmanager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        
        [_locationmanager requestWhenInUseAuthorization];
    }
    
    _locationmanager.delegate = self;
    _locationmanager.desiredAccuracy = kCLLocationAccuracyBest;
    // _locationmanager.distanceFilter = kCLLocationAccuracyHundredMeters;
    
    [_locationmanager startUpdatingLocation];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        
        [_locationmanager requestWhenInUseAuthorization];  //调用了这句,就会弹出允许框了.
        
    }
    
    
    
}

//定位
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    
    float latitude = newLocation.coordinate.latitude;
    float longitude = newLocation.coordinate.longitude;
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%f",latitude ]forKey:@"jing"];
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%f",longitude ] forKey:@"wei"];

}

- (void)locationManager: (CLLocationManager *)manager
       didFailWithError: (NSError *)error {
    
    NSString *errorString;
    [manager stopUpdatingLocation];
    NSLog(@"Error: %@",[error localizedDescription]);
    switch([error code]) {
        case kCLErrorDenied:
            //Access denied by user
            errorString = @"用户访问位置服务已关闭 请在 设置》E农险》位置  中允许访问";
            
            [[NSUserDefaults standardUserDefaults] setObject:@""forKey:@"jing"];
            [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"wei"];
            break;
        case kCLErrorLocationUnknown:
            //Probably temporary...
            errorString = @"位置数据不可用";
            //Do something else...
            break;
        default:
            errorString = @"一个未知的错误发生";
            break;
    }
    [WCAlertView showAlertWithTitle:nil message:errorString customizationBlock:nil completionBlock:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
