//
//  MCSentence.h
//  ExchangeRate
//
//  Created by 常峻玮 on 15/8/31.
//  Copyright (c) 2015年 MingleChang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCSentence : NSObject
@property(nonatomic,readonly)NSString *showName;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *detail;
-(instancetype)initWithDic:(NSDictionary *)dic;
@end
