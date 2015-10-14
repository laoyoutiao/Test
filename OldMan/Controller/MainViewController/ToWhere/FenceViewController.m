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
#import "MyHeader.h"

@interface FenceViewController ()<BMKMapViewDelegate,BMKGeoCodeSearchDelegate,UIAlertViewDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet BMKMapView *mapView;
@property (strong, nonatomic) BMKGeoCodeSearch *geocodesearch;
@property (strong, nonatomic) UserInfo *userinfo;
@property (strong, nonatomic) UITableViewCell *cell;
@property (strong, nonatomic) UITableView *tableview;

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

#pragma mark View

- (void)ReviseNavigation
{
    //    [self.navigationController setNavigationBarHidden:YES];
    [self.navigationController.navigationBar setBarTintColor:[UIColor grayColor]];
    self.title = @"电子围栏";
}

- (void)setTableview
{
    _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, ScreenSize.width, 160)];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.scrollEnabled = NO;
    [self.view addSubview:_tableview];
}

#pragma mark TableViewDelegate or Datasource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"UITableViewCell";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"围栏名称 : 请输入围栏名称";
            break;
            
        case 1:
            cell.textLabel.text = @"城市选择 : 详细地址";
            break;
            
        case 2:
            cell.textLabel.text = @"围栏时段 : 开始时间和结束时间";
            break;
            
        case 3:
            cell.textLabel.text = @"围栏半径 : 请输入围栏半径米";
            break;
            
        default:
            break;
    }
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.font = [UIFont systemFontOfSize:13];
    cell.backgroundColor = [UIColor blackColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    _cell = [tableView cellForRowAtIndexPath:indexPath];
    _cell.textLabel.text = nil;
    UITextField *field = [[UITextField alloc] initWithFrame:CGRectMake(15, 0, ScreenSize.width - 30, _cell.frame.size.height)];
    [_cell addSubview:field];
    field.delegate = self;
    field.textColor = [UIColor whiteColor];
    field.tag = TagNumber(indexPath.row);
    [field becomeFirstResponder];
    _cell.tag = TagNumber(indexPath.row);
    [_cell reloadInputViews];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

#pragma mark TextField Delegate

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSLog(@"%ld",textField.tag);
    UITableViewCell *cell = [_tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:textField.tag - TagNumber(0) inSection:0]];
    switch (textField.tag) {
        case TagNumber(0):
            if ([textField.text isEqualToString:@""]) {
                textField.text = @"请输入围栏名称";
            }
            cell.textLabel.text = [NSString stringWithFormat:@"围栏名称 : %@",textField.text];
            break;
            
        case TagNumber(1):
            if ([textField.text isEqualToString:@""]) {
                textField.text = @"详细地址";
            }
            cell.textLabel.text = [NSString stringWithFormat:@"城市选择 : %@",textField.text];
            break;
            
        case TagNumber(2):
            if ([textField.text isEqualToString:@""]) {
                textField.text = @"开始时间和结束时间";
            }
            cell.textLabel.text = [NSString stringWithFormat:@"围栏时段 : %@",textField.text];
            break;
            
        case TagNumber(3):
            if ([textField.text isEqualToString:@""]) {
                textField.text = @"请输入围栏半径";
            }
            cell.textLabel.text = [NSString stringWithFormat:@"围栏半径 : %@米",textField.text];
            break;
            
        default:
            break;
    }
    [textField removeFromSuperview];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    textField.text = nil;
    return YES;
}

#pragma mark Location Responer Event

- (void)locationstart
{
    NSDictionary *dict = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserInfo"];
    _userinfo = [[UserInfo alloc] initWithDictionary:dict];
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
//            pt = (CLLocationCoordinate2D){23.057863,113.360778};
            BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
            reverseGeocodeSearchOption.reverseGeoPoint = pt;
            [_geocodesearch reverseGeoCode:reverseGeocodeSearchOption];
            [self setTableview];
        }
    }];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self.navigationController popViewControllerAnimated:YES];
    }else if (buttonIndex == 1)
    {
        [self locationstart];
    }
}

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
        [_mapView addAnnotation:item];
        _mapView.centerCoordinate = result.location;
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
