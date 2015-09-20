//
//  MCOwner.h
//  Category_OS
//
//  Created by admin001 on 14/12/2.
//  Copyright (c) 2014年 MingleChang. All rights reserved.
//

/*
 需要添加的静态库有libz.dylib
 */

#ifndef _MINGLE_CHANG_h
#define _MINGLE_CHANG_h

#import "MCImageExtension.h"
#import "MCStringExtension.h"
#import "MCDrawImage.h"
#import "MCDevice.h"


/***********自定义的打印方法*************/
#define __MCLOG(s, ...) \
NSLog(@"%@",[NSString stringWithFormat:(s), ##__VA_ARGS__])
#ifdef DEBUG
#define MCLOG(...) __MCLOG(__VA_ARGS__)//如果是debug状态则打印值
#else
#define MCLOG(...) do {} while (0)//如果不是debug状态则无操作
#endif
//建议之后一直使用MCLOG代替NSLog
/*************************************/

#define ONE_PIXEL 1/[UIScreen mainScreen].scale

#define RGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]//宏定义颜色获取方法，alpha不可设置，默认为1.0
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]//宏定义颜色获取方法，alpha可设置

#define APP_ENTER_FOREGROUND @"APP_ENTER_FOREGROUND"
#define APP_BECOME_ACTIVE @"APP_BECOME_ACTIVE"
#define APP_ENTER_BACKGROUND @"APP_ENTER_BACKGROUND"
#define APP_RESIGN_ACTIVE @"APP_RESIGN_ACTIVE"

#define LOCAL_APP_NAME @"AppName"
#define LOCAL_UPDATING @"Updating"
#define LOCAL_UPDATE_SUCCESS @"UpdateSuccess"
#define LOCAL_UPDATE_FAIL @"UpdateFail"
#define LOCAL_CANCEL @"Cancel"

#endif
