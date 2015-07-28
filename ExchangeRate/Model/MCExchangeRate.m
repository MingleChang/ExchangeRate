//
//  MCExchangeRate.m
//  ExchangeRate
//
//  Created by 常峻玮 on 15/7/22.
//  Copyright (c) 2015年 MingleChang. All rights reserved.
//

#import "MCExchangeRate.h"
#import "MCCurrency.h"

#define EXCHANGERATE_FROMCURRENCY_CODING_KEY @"EXCHANGERATE_FROMCURRENCY_CODING_KEY"
#define EXCHANGERATE_TOCURRENCY_CODING_KEY @"EXCHANGERATE_TOCURRENCY_CODING_KEY"
#define EXCHANGERATE_RATE_CODING_KEY @"EXCHANGERATE_RATE_CODING_KEY"
#define EXCHANGERATE_ASK_CODING_KEY @"EXCHANGERATE_ASK_CODING_KEY"
#define EXCHANGERATE_BID_CODING_KEY @"EXCHANGERATE_BID_CODING_KEY"
#define EXCHANGERATE_DATE_CODING_KEY @"EXCHANGERATE_DATE_CODING_KEY"

@interface MCExchangeRate()

@end
@implementation MCExchangeRate

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

-(void)setExchangeRateInfo:(NSDictionary *)dic{
    [self setValuesForKeysWithDictionary:dic];
    self.date=[NSDate date];
}

-(NSString *)description{
    return [NSString stringWithFormat:@"from:%@   to:%@",self.fromCurrency,self.toCurrency];
}
#pragma mark - Setter And Getter
-(NSString *)identifier{
    if (self.fromCurrency&&self.toCurrency) {
        return [NSString stringWithFormat:@"%@%@",self.fromCurrency.unit,self.toCurrency.unit];
    }
    return @"";
}

#pragma mark - Coding
-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.fromCurrency forKey:EXCHANGERATE_FROMCURRENCY_CODING_KEY];
    [aCoder encodeObject:self.toCurrency forKey:EXCHANGERATE_TOCURRENCY_CODING_KEY];
    [aCoder encodeDouble:self.rate forKey:EXCHANGERATE_RATE_CODING_KEY];
    [aCoder encodeDouble:self.ask forKey:EXCHANGERATE_ASK_CODING_KEY];
    [aCoder encodeDouble:self.bid forKey:EXCHANGERATE_BID_CODING_KEY];
    [aCoder encodeObject:self.date forKey:EXCHANGERATE_DATE_CODING_KEY];
}
- (id)initWithCoder:(NSCoder *)aDecoder{
    self=[super init];
    if (self) {
        self.fromCurrency=[aDecoder decodeObjectForKey:EXCHANGERATE_FROMCURRENCY_CODING_KEY];
        self.toCurrency=[aDecoder decodeObjectForKey:EXCHANGERATE_TOCURRENCY_CODING_KEY];
        self.rate=[aDecoder decodeDoubleForKey:EXCHANGERATE_RATE_CODING_KEY];
        self.ask=[aDecoder decodeDoubleForKey:EXCHANGERATE_ASK_CODING_KEY];
        self.bid=[aDecoder decodeDoubleForKey:EXCHANGERATE_BID_CODING_KEY];
        self.date=[aDecoder decodeObjectForKey:EXCHANGERATE_DATE_CODING_KEY];
    }
    return self;
}

@end
