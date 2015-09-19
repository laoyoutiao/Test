//
//  MainWhereViewController.m
//  Test
//
//  Created by 玉文辉 on 15/7/31.
//  Copyright (c) 2015年 玉文辉. All rights reserved.
//

#import "MainWhereViewController.h"
#import "NavigationController.h"

@interface MainWhereViewController ()<UITabBarControllerDelegate>
@property (weak, nonatomic) IBOutlet UINavigationItem *NavigationItem;
@end

@implementation MainWhereViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self ReviseNavigation];
    
    // Do any additional setup after loading the view.
}


- (void)ReviseNavigation
{
//    [self.navigationController setNavigationBarHidden:YES];
    [self.navigationController.navigationBar setBarTintColor:[UIColor grayColor]];
    self.title = @"去哪里";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

    // Dispose of any resources that can be recreated.
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
