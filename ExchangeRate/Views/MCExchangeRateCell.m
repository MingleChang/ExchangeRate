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
#import "DataManager.h"

#define INPUT_VALUE_CHANGE_NOTIFICATION @"INPUT_VALUE_CHANGE_NOTIFICATION"

@interface MCExchangeRateCell()

@property (weak, nonatomic) IBOutlet UIImageView *currencyImageView;
@property (weak, nonatomic) IBOutlet UILabel *currencyUnitLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UILabel *currencyName;


@property (weak, nonatomic) IBOutlet UIButton *changeButton;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;


@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineViewHeightConstraint;

- (IBAction)changeButtonClick:(UIButton *)sender;
- (IBAction)deleteButtonClick:(UIButton *)sender;

@end

@implementation MCExchangeRateCell
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    [self initAllSubviewAndData];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if (selected) {
        self.countLabel.textColor=RGB(39, 174, 240);
    }else{
        self.countLabel.textColor=RGB(80, 80, 80);
    }
}
#pragma mark - Private Motheds
-(void)initAllSubviewAndData{
    [self initAllSubviews];
    [self initAllData];
}
-(void)initAllSubviews{
    self.leftDistance=120;
    self.rightDistance=80;
    self.lineViewHeightConstraint.constant=ONE_PIXEL;
}
-(void)initAllData{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(inputValueChangeNotification:) name:INPUT_VALUE_CHANGE_NOTIFICATION object:nil];
}
-(void)updateUI{
    self.currencyImageView.image=[UIImage imageNamed:self.exchangeRate.fromCurrency.unit];
    self.currencyUnitLabel.text=self.exchangeRate.fromCurrency.unit;
    self.currencyName.text=self.exchangeRate.fromCurrency.name;
    [self showNormalWith:NO];
    [self setCountLabelValue];
}
-(void)inputValueChangeNotification:(NSNotification *)sender{
    if ([sender.object isEqual:self]) {
        return;
    }
    [self setCountLabelValue];
}
-(void)setCountLabelValue{
    double lValue=[DataManager manager].toCurrencyValue/self.exchangeRate.rate;
    NSNumberFormatter *lNumberFormat=[[NSNumberFormatter alloc]init];
    [lNumberFormat setNumberStyle:NSNumberFormatterDecimalStyle];
    self.countLabel.text=[lNumberFormat stringFromNumber:@(lValue)];
}
-(void)setCountLabelValue:(double)value{
    [DataManager manager].toCurrencyValue=value*self.exchangeRate.rate;
    [[NSNotificationCenter defaultCenter]postNotificationName:INPUT_VALUE_CHANGE_NOTIFICATION object:self];
    NSNumberFormatter *lNumberFormat=[[NSNumberFormatter alloc]init];
    [lNumberFormat setNumberStyle:NSNumberFormatterDecimalStyle];
    self.countLabel.text=[lNumberFormat stringFromNumber:@(value)];
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

@end
