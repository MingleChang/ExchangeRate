//
//  MCExchangeRate.h
//  ExchangeRate
//
//  Created by 常峻玮 on 15/7/22.
//  Copyright (c) 2015年 MingleChang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MCCurrency;
@interface MCExchangeRate : NSObject<NSCoding>

@property(nonatomic,copy,readonly)NSString *identifier;

@property(nonatomic,strong)MCCurrency *fromCurrency;
@property(nonatomic,strong)MCCurrency *toCurrency;

@property(nonatomic,assign)CGFloat rate;
@property(nonatomic,assign)CGFloat ask;
@property(nonatomic,assign)CGFloat bid;

@property(nonatomic,copy)NSDate *date;

-(void)setExchangeRateInfo:(NSDictionary *)dic;
@end
