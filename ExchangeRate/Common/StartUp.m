//
//  StartUp.m
//  ExchangeRate
//
//  Created by 常峻玮 on 15/7/29.
//  Copyright (c) 2015年 MingleChang. All rights reserved.
//

#import "StartUp.h"
#import "DataManager.h"
#import "MCExchangeRate.h"
#import "MCCurrency.h"
#import "Flurry.h"
#import "MingleChang.h"
@implementation StartUp

+(void)launch{
    [Flurry startSession:@"DYDGVJWM2BTZXC2W3VZP"];
}
+(void)enterForeground{
    [[NSNotificationCenter defaultCenter]postNotificationName:APP_ENTER_FOREGROUND object:nil];
}
+(void)becomeActive{
    [[NSNotificationCenter defaultCenter]postNotificationName:APP_BECOME_ACTIVE object:nil];
}
+(void)enterBackground{
    [[NSUserDefaults standardUserDefaults]setDouble:[DataManager manager].clickValue forKey:CLICK_VALUE];
    [[NSUserDefaults standardUserDefaults]setObject:[DataManager manager].clickExchangeRate.fromCurrency.unit forKey:CLICK_EXCHANGERATE];
    [NSUserDefaults resetStandardUserDefaults];
    
    [[NSNotificationCenter defaultCenter]postNotificationName:APP_ENTER_BACKGROUND object:nil];
}
+(void)resignActive{
    [[NSNotificationCenter defaultCenter]postNotificationName:APP_RESIGN_ACTIVE object:nil];
}

@end
