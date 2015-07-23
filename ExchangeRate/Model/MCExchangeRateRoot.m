//
//  MCExchangeRateRoot.m
//  ExchangeRate
//
//  Created by 常峻玮 on 15/7/23.
//  Copyright (c) 2015年 MingleChang. All rights reserved.
//

#import "MCExchangeRateRoot.h"
@implementation MCExchangeRateRoot
-(instancetype)initWithDictionary:(NSDictionary *)dic{
    self=[super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"query"]) {
        self.queryResult=[[MCExchangeRateQuery alloc]initWithDictionary:value];
    }
}
@end
