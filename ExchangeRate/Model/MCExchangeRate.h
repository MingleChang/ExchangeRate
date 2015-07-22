//
//  MCExchangeRate.h
//  ExchangeRate
//
//  Created by 常峻玮 on 15/7/22.
//  Copyright (c) 2015年 MingleChang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MCCountry;
@interface MCExchangeRate : NSObject
@property(nonatomic,strong)MCCountry *fromCountry;
@property(nonatomic,strong)MCCountry *toCountry;
@end
