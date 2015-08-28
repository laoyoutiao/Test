//
//  SocialWorkerTableViewCell.m
//  Test
//
//  Created by 玉文辉 on 15/8/4.
//  Copyright (c) 2015年 玉文辉. All rights reserved.
//

#import "SocialWorkerTableViewCell.h"

@interface SocialWorkerTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *NameLabel;
@property (weak, nonatomic) IBOutlet UILabel *LevelLabel;
@property (weak, nonatomic) IBOutlet UILabel *SkillLabel;
@property (weak, nonatomic) IBOutlet UILabel *AreaLabel;
@property (weak, nonatomic) IBOutlet UIImageView *HeadImageView;
@property (weak, nonatomic) IBOutlet UILabel *AddressLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HeightOfAddressLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HeightOfNameLabel;
@end

@implementation SocialWorkerTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (CGFloat)HeighTofCell
{
    return _HeightOfAddressLabel.constant + _HeightOfNameLabel.constant * 4 + 40;
}

- (void)InfoOfCell:(SocialWorkerInfo *)info
{
    _NameLabel.text = info.username;
    _LevelLabel.text = info.skill;
    _AreaLabel.text = info.area;
    _AddressLabel.text = info.address;
    _LevelLabel.text = [NSString stringWithFormat:@"%ld",info.score];
}

@end
