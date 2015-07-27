//
//  DataManager.h
//  ExchangeRate
//
//  Created by 常峻玮 on 15/7/22.
//  Copyright (c) 2015年 MingleChang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MCExchangeRate;
@interface DataManager : NSObject
@property(nonatomic,strong)MCExchangeRate *localeExchangeRate;
@property(nonatomic,copy)NSArray *allExchangeRates;
@property(nonatomic,copy)NSArray *allSelectedExchangeRates;
@property(nonatomic,copy)NSArray *allUnselectedExchangeRates;
+(DataManager *)manager;

@end
