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

#define CURRENCY_LIST_FILE @"CurrencyJSON"
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
        
    }
    return self;
}
#pragma mark - 
-(NSArray *)readCacheSelectedCurrency{
    NSString *lPath=[FilePath pathInDocumentWithFileName:SELECTED_CURRENCY_CACHE_NAME];
    if ([[NSFileManager defaultManager]fileExistsAtPath:lPath]) {
        return [NSKeyedUnarchiver unarchiveObjectWithFile:lPath];
    }
    return [NSArray array];
}
-(NSArray *)readCacheAllExchangeRate{
    NSString *lPath=[FilePath pathInDocumentWithFileName:ALL_EXCHANGE_RATE_CACHE_NAME];
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
-(MCCurrency *)toCurrency{
    if (_toCurrency) {
        return _toCurrency;
    }
    _toCurrency=[[MCCurrency alloc]init];
    _toCurrency.name=@"";
    _toCurrency.unit=@"VND";
    _toCurrency.symbol=@"₫";
    return _toCurrency;
}
-(NSArray *)allCurrencies{
    if (_allCurrencies) {
        return _allCurrencies;
    }
    NSString *lPath=[[NSBundle mainBundle]pathForResource:CURRENCY_LIST_FILE ofType:@"json"];
    NSData *lData=[NSData dataWithContentsOfFile:lPath];
    NSArray *lJSONArray=[NSJSONSerialization JSONObjectWithData:lData options:NSJSONReadingAllowFragments error:nil];
    NSMutableArray *lCurrencies=[NSMutableArray array];
    for (NSDictionary *lDic in lJSONArray) {
        MCCurrency *lCurrency=[[MCCurrency alloc]initWithDictionary:lDic];
        [lCurrencies addObject:lCurrency];
    }
    _allCurrencies=[lCurrencies copy];
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
        self.selectedExchangeRate=[self.allExchangeRate filteredArrayUsingPredicate:lPredicate];
    }
    @catch (NSException *exception) {
        self.selectedExchangeRate=[NSArray array];
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
    if (lArray.count!=self.allCurrencies.count) {
        lArray=[self readAllExchangeRateFromAllCurrencies];
    }
    _allExchangeRate=lArray;
    return _allExchangeRate;
}
-(NSArray *)selectedExchangeRate{
    if (_selectedExchangeRate) {
        return _selectedExchangeRate;
    }
    [self setSelectedCurrencies:self.selectedCurrencies];
    return _selectedExchangeRate;
}
@end
