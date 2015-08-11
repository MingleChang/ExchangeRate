//
//  MCExchangeRateRequest.h
//  ExchangeRate
//
//  Created by 常峻玮 on 15/7/23.
//  Copyright (c) 2015年 MingleChang. All rights reserved.
//

#import <Foundation/Foundation.h>
//http://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20yahoo.finance.xchange%20where%20pair%20in%20(%22GBPUSD%22,%22HKDUSD%22)&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys&callback=
//select * from yahoo.finance.xchange where pair in ("EURUSD","GBPUSD")
//{"query":{"count":2,"created":"2015-07-23T01:41:37Z","lang":"zh-cn","results":{"rate":[{"id":"EURUSD","Name":"EUR/USD","Rate":"1.0940","Date":"7/23/2015","Time":"2:41am","Ask":"1.0942","Bid":"1.0937"},{"id":"GBPUSD","Name":"GBP/USD","Rate":"1.5614","Date":"7/23/2015","Time":"2:41am","Ask":"1.5616","Bid":"1.5612"}]}}}
@class MCExchangeRate;
@interface MCExchangeRateRequest : NSObject
+(void)requestExchangeRate:(MCExchangeRate *)exchangeRate completion:(void(^)(BOOL isSucceed,NSDictionary *info))completion;
+(void)requestExchangeRates:(NSArray *)exchangeRates completion:(void(^)(BOOL isSucceed,NSArray *info))completion;
@end
