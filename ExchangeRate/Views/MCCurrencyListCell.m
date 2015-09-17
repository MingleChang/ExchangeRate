//
//  MCCurrencyListCell.m
//  ExchangeRate
//
//  Created by 常峻玮 on 15/7/29.
//  Copyright (c) 2015年 MingleChang. All rights reserved.
//

#import "MCCurrencyListCell.h"
#import "MingleChang.h"
#import "MCCurrency.h"

@interface MCCurrencyListCell()

@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineViewHeightConstraint;



@property (weak, nonatomic) IBOutlet UILabel *currencyNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *currencySelectedLabel;
@end
@implementation MCCurrencyListCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    [self initAllSubviewAndData];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
#pragma mark - Private Motheds
-(void)initAllSubviewAndData{
    [self initAllSubviews];
    [self initAllData];
}
-(void)initAllSubviews{
    self.lineViewHeightConstraint.constant=ONE_PIXEL;
    self.currencySelectedLabel.text=@"已选择";
}
-(void)initAllData{
    
}
-(void)setupCurrency:(MCCurrency *)currency withIsSelected:(BOOL)isSelected{
    self.currency=currency;
    self.isSelected=isSelected;
    self.currencyNameLabel.text=[NSString stringWithFormat:@"%@(%@)",self.currency.localName,self.currency.unit];
    self.currencySelectedLabel.hidden=!isSelected;
}
#pragma mark - Setter And Getter

@end
