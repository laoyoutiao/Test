//
//  EquipmentNumberViewController.m
//  Test
//
//  Created by 玉文辉 on 15/7/30.
//  Copyright (c) 2015年 玉文辉. All rights reserved.
//

#import "EquipmentNumberViewController.h"
#import "MainWhereViewController.h"
#import "TabBarController.h"
#import <AVFoundation/AVFoundation.h>

@interface EquipmentNumberViewController ()<AVCaptureMetadataOutputObjectsDelegate>

@property (nonatomic,strong) AVCaptureSession *captureSession;
@property (nonatomic,strong) AVCaptureVideoPreviewLayer *videoPreviewLayer;

@end

@implementation EquipmentNumberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self ReviseNavigation];
    // Do any additional setup after loading the view.
}

- (void)ReviseNavigation
{
    self.title = @"绑定设备";
}

- (IBAction)ClickNextButton:(id)sender {
    TabBarController *mainViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"TabBar"];
//    [self.navigationController pushViewController:mainViewController animated:YES];
    
    [self presentViewController:mainViewController animated:YES completion:nil];

}


- (IBAction)ClickQRcodeButton:(id)sender {
    
    [self QRcode];
    
}

- (BOOL)QRcode
{
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSError *error;
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
    if (!input) {
        NSLog(@"%@", [error localizedDescription]);
        return NO;
    }else
    {
        _captureSession = [[AVCaptureSession alloc] init];
        [_captureSession addInput:input];
        AVCaptureMetadataOutput *captureMetadataOutput = [[AVCaptureMetadataOutput alloc] init];
        [_captureSession addOutput:captureMetadataOutput];
        
        dispatch_queue_t dispatchQueue;
        dispatchQueue = dispatch_queue_create("myQueue",NULL);
        [captureMetadataOutput setMetadataObjectsDelegate:self queue:dispatchQueue];
        [captureMetadataOutput setMetadataObjectTypes:[NSArray arrayWithObject:AVMetadataObjectTypeQRCode]];
        
        _videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_captureSession];
        [_videoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
        [_videoPreviewLayer setFrame:self.view.layer.bounds];
        [self.view.layer addSublayer:_videoPreviewLayer];
        
        [_captureSession startRunning];
        return YES;
    }
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    if (metadataObjects != nil && [metadataObjects count] > 0) {
        
        AVMetadataMachineReadableCodeObject *metadataObj = [metadataObjects objectAtIndex:0];
        
        if ([[metadataObj type] isEqualToString:AVMetadataObjectTypeQRCode]) {
            
            NSLog(@"%@",metadataObj.stringValue);
            [_captureSession stopRunning];
        }
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
