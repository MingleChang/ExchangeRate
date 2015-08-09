//
//  DataManager.m
//  ExchangeRate
//
//  Created by 常峻玮 on 15/7/22.
//  Copyright (c) 2015年 MingleChang. All rights reserved.
//

#import "DataManager.h"
#import "MCCurrency.h"
#import "MCExchangeRate.h"
#import "FilePath.h"
#import "MCExchangeRateRequest.h"
#import "ToastManager.h"

#define ALL_EXCHANGE_UPDATE_DATE @"ALL_EXCHANGE_UPDATE_DATE"
#define CURRENCY_LIST_FILE @"Currency"
#define ALL_EXCHANGE_RATE_CACHE_NAME @"ALL_EXCHANGE_RATE_CACHE_NAME"
#define SELECTED_CURRENCY_CACHE_NAME @"SELECTED_CURRENCY_CACHE_NAME"
@implementation DataManager
+(DataManager *)manager{
    static DataManager *dataManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dataManager = [[DataManager alloc]init];
    });
    return  dataManager;
}
-(instancetype)init{
    self=[super init];
    if (self) {
        self.toCurrencyValue=10000;
    }
    return self;
}
#pragma mark - 
-(void)updateAllExchangeCompletion:(void(^)(BOOL isSucceed))completion{
    [MCExchangeRateRequest requestExchangeRates:self.allExchangeRate completion:^(BOOL isSucceed, NSArray *info) {
        if (isSucceed&&info.count==self.allExchangeRate.count) {
            for (int i=0; i<info.count; i++) {
                NSDictionary *lDic=[info objectAtIndex:i];
                MCExchangeRate *lExchange=[self.allExchangeRate objectAtIndex:i];
                [lExchange setExchangeRateInfo:lDic];
            }
            [ToastManager toastText:@"更新成功1"];
            [self saveAllExchangeRate];
            if(completion){
                completion(YES);
            }
        }else{
            [ToastManager toastText:@"更新失败1"];
            if(completion){
                completion(NO);
            }
        }
    }];
}
-(void)saveSelectedCurrency{
    NSString *lPath=[FilePath pathInDocumentWithFileName:SELECTED_CURRENCY_CACHE_NAME];
    [NSKeyedArchiver archiveRootObject:self.selectedCurrencies toFile:lPath];
}
-(void)saveAllExchangeRate{
    NSDate *lNowDate=[NSDate date];
    self.allExchangeRateUpdateDate=lNowDate;
    [[NSUserDefaults standardUserDefaults]setObject:lNowDate forKey:ALL_EXCHANGE_UPDATE_DATE];
    [NSUserDefaults resetStandardUserDefaults];
    NSString *lPath=[FilePath pathInDocumentWithFileName:ALL_EXCHANGE_RATE_CACHE_NAME];
    [NSKeyedArchiver archiveRootObject:self.allExchangeRate toFile:lPath];
}
-(NSArray *)readCacheSelectedCurrency{
    NSString *lPath=[FilePath pathInDocumentWithFileName:SELECTED_CURRENCY_CACHE_NAME];
    if ([[NSFileManager defaultManager]fileExistsAtPath:lPath]) {
        return [NSKeyedUnarchiver unarchiveObjectWithFile:lPath];
    }
    return [NSArray array];
}
-(NSArray *)readCacheAllExchangeRate{
    self.allExchangeRateUpdateDate=[[NSUserDefaults standardUserDefaults]objectForKey:ALL_EXCHANGE_UPDATE_DATE];
    NSString *lPath=[FilePath pathInDocumentWithFileName:ALL_EXCHANGE_RATE_CACHE_NAME];
    if (![[NSFileManager defaultManager]fileExistsAtPath:lPath]) {
        lPath=[[NSBundle mainBundle]pathForResource:@"AllExchangeRateCache" ofType:nil];
    }
    if ([[NSFileManager defaultManager]fileExistsAtPath:lPath]) {
        return [NSKeyedUnarchiver unarchiveObjectWithFile:lPath];
    }
    return [NSArray array];
}
-(NSArray *)readAllExchangeRateFromAllCurrencies{
    NSMutableArray *lArray=[NSMutableArray array];
    for (MCCurrency *lFromCurrency in self.allCurrencies) {
        MCExchangeRate *lExchangeRate=[[MCExchangeRate alloc]init];
        lExchangeRate.fromCurrency=lFromCurrency;
        lExchangeRate.toCurrency=self.toCurrency;
        [lArray addObject:lExchangeRate];
    }
    return [lArray copy];
}
#pragma mark - Setter And Getter
-(NSDate *)allExchangeRateUpdateDate{
    if (_allExchangeRateUpdateDate) {
        return _allExchangeRateUpdateDate;
    }
    _allExchangeRateUpdateDate=[[NSUserDefaults standardUserDefaults]objectForKey:ALL_EXCHANGE_UPDATE_DATE];
    return _allExchangeRateUpdateDate;
}
-(MCCurrency *)toCurrency{
    if (_toCurrency) {
        return _toCurrency;
    }
    _toCurrency=[[MCCurrency alloc]init];
    _toCurrency.name=@"";
    _toCurrency.unit=@"IRR";
    _toCurrency.symbol=@"";
    return _toCurrency;
}
-(NSArray *)allCurrencies{
    if (_allCurrencies) {
        return _allCurrencies;
    }
    _allCurrencies=[self.allExchangeRate valueForKey:@"fromCurrency"];
    return _allCurrencies;
}
-(void)setSelectedCurrencies:(NSArray *)selectedCurrencies{
    NSString *lPredicateString=@"";
    for (int i=0; i<selectedCurrencies.count; i++) {
        MCCurrency *lCurrency=[selectedCurrencies objectAtIndex:i];
        if (i==0) {
            lPredicateString=[lPredicateString stringByAppendingFormat:@"self.identifier LIKE '%@*'",lCurrency.unit];
        }else{
            lPredicateString=[lPredicateString stringByAppendingFormat:@" or self.identifier LIKE '%@*'",lCurrency.unit];
        }
    }
    @try {
        NSPredicate *lPredicate=[NSPredicate predicateWithFormat:lPredicateString];
        self.selectedExchangeRate=[[self.allExchangeRate filteredArrayUsingPredicate:lPredicate]mutableCopy];
    }
    @catch (NSException *exception) {
        self.selectedExchangeRate=[NSMutableArray array];
    }
}
-(NSArray *)selectedCurrencies{
    if (_selectedExchangeRate) {
        return [_selectedExchangeRate valueForKey:@"fromCurrency"];
    }
    NSArray *lArray=[self readCacheSelectedCurrency];
    [self setSelectedCurrencies:lArray];
    return lArray;
}
-(NSArray *)unselectedCurrencies{
    NSMutableArray *lArray=[self.allCurrencies mutableCopy];
    [lArray removeObjectsInArray:self.selectedCurrencies];
    return [lArray copy];
}
-(NSArray *)allExchangeRate{
    if (_allExchangeRate) {
        return _allExchangeRate;
    }
    NSArray *lArray=[self readCacheAllExchangeRate];
    _allExchangeRate=lArray;
    return _allExchangeRate;
}
-(NSMutableArray *)selectedExchangeRate{
    if (_selectedExchangeRate) {
        return _selectedExchangeRate;
    }
    [self setSelectedCurrencies:self.selectedCurrencies];
    return _selectedExchangeRate;
}
@end
