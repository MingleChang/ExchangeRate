//
//  MCCurrencyListViewController.h
//  ExchangeRate
//
//  Created by 常峻玮 on 15/7/28.
//  Copyright (c) 2015年 MingleChang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MCCurrencyListViewController;
@class MCExchangeRate;
@protocol MCCurrencyListViewControllerDelegate <NSObject>

-(void)currencyListViewControllerSelectNewCurrency:(MCCurrencyListViewController *)viewController;

@end

@interface MCCurrencyListViewController : UIViewController
@property(nonatomic,strong)MCExchangeRate *replaceExchangeRate;
@property(nonatomic,assign)id<MCCurrencyListViewControllerDelegate> delegate;
@end
