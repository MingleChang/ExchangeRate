//
//  ToastManager.h
//  ExchangeRate
//
//  Created by 常峻玮 on 15/7/29.
//  Copyright (c) 2015年 MingleChang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ToastManager : NSObject

+(void)toastText:(NSString *)string;
+(void)toastText:(NSString *)string inView:(UIView *)view;
+(void)toastText:(NSString *)string inView:(UIView *)view withOffset:(CGPoint)offset;

@end
