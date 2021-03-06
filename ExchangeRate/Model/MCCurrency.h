//
//  MCCurrency.h
//  ExchangeRate
//
//  Created by 常峻玮 on 15/7/23.
//  Copyright (c) 2015年 MingleChang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCCurrency : NSObject<NSCoding>
@property(nonatomic,copy)NSString *prefix;
@property(nonatomic,copy)NSString *cate;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *localName;
@property(nonatomic,copy)NSString *unit;
@property(nonatomic,copy)NSString *symbol;
-(instancetype)initWithDictionary:(NSDictionary *)dic;
-(BOOL)isEqualCurrency:(MCCurrency *)currency;
@end
