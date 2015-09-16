//
//  AppDelegate.m
//  Test
//
//  Created by 玉文辉 on 15/7/30.
//  Copyright (c) 2015年 玉文辉. All rights reserved.
//

#import "AppDelegate.h"
#import "EquipmentBindingViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <Photos/Photos.h>

@interface AppDelegate () <UISplitViewControllerDelegate,CLLocationManagerDelegate>
@property(strong, nonatomic) CLLocationManager *locationManager;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    _mapmanager = [[BMKMapManager alloc]init];
    BOOL ret = [_mapmanager start:@"McX4fnt74KFH1AUhjauG3Ygz" generalDelegate:self];
    
    if (!ret) {
        NSLog(@"manager start failed!");
    }
//    NSLog(@"%@",[NSProcessInfo processInfo].environment);
    
    [UIApplication sharedApplication].idleTimerDisabled = TRUE;
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    return YES;
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
//    NSLog(@"location---%d",status);
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
            if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
//                [self.locationManager requestWhenInUseAuthorization];     //NSLocationWhenInUseDescription
                [self.locationManager requestAlwaysAuthorization];
                
            }
            break;
            
        case kCLAuthorizationStatusDenied:
            if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
//                [self.locationManager requestWhenInUseAuthorization];     //NSLocationNO
                [self.locationManager requestAlwaysAuthorization];
            }
            break;

        case kCLAuthorizationStatusAuthorizedAlways:
            NSLog(@"Always Location");
            break;
            
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            NSLog(@"Useing Location");
            break;
        
        default:
            break;
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
    [BMKMapView willBackGround];
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
    
    [BMKMapView didForeGround];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Split view

- (BOOL)splitViewController:(UISplitViewController *)splitViewController
{
    return NO;
}

- (void)onGetNetworkState:(int)iError
{
    if (0 == iError) {
        NSLog(@"联网成功");
    }
    else{
        NSLog(@"onGetNetworkState %d",iError);
    }
    
}

- (void)onGetPermissionState:(int)iError
{
    if (0 == iError) {
        NSLog(@"授权成功");
    }
    else {
        NSLog(@"onGetPermissionState %d",iError);
    }
}

@end
