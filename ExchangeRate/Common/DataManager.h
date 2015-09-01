//
//  DataManager.h
//  ExchangeRate
//
//  Created by 常峻玮 on 15/7/22.
//  Copyright (c) 2015年 MingleChang. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ALL_EXCHANGE_UPDATE_DATE @"ALL_EXCHANGE_UPDATE_DATE"
#define CURRENCY_LIST_FILE @"Currency"
#define ALL_EXCHANGE_RATE_CACHE_NAME @"ALL_EXCHANGE_RATE_CACHE_NAME"
#define SELECTED_CURRENCY_CACHE_NAME @"SELECTED_CURRENCY_CACHE_NAME"

#define CLICK_EXCHANGERATE @"CLICK_EXCHANGERATE"
#define CLICK_VALUE @"CLICK_VALUE"

@class MCExchangeRate;
@class MCCurrency;
@interface DataManager : NSObject
@property(nonatomic,strong)NSDate *allExchangeRateUpdateDate;
@property(nonatomic,strong)MCCurrency *toCurrency;
@property(nonatomic,assign)double toCurrencyValue;
@property(nonatomic,copy)NSArray *allCurrencies;
@property(nonatomic,copy)NSArray *selectedCurrencies;
@property(nonatomic,copy,readonly)NSArray *unselectedCurrencies;
@property(nonatomic,copy)NSArray *allExchangeRate;
@property(nonatomic,strong)NSMutableArray *selectedExchangeRate;

@property(nonatomic,strong)MCExchangeRate *clickExchangeRate;
@property(nonatomic,assign)double clickValue;
+(DataManager *)manager;
-(BOOL)checkNeedUpdate;
-(void)updateAllExchangeCompletion:(void(^)(BOOL isSucceed))completion;
-(void)saveSelectedCurrency;
-(void)saveAllExchangeRate;

-(MCExchangeRate *)getExchangeRateByCurrency:(MCCurrency *)currency;


-(void)updateLocalCache;
@end
