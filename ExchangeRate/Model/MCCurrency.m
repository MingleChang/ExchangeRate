//
//  MCCurrency.m
//  ExchangeRate
//
//  Created by 常峻玮 on 15/7/23.
//  Copyright (c) 2015年 MingleChang. All rights reserved.
//

#import "MCCurrency.h"

#define CURRENCY_NAME_CODING_KEY @"CURRENCY_NAME_CODING_KEY"
#define CURRENCY_UNIT_CODING_KEY @"CURRENCY_UNIT_CODING_KEY"
#define CURRENCY_SYMBOL_CODING_KEY @"CURRENCY_SYMBOL_CODING_KEY"

@interface MCCurrency()

@end
@implementation MCCurrency

#pragma mark - Coding
-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.name forKey:CURRENCY_NAME_CODING_KEY];
    [aCoder encodeObject:self.unit forKey:CURRENCY_UNIT_CODING_KEY];
    [aCoder encodeObject:self.symbol forKey:CURRENCY_SYMBOL_CODING_KEY];
}
- (id)initWithCoder:(NSCoder *)aDecoder{
    self=[super init];
    if (self) {
        self.name=[aDecoder decodeObjectForKey:CURRENCY_NAME_CODING_KEY];
        self.unit=[aDecoder decodeObjectForKey:CURRENCY_UNIT_CODING_KEY];
        self.symbol=[aDecoder decodeObjectForKey:CURRENCY_SYMBOL_CODING_KEY];
    }
    return self;
}
@end
