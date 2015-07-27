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
@property(nonatomic,strong)MCCurrency *localeCurrency;
@property(nonatomic,copy)NSArray *allCurrencies;
@property(nonatomic,copy)NSArray *selectedCurrencies;
@property(nonatomic,copy)NSArray *unselectedCurrencies;
+(DataManager *)manager;

@end
