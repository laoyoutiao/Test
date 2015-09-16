//
//  DescriptViewController.m
//  Test
//
//  Created by 玉文辉 on 15/9/15.
//  Copyright (c) 2015年 玉文辉. All rights reserved.
//

#import "DescriptViewController.h"

@interface DescriptViewController()
@property (weak, nonatomic) IBOutlet UILabel *TextLabel;
@property (weak, nonatomic) IBOutlet UITextView *TextView;
@property (weak, nonatomic) IBOutlet UIButton *PostButton;

@end

@implementation DescriptViewController

- (void)viewDidLoad
{
    _TextLabel.text = [NSString stringWithFormat:@"预约编号 : %@\n\n社工名字 : %@\n\n服务日期 : %@\n\n选择星级 : \n\n评论内容 : \n",_bookid,_socialworkername,_time];
}

@end
