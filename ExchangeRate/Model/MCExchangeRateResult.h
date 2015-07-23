//
//  MCExchangeRateResult.h
//  ExchangeRate
//
//  Created by 常峻玮 on 15/7/23.
//  Copyright (c) 2015年 MingleChang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCExchangeRateResult : NSObject
@property(nonatomic,copy)id rate;
-(instancetype)initWithDictionary:(NSDictionary *)dic;
@end
