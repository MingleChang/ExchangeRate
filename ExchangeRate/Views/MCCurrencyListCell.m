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



@property (weak, nonatomic) IBOutlet UILabel *testLabel;

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
}
-(void)initAllData{
    
}
-(void)updateUI{
    self.testLabel.text=[NSString stringWithFormat:@"%@(%@)",self.currency.name,self.currency.unit];
}
#pragma mark - Setter And Getter

@end
