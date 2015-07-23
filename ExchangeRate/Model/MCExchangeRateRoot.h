//
//  MCExchangeRateRoot.h
//  ExchangeRate
//
//  Created by 常峻玮 on 15/7/23.
//  Copyright (c) 2015年 MingleChang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MCExchangeRateQuery.h"
@interface MCExchangeRateRoot : NSObject
@property(nonatomic,strong)MCExchangeRateQuery *queryResult;
-(instancetype)initWithDictionary:(NSDictionary *)dic;
@end
