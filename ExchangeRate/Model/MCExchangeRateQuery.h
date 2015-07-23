//
//  MCExchangeRateQuery.h
//  ExchangeRate
//
//  Created by 常峻玮 on 15/7/23.
//  Copyright (c) 2015年 MingleChang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MCExchangeRateResult.h"

@interface MCExchangeRateQuery : NSObject
@property(nonatomic,strong)MCExchangeRateResult *result;
-(instancetype)initWithDictionary:(NSDictionary *)dic;
@end
