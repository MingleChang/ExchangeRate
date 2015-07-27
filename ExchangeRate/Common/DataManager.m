//
//  DataManager.m
//  ExchangeRate
//
//  Created by 常峻玮 on 15/7/22.
//  Copyright (c) 2015年 MingleChang. All rights reserved.
//

#import "DataManager.h"
#import "MCCurrency.h"
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

#pragma mark - Setter And Getter
-(NSArray *)allCurrencies{
    if (_allCurrencies) {
        return _allCurrencies;
    }
    NSString *lPath=[[NSBundle mainBundle]pathForResource:@"CurrencyArrayJSON" ofType:@"json"];
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
-(NSArray *)selectedCurrencies{
    if (_selectedCurrencies) {
        return _selectedCurrencies;
    }
    return _selectedCurrencies;
}
@end
