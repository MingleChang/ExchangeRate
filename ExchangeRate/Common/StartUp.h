//
//  StartUp.h
//  ExchangeRate
//
//  Created by 常峻玮 on 15/7/29.
//  Copyright (c) 2015年 MingleChang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StartUp : NSObject

+(void)launch;
+(void)enterForeground;
+(void)becomeActive;
+(void)enterBackground;
+(void)resignActive;
@end
