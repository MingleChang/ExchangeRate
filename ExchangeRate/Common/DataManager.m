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
-(MCExchangeRate *)getExchangeRateByCurrency:(MCCurrency *)currency{
    for (MCExchangeRate *lExchangeRate in self.allExchangeRate) {
        if ([lExchangeRate.fromCurrency isEqualCurrency:currency]) {
            return lExchangeRate;
        }
    }
    return nil;
}
-(BOOL)checkNeedUpdate{
//    NSInteger timezoneFix=[NSTimeZone localTimeZone].secondsFromGMT;
//    NSDate *lNowDate=[NSDate date];
//    NSInteger lNowDays=((NSInteger)[lNowDate timeIntervalSince1970]+timezoneFix)/(60*60*24);
//    NSInteger lLastUpdateDays=((NSInteger)[self.allExchangeRateUpdateDate timeIntervalSince1970]+timezoneFix)/(60*60*24);
//    if (lNowDays==lLastUpdateDays) {
//        return NO;
//    }else{
//        return YES;
//    }
    if (self.allExchangeRateUpdateDate==nil) {
        return YES;
    }
    NSDate *lNowDate=[NSDate date];
    if ([lNowDate timeIntervalSinceDate:self.allExchangeRateUpdateDate]>60*60) {
        return YES;
    }else{
        return NO;
    }
    
}
-(void)updateAllExchangeCompletion:(void(^)(BOOL isSucceed))completion{
    [MCExchangeRateRequest requestExchangeRates:self.allExchangeRate completion:^(BOOL isSucceed, NSArray *info) {
        if (isSucceed&&info.count==self.allExchangeRate.count) {
            for (int i=0; i<info.count; i++) {
                NSDictionary *lDic=[info objectAtIndex:i];
                MCExchangeRate *lExchange=[self.allExchangeRate objectAtIndex:i];
                [lExchange setExchangeRateInfo:lDic];
            }
            [self saveAllExchangeRate];
            if(completion){
                completion(YES);
            }
        }else{
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
    }else{
        NSString *lJSONPath=[[NSBundle mainBundle]pathForResource:@"SelectedCurrencies" ofType:@"json"];
        NSData *lData=[NSData dataWithContentsOfFile:lJSONPath];
        NSArray *lJSONArray=[NSJSONSerialization JSONObjectWithData:lData options:NSJSONReadingAllowFragments error:nil];
        NSMutableArray *lCurrencies=[NSMutableArray array];
        for (NSDictionary *lDic in lJSONArray) {
            MCCurrency *lCurrency=[[MCCurrency alloc]initWithDictionary:lDic];
            [lCurrencies addObject:lCurrency];
        }
        return [lCurrencies copy];
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
        NSArray *lSelectedExchangeRate=[self.allExchangeRate filteredArrayUsingPredicate:lPredicate];
        self.selectedExchangeRate=[NSMutableArray array];
        for (MCCurrency *lCurrency in selectedCurrencies) {
            for (MCExchangeRate *lExchangeRate in lSelectedExchangeRate) {
                if ([lExchangeRate.fromCurrency isEqualCurrency:lCurrency]) {
                    [self.selectedExchangeRate addObject:lExchangeRate];
                    break;
                }
            }
        }
//        self.selectedExchangeRate=[[self.allExchangeRate filteredArrayUsingPredicate:lPredicate]mutableCopy];
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
-(MCExchangeRate *)clickExchangeRate{
    if (_clickExchangeRate) {
        return _clickExchangeRate;
    }
    NSString *clickStr=[[NSUserDefaults standardUserDefaults]stringForKey:CLICK_EXCHANGERATE];
    if (clickStr.length==0) {
        clickStr=@"CNY";
    }
    NSString *lPredicateString=[NSString stringWithFormat:@"self.fromCurrency.unit LIKE '%@'",clickStr];
    NSPredicate *lPredicate=[NSPredicate predicateWithFormat:lPredicateString];
    NSArray *lPredicateArray=[self.allExchangeRate filteredArrayUsingPredicate:lPredicate];
    if (lPredicateArray.count>0) {
        return lPredicateArray[0];
    }
    return nil;
}
-(double)clickValue{
    if (_clickValue!=0) {
        return _clickValue;
    }
    _clickValue=[[NSUserDefaults standardUserDefaults]doubleForKey:CLICK_VALUE];
    if(_clickValue==0){
        _clickValue=100;
    }
    return _clickValue;
}
#pragma mark - TEST

-(void)updateLocalCache{
    NSString *lPath=[[NSBundle mainBundle]pathForResource:CURRENCY_LIST_FILE ofType:@"json"];
    NSData *lData=[NSData dataWithContentsOfFile:lPath];
    NSArray *lJSONArray=[NSJSONSerialization JSONObjectWithData:lData options:NSJSONReadingAllowFragments error:nil];
    NSMutableArray *lCurrencies=[NSMutableArray array];
    for (NSDictionary *lDic in lJSONArray) {
        MCCurrency *lCurrency=[[MCCurrency alloc]initWithDictionary:lDic];
        [lCurrencies addObject:lCurrency];
    }

    NSMutableArray *lArray=[NSMutableArray array];
    for (MCCurrency *lFromCurrency in lCurrencies) {
        MCExchangeRate *lExchangeRate=[[MCExchangeRate alloc]init];
        lExchangeRate.fromCurrency=lFromCurrency;
        lExchangeRate.toCurrency=self.toCurrency;
        [lArray addObject:lExchangeRate];
    }
    
    [MCExchangeRateRequest requestExchangeRates:lArray completion:^(BOOL isSucceed, NSArray *info) {
        if (isSucceed&&info.count==self.allExchangeRate.count) {
            for (int i=0; i<info.count; i++) {
                NSDictionary *lDic=[info objectAtIndex:i];
                MCExchangeRate *lExchange=[lArray objectAtIndex:i];
                [lExchange setExchangeRateInfo:lDic];
            }
            
            [NSKeyedArchiver archiveRootObject:lArray toFile:@"/Users/Mingle/Desktop/AllExchangeRateCache"];
        }else{
            
        }
    }];
}
@end
