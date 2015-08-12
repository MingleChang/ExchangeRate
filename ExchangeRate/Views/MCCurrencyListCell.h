//
//  MCCurrencyListCell.h
//  ExchangeRate
//
//  Created by 常峻玮 on 15/7/29.
//  Copyright (c) 2015年 MingleChang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MCCurrency;
@interface MCCurrencyListCell : UITableViewCell
@property(nonatomic,strong)MCCurrency *currency;
@property(nonatomic,assign)BOOL isSelected;
-(void)setupCurrency:(MCCurrency *)currency withIsSelected:(BOOL)isSelected;

@end
