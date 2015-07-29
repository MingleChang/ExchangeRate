//
//  MCDevice.h
//  Category_OS
//
//  Created by admin001 on 14/12/2.
//  Copyright (c) 2014年 MingleChang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface MCDevice : NSObject
/*
 获取当前运行系统的版本号
 参数：N/A
 返回值：CGFloat，返回系统的版本号
 */
+(CGFloat)systemVersion;
/*
 判断当前设备是否是iPhone
 参数：N/A
 返回值：BOOL，返回YES或者NO
 */
+(BOOL)iPhone;
/*
 判断当前设备是否是iPad
 参数：N/A
 返回值：BOOL，返回YES或者NO
 */
+(BOOL)iPad;

/***********************************************/
//说明：将当前设备分为3.5寸，4.0寸，4.7寸，5.5寸四种设备，并且3.5寸设备市面上只剩下iPhone4和iPhone4s，而且猜测苹果之后只会再出4.0寸，4.7寸，5.5寸这三种尺寸的设备，3.5寸的设备作为特殊设备，先保留,同时考虑现在也没有了低分辨率设备，所以也未将低分辨率设备考虑其中
/*
 判断当前设备是否是3.5寸,例如：iPhone 4,iPhone 4s
 参数：N/A
 返回值：BOOL，返回YES或者NO
 */
+(BOOL)iPhoneOld;
/*
 判断当前设备是否是4寸设备,例如：iPhone 5,iPhone 5s
 参数：N/A
 返回值：BOOL，返回YES或者NO
 */
+(BOOL)iPhoneMini;
/*
 判断当前设备是否是4.7寸设备,例如：iPhone 6
 参数：N/A
 返回值：BOOL，返回YES或者NO
 */
+(BOOL)iPhoneNormal;
/*
 判断当前设备是否是5.5寸设备,例如：iPhone 6Plus
 参数：N/A
 返回值：BOOL，返回YES或者NO
 */
+(BOOL)iPhonePlus;
/***********************************************/
/*
 判断当前设备是否是高分辨率屏幕
 参数：N/A
 返回值：BOOL，返回YES或者NO
 */
+(BOOL)isRetina;
/*
 获取应用正在用于显示的ViewController
 参数：N/A
 返回值：UIViewController，返回对应的视图控制器
 */
+(UIViewController *)getAppFrontViewController;
/*
 获取应用正在用于显示的Window
 参数：N/A
 返回值：UIWindow，返回对应的Window
 */
+(UIWindow *)getAppFrontWindow;
@end
