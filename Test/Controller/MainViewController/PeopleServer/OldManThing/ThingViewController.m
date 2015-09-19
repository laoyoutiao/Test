//
//  ThingViewController.m
//  Test
//
//  Created by 玉文辉 on 15/8/3.
//  Copyright (c) 2015年 玉文辉. All rights reserved.
//

#import "ThingViewController.h"

@interface ThingViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *WebView;

@end

@implementation ThingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self ReviseNavigation];
    [self setWebView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)ReviseNavigation
{
    //    [self.navigationController setNavigationBarHidden:YES];
    self.title = @"老人办事";
}

- (void)setWebView
{
//    NSString *str = @"http://wwww.chancheng.gov.cn/chancheng/in0602/rzpt_lm.shtml";
    NSString *str = @"http://wwww.baidu.com";
    NSURL *url = [NSURL URLWithString:str];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_WebView loadRequest:request];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"%@",[webView stringByEvaluatingJavaScriptFromString:@"document.title"]);
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"%@",error);
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
