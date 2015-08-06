//
//  StartUp.m
//  ExchangeRate
//
//  Created by 常峻玮 on 15/7/29.
//  Copyright (c) 2015年 MingleChang. All rights reserved.
//

#import "StartUp.h"
#import "DataManager.h"

@implementation StartUp

+(void)launch{
    [self updateExchange];
}
+(void)updateExchange{
    if ([DataManager manager].allExchangeRateUpdateDate) {
        if ([self checkNeedUpdateExchange]) {
            [[DataManager manager]updateAllExchangeCompletion:nil];
        }
    }
}
+(BOOL)checkNeedUpdateExchange{
    NSInteger timezoneFix=[NSTimeZone localTimeZone].secondsFromGMT;
    NSDate *lNowDate=[NSDate date];
    NSInteger lNowDays=((NSInteger)[lNowDate timeIntervalSince1970]+timezoneFix)/(60*60*24);
    NSInteger lLastUpdateDays=((NSInteger)[[DataManager manager].allExchangeRateUpdateDate timeIntervalSince1970]+timezoneFix)/(60*60*24);
    if (lNowDays==lLastUpdateDays) {
        return NO;
    }else{
        return YES;
    }
}
@end
