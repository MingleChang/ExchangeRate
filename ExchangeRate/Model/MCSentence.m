//
//  MCSentence.m
//  ExchangeRate
//
//  Created by 常峻玮 on 15/8/31.
//  Copyright (c) 2015年 MingleChang. All rights reserved.
//

#import "MCSentence.h"

@implementation MCSentence
-(instancetype)initWithDic:(NSDictionary *)dic{
    self=[super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

-(NSString *)showName{
    NSString *lString=@"——";
    return [lString stringByAppendingString:self.name];
}
@end
