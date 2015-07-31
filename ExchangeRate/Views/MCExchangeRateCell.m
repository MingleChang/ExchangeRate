//
//  MCExchangeRateCell.m
//  CellTest
//
//  Created by 常峻玮 on 15/7/27.
//  Copyright (c) 2015年 MingleChang. All rights reserved.
//

#import "MCExchangeRateCell.h"
#import "MingleChang.h"
#import "MCCurrency.h"
#import "MCExchangeRate.h"
@interface MCExchangeRateCell()

@property (weak, nonatomic) IBOutlet UIButton *changeButton;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;


@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineViewHeightConstraint;

- (IBAction)changeButtonClick:(UIButton *)sender;
- (IBAction)deleteButtonClick:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UILabel *testLabel;

@end

@implementation MCExchangeRateCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    
    self.leftDistance=120;
    self.rightDistance=80;
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
-(void)resetCellUI{
    self.testLabel.text=self.exchangeRate.fromCurrency.unit;
}
#pragma mark - Event Response
- (IBAction)changeButtonClick:(UIButton *)sender {
    [self showStatus:PanCellStatusNormal with:NO];
    if ([self.delegate respondsToSelector:@selector(exchangeRateCellChangeButtonClick:)]) {
        [self.delegate exchangeRateCellChangeButtonClick:self];
    }
}

- (IBAction)deleteButtonClick:(UIButton *)sender {
    [self showStatus:PanCellStatusNormal with:NO];
    if ([self.delegate respondsToSelector:@selector(exchangeRateCellDeleteButtonClick:)]) {
        [self.delegate exchangeRateCellDeleteButtonClick:self];
    }
}
#pragma mark - Setter And Getter
-(void)setExchangeRate:(MCExchangeRate *)exchangeRate{
    _exchangeRate=exchangeRate;
    [self resetCellUI];
}
@end
