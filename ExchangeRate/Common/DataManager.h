//
//  DataManager.h
//  ExchangeRate
//
//  Created by 常峻玮 on 15/7/22.
//  Copyright (c) 2015年 MingleChang. All rights reserved.
//

#import <UIKit/UIKit.h>
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
+(DataManager *)manager;
-(BOOL)checkNeedUpdate;
-(void)updateAllExchangeCompletion:(void(^)(BOOL isSucceed))completion;
-(void)saveSelectedCurrency;
-(void)saveAllExchangeRate;

-(MCExchangeRate *)getExchangeRateByCurrency:(MCCurrency *)currency;


-(void)updateLocalCache;
@end
