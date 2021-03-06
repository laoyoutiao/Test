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
//    [self locationstart];
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(locationstart) userInfo:nil repeats:NO];
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
    [ServerUserLocation GetLocationpostName:_userinfo.username Block:^(NSDictionary *locationdict){
        NSLog(@"%@",locationdict);
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
            pt = (CLLocationCoordinate2D){23.057863,113.370758};
            BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
            reverseGeocodeSearchOption.reverseGeoPoint = pt;
            [_geocodesearch reverseGeoCode:reverseGeocodeSearchOption];

        }
    }];
}


- (void)textLabel:(NSString *)locationstring
{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd hh:mm";
    NSString *time = [formatter stringFromDate:date];
    
    UILabel *textLable = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 2 - 120, 150, 240, 100)];
    textLable.text = [NSString stringWithFormat:@"定位时间 : %@\n\n手表位置 : %@",time,locationstring];
    textLable.numberOfLines = 0;
    [self.view addSubview:textLable];
    textLable.backgroundColor = [UIColor whiteColor];
}

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
    NSString *AnnotationViewID = @"annotationView";
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
        item.subtitle = [NSString stringWithFormat:@"定位时间 : %@",time];
        item.title = [NSString stringWithFormat:@"手表位置 : %@",result.address];
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
