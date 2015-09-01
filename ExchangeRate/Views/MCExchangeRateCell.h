//
//  MCExchangeRateCell.h
//  CellTest
//
//  Created by 常峻玮 on 15/7/27.
//  Copyright (c) 2015年 MingleChang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCPanCell.h"


#define INPUT_VALUE_CHANGE_NOTIFICATION @"INPUT_VALUE_CHANGE_NOTIFICATION"

@class MCExchangeRate,MCExchangeRateCell;
@protocol MCExchangeRateCellDelegate <NSObject>

-(void)exchangeRateCellChangeButtonClick:(MCExchangeRateCell *)cell;
-(void)exchangeRateCellDeleteButtonClick:(MCExchangeRateCell *)cell;

@end
@interface MCExchangeRateCell : MCPanCell
@property(nonatomic,assign)id<MCExchangeRateCellDelegate> delegate;
@property(nonatomic,strong)MCExchangeRate *exchangeRate;
-(void)updateUI;
-(void)setCountLabelValue:(double)value;
@end
