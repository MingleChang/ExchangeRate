//
//  NSString+MC.h
//  Category_OS
//
//  Created by admin001 on 14/11/26.
//  Copyright (c) 2014年 MingleChang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MCExtension)
/*
 判断是字符串是否全都是空格或者换行
 参数：N/A
 返回值：BOOL，如果满足全是空格或者换行，则返回YES，反之，则返回NO
 */
-(BOOL)isAllSpaceAndNewLine;
/*
 去掉字符串首尾两端的空格和换行符号
 参数：N/A
 返回值：NSString，返回去掉字符串首尾两端的空格和换行符号之后得到的字符串
 */
-(NSString *)trimSpaceAndNewLine;
/*
 对字符串进行md5加密
 参数：N/A
 返回值：NSString，返回进行了md5加密之后的字符串
 */
-(NSString *)md5;
/*
 对字符串进行URLEncode转码，主要用于进行网络参数传递
 参数：N/A
 返回值：NSString，返回进行URLEncode转码之后的字符串
 */
-(NSString *)URLEncode;
@end
