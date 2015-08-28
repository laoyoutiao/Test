//
//  SocialWorkerCommentInfo.m
//  Test
//
//  Created by 玉文辉 on 15/8/27.
//  Copyright (c) 2015年 玉文辉. All rights reserved.
//

#import "SocialWorkerCommentInfo.h"
#import "NSDictionary+Safe.h"

@implementation SocialWorkerCommentInfo

- (id)initWithDictionary:(NSDictionary *)dict
{
    if(self = [super init])
    {
        _descript = [dict safeStringForKey:@"descript"];
        _discuss_id = [dict safeStringForKey:@"discuss_id"];
        _discussor = [dict safeStringForKey:@"discussor"];
        _discusstime = [dict safeStringForKey:@"discusstime"];
        _score = [dict safeFloatForKey:@"score"];
        _username = [dict safeStringForKey:@"username"];
        _pnum = [dict safeIntegerForKey:@"pnum"];
    }
    return self;
}

+ (NSArray *)instanceArrayDictFromDict:(NSDictionary *)dict
{
    NSMutableArray *instanceArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < [dict count]; i ++){
        [instanceArray  addObject:[dict objectForKey:[NSString stringWithFormat:@"%d",i]]];
    }
    return [NSArray arrayWithArray:instanceArray];
}

@end
