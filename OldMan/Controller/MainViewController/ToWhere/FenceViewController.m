//
//  FenceViewController.m
//  Test
//
//  Created by 玉文辉 on 15/8/3.
//  Copyright (c) 2015年 玉文辉. All rights reserved.
//

#import "FenceViewController.h"
#import <BaiduMapAPI/BMapKit.h>
#import "ServerUserLocation.h"
#import "UserInfo.h"

@interface FenceViewController ()<BMKMapViewDelegate,BMKGeoCodeSearchDelegate,UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet BMKMapView *mapView;
@property (strong, nonatomic) BMKGeoCodeSearch *geocodesearch;
@property (strong, nonatomic) UserInfo *userinfo;

@end

@implementation FenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _geocodesearch = [[BMKGeoCodeSearch alloc]init];
    [_mapView setZoomLevel:14];
    
    [self ReviseNavigation];
    [self locationstart];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated {
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _geocodesearch.delegate = self;
}

-(void)viewWillDisappear:(BOOL)animated {
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    _geocodesearch.delegate = nil;
}

- (void)ReviseNavigation
{
    //    [self.navigationController setNavigationBarHidden:YES];
    [self.navigationController.navigationBar setBarTintColor:[UIColor grayColor]];
    self.title = @"电子围栏";
}

#pragma mark Location Responer Event

- (void)locationstart
{
    NSDictionary *dict = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserInfo"];
    _userinfo = [[UserInfo alloc] initWithDictionary:dict];
    __weak typeof(self) weakself = self;
    [ServerUserLocation GetLocationpostName:_userinfo.username Block:^(NSDictionary *locationdict){
        //        NSLog(@"%@",locationdict);
        CLLocationCoordinate2D pt;
        if ([[locationdict objectForKey:@"result"] isEqualToString:@"false"]) {
            NSString *message = [locationdict objectForKey:@"message"];
            UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"定位失败" message:message delegate:self cancelButtonTitle:@"返回" otherButtonTitles:@"重新加载",nil];
            [alertview show];
        }else
        {
            float latitude = [[locationdict objectForKey:@"latiude"] floatValue];
            float longitude = [[locationdict objectForKey:@"longitude"] floatValue];
            pt = (CLLocationCoordinate2D){latitude,longitude};
            BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
            reverseGeocodeSearchOption.reverseGeoPoint = pt;
            [weakself locationgo_on];
            [weakself locationend];
        }
    }];
}

- (void)locationgo_on
{
    _mapView.showsUserLocation = NO;//先关闭显示的定位图层
    _mapView.userTrackingMode = BMKUserTrackingModeFollow;//设置定位的状态
    _mapView.showsUserLocation = YES;//显示定位图层
}

- (void)locationend
{
    NSLog(@"完成定位");
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
