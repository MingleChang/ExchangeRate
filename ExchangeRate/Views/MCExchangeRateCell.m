//
//  MCExchangeRateCell.m
//  CellTest
//
//  Created by 常峻玮 on 15/7/27.
//  Copyright (c) 2015年 MingleChang. All rights reserved.
//

#import "MCExchangeRateCell.h"

@implementation MCExchangeRateCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    
    
    self.leftDistance=10;
    self.rightDistance=100;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
