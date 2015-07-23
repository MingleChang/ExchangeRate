//
//  MCExchangeRateRequest.m
//  ExchangeRate
//
//  Created by 常峻玮 on 15/7/23.
//  Copyright (c) 2015年 MingleChang. All rights reserved.
//

#import "MCExchangeRateRequest.h"
#import "MCExchangeRate.h"
#import "YQL.h"
#import "MCExchangeRateRoot.h"
@implementation MCExchangeRateRequest
#pragma mark - Public Motheds
+(void)requestExchangeRate:(MCExchangeRate *)exchangeRate completion:(void(^)(BOOL isSucceed,NSDictionary *info))completion{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        YQL *lYQL=[[YQL alloc]init];
        NSDictionary *lDic=[lYQL query:[self getYQLStringWith:@[exchangeRate]]];
        dispatch_sync(dispatch_get_main_queue(), ^{
            NSDictionary *lResultDic=[self getInfoFromRequestInfo:lDic];
            if ([lResultDic isKindOfClass:[NSDictionary class]]&&lResultDic.count>0) {
                completion(YES,lResultDic);
            }else{
                completion(NO,nil);
            }
        });
    });
}
+(void)requestExchangeRates:(NSArray *)exchangeRates completion:(void(^)(BOOL isSucceed,NSArray *info))completion{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        YQL *lYQL=[[YQL alloc]init];
        NSDictionary *lDic=[lYQL query:[self getYQLStringWith:exchangeRates]];
        dispatch_sync(dispatch_get_main_queue(), ^{
            NSArray *lResultArray=[self getInfoFromRequestInfo:lDic];
            if ([lResultArray isKindOfClass:[NSArray class]]&&lResultArray.count>0) {
                completion(YES,lResultArray);
            }else{
                completion(NO,nil);
            }
        });
    });
}

#pragma mark - Private Motheds
+(NSString *)getYQLStringWith:(NSArray *)exchangeRates{
    NSString *lPairString=@"";
    for (MCExchangeRate *lExchangeRate in exchangeRates) {
        if (![lPairString isEqualToString:@""]) {
            lPairString=[lPairString stringByAppendingString:@","];
        }
        lPairString=[lPairString stringByAppendingFormat:@"\"%@\"",lExchangeRate.identifier];
    }
    return [NSString stringWithFormat:@"select * from yahoo.finance.xchange where pair in (%@)",lPairString];
}
+(id)getInfoFromRequestInfo:(NSDictionary *)info{
    MCExchangeRateRoot *lExchangeRateRoot=[[MCExchangeRateRoot alloc]initWithDictionary:info];
    return lExchangeRateRoot.queryResult.result.rate;
}
@end
