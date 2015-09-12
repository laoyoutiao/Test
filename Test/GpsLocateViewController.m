//
//  GpsLocateViewController.m
//  Test
//
//  Created by 玉文辉 on 15/8/3.
//  Copyright (c) 2015年 玉文辉. All rights reserved.
//

#import "GpsLocateViewController.h"
#import <BaiduMapAPI/BMapKit.h>
#import "ServerUserLocation.h"
#import "UserInfo.h"

@interface GpsLocateViewController ()<BMKMapViewDelegate,BMKGeoCodeSearchDelegate,UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet BMKMapView *mapView;
@property (strong, nonatomic) BMKGeoCodeSearch *geocodesearch;
@property (strong, nonatomic) UserInfo *userinfo;
@end

@implementation GpsLocateViewController

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
    self.title = @"GPS定位";
}

#pragma mark Location Responer Event

- (void)locationstart
{
    NSDictionary *dict = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserInfo"];
    _userinfo = [[UserInfo alloc] initWithDictionary:dict];
    __weak typeof(self) weakself = self;
    [ServerUserLocation GetLocationpostName:_userinfo.username Block:^(CLLocationCoordinate2D location){
        NSLog(@"%f,%f",location.latitude,location.longitude);
        CLLocationCoordinate2D pt;
        if (!location.latitude && !location.longitude) {
//            pt = (CLLocationCoordinate2D){23.068903, 113.060738};
            UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"定位失败" message:@"未开启监控功能" delegate:self cancelButtonTitle:@"返回" otherButtonTitles:nil];
            [alertview show];
        }else
        {
            pt = (CLLocationCoordinate2D){location.latitude, location.longitude};
            BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
            reverseGeocodeSearchOption.reverseGeoPoint = pt;
            BOOL flag = [_geocodesearch reverseGeoCode:reverseGeocodeSearchOption];
            if(!flag || location.latitude == -1 || location.longitude == -1)
            {
                UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"定位失败" message:@"未知原因" delegate:self cancelButtonTitle:@"返回" otherButtonTitles:@"重新加载",nil];
                [alertview show];
            }else
            {
                [weakself locationgo_on];
                [weakself locationend];
            }
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

//- (void)textLabel:(NSString *)locationstring
//{
//    NSDate *date = [NSDate date];
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    formatter.dateFormat = @"yyyy-MM-dd hh:mm";
//    NSString *time = [formatter stringFromDate:date];
//    
//    UILabel *textLable = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 2 - 120, 150, 240, 100)];
//    textLable.text = [NSString stringWithFormat:@"定位时间 : %@\n\n手表位置 : %@",time,locationstring];
//    textLable.numberOfLines = 0;
//    [self.view addSubview:textLable];
//    textLable.backgroundColor = [UIColor whiteColor];
//}

#pragma mark Clickalertview

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            [self.navigationController popToRootViewControllerAnimated:YES];
            break;
            
        case 1:
            [self locationstart];
            break;
            
        default:
            break;
    }
}

#pragma mark BaiduLocationDelegate

//根据anntation生成对应的View
- (BMKAnnotationView *)mapView:(BMKMapView *)view viewForAnnotation:(id <BMKAnnotation>)annotation
{
    NSString *AnnotationViewID = @"annotationViewID";
    //根据指定标识查找一个可被复用的标注View，一般在delegate中使用，用此函数来代替新申请一个View
    BMKAnnotationView *annotationView = [view dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
    if (annotationView == nil) {
        annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
        ((BMKPinAnnotationView*)annotationView).pinColor = BMKPinAnnotationColorRed;
        ((BMKPinAnnotationView*)annotationView).animatesDrop = YES;
    }
//    annotationView.image = nil;
    annotationView.centerOffset = CGPointMake(0, -(annotationView.frame.size.height * 0.5));
    annotationView.annotation = annotation;
    annotationView.canShowCallout = TRUE;
    annotationView.enabled = YES;
    [annotationView setSelected:YES];
    return annotationView;
}

-(void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
    [_mapView removeAnnotations:array];
    array = [NSArray arrayWithArray:_mapView.overlays];
    [_mapView removeOverlays:array];
    if (error == 0) {
        BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
        item.coordinate = result.location;
        NSDate *date = [NSDate date];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy-MM-dd hh:mm";
        NSString *time = [formatter stringFromDate:date];
        item.title = [NSString stringWithFormat:@"定位时间 : %@",time];
        item.subtitle = [NSString stringWithFormat:@"手表位置 : %@",result.address];
        [_mapView addAnnotation:item];
        _mapView.centerCoordinate = result.location;
        
//        NSString* titleStr;
//        NSString* showmeg;
//        titleStr = @"手表位置";
//        showmeg = [NSString stringWithFormat:@"%@",item.title];
        
//        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:titleStr message:showmeg delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
//        [myAlertView show];
        
//        [self textLabel:showmeg];

    }
}



- (void)dealloc {
    if (_geocodesearch != nil) {
        _geocodesearch = nil;
    }
    if (_mapView) {
        _mapView = nil;
    }
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
