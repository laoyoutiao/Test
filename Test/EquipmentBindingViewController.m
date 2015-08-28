//
//  EquipmentBindingView.m
//  Test
//
//  Created by 玉文辉 on 15/7/30.
//  Copyright (c) 2015年 玉文辉. All rights reserved.
//

#import "EquipmentBindingViewController.h"
#import "EquipmentNumberViewController.h"

@interface EquipmentBindingViewController ()

@end

@implementation EquipmentBindingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self ReviseNavigation];
    self.view.backgroundColor = [UIColor whiteColor];
//    self.navigationController.navigationBarHidden = YES;
    
    // Do any additional setup after loading the view.
}

- (void)ReviseNavigation
{
    self.title = @"绑定设备";
    [self.navigationItem setHidesBackButton:YES];
    
}
- (IBAction)ClickSwitchAccountButton:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (IBAction)ClickNextButton:(id)sender {
    EquipmentNumberViewController *equipnumViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"EquipmentNumberView"];
    [self.navigationController pushViewController:equipnumViewController animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
