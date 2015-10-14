//
//  MyHeader.h
//  OldMan
//
//  Created by 玉文辉 on 15/9/23.
//  Copyright © 2015年 玉文辉. All rights reserved.
//

#ifndef MyHeader_h
#define MyHeader_h

#define TagNumber(x) 1000 + x

#define ScreenSize [UIScreen mainScreen].bounds.size

#define NSLogStr(x) NSLog(@"%@",x);

#define NSLogInt(x) NSLog(@"%d",x);

#define NSLogInteger(x) NSLog(@"%ld",x);

#define NSLogFloat(x) NSLog(@"%f",x);

#define NSLogCGFloat(x) NSLog(@"%lf",x);

#define NSLogBool(x) NSLog(@"%u",x);

#define NSLogArray(format, ...) do {                                        \
fprintf(stderr, "<%s : %d> %s\n",                                           \
[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String],  \
__LINE__, __func__);                                                \
(NSLog)((format), ##__VA_ARGS__);                                           \
fprintf(stderr, "-------\n");                                               \
} while (0)

#endif /* MyHeader_h */
