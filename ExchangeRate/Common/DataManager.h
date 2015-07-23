//
//  DataManager.h
//  ExchangeRate
//
//  Created by 常峻玮 on 15/7/22.
//  Copyright (c) 2015年 MingleChang. All rights reserved.
//

#import <Foundation/Foundation.h>
//select * from yahoo.finance.xchange where pair in ("EURUSD","GBPUSD")
@interface DataManager : NSObject
+(DataManager *)manager;
@end
