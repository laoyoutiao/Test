//
//  WorkerMessageViewController.m
//  Test
//
//  Created by 玉文辉 on 15/8/4.
//  Copyright (c) 2015年 玉文辉. All rights reserved.
//

#import "WorkerMessageViewController.h"
#import "ServerSocialWorkerMessage.h"
#import "SocialWorkerCommentInfo.h"

@interface WorkerMessageViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *ImageView;
@property (weak, nonatomic) IBOutlet UILabel *IntroduceLabel;
@property (weak, nonatomic) IBOutlet UILabel *ScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *SkillLabel;
@property (weak, nonatomic) IBOutlet UILabel *PriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *PhoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *CommentOne;
@property (weak, nonatomic) IBOutlet UILabel *CommentTwo;
@property (strong, nonatomic) NSMutableDictionary *commentdict;
@property (strong, nonatomic) NSMutableArray *commentarray;
@end

@implementation WorkerMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _commentdict = [[NSMutableDictionary alloc] init];
    _commentarray = [[NSMutableArray alloc] init];
    
    [self ReviseNavigation];
    [self setImage];
    [self SetLabelText];
    // Do any additional setup after loading the view.
}

- (void)ReviseNavigation
{
    self.title = @"社工详情";
}

- (void)setImage
{
    NSLog(@"%@",_info.imgset);
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://192.168.1.146:8080/SmartPlatformWeb/servlet/WorkerManage/upload/worker/ssww/ssww_1435914769023.jpg"]];
    
    _ImageView.image = [UIImage imageWithData:data];

}

- (void)SetLabelText
{
    _IntroduceLabel.text = [NSString stringWithFormat:@"社工介绍 : %@",_info.introduce];
    _ScoreLabel.text = [NSString stringWithFormat:@"评价星级 : %ld",_info.score];
    _SkillLabel.text = [NSString stringWithFormat:@"社工技能 : %@",_info.skill];
    _PriceLabel.text = [NSString stringWithFormat:@"服务价位 : %@",_info.price];
    _PhoneLabel.text = [NSString stringWithFormat:@"社工电话 : %@",_info.cellphone];
    [ServerSocialWorkerMessage GetWorkerCommentpostName:_info.username Row:0 Block:^(NSDictionary *dict){
        [_commentdict setDictionary:dict];
        [self WorkComment];
    }];
}

- (void)WorkComment
{
    if ([[_commentdict objectForKey:@"result"] isEqualToString:@"true"]) {
        [_commentdict removeObjectForKey:@"result"];
        [_commentarray setArray:[SocialWorkerCommentInfo instanceArrayDictFromDict:_commentdict]];
         NSArray *sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"discusstime" ascending:YES]];
        [_commentarray sortUsingDescriptors:sortDescriptors];
//        NSLog(@"%@",_commentarray);
        SocialWorkerCommentInfo *commentinfo = [[SocialWorkerCommentInfo alloc] initWithDictionary:[_commentarray objectAtIndex:[_commentarray count]- 1]];
        _CommentOne.text = [NSString stringWithFormat:@"%@ : %@\n%@\n",commentinfo.discussor,commentinfo.discusstime,commentinfo.descript];
        if([_commentarray count] == 1)
        {
            _CommentTwo.text = @"暂无评论";
        }else
        {
            commentinfo = [[SocialWorkerCommentInfo alloc] initWithDictionary:[_commentarray objectAtIndex:[_commentarray count]- 2]];
            _CommentTwo.text = [NSString stringWithFormat:@"%@ : %@\n%@\n",commentinfo.discussor,commentinfo.discusstime,commentinfo.descript];
        }
    }else
    {
        _CommentOne.text = @"暂无评论";
        _CommentTwo.text = @"暂无评论";
    }
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
