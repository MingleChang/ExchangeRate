//
//  MCCurrencyListViewController.h
//  ExchangeRate
//
//  Created by 常峻玮 on 15/7/28.
//  Copyright (c) 2015年 MingleChang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MCCurrencyListViewController;
@protocol MCCurrencyListViewControllerDelegate <NSObject>

-(void)currencyListViewControllerRightBarButtonClick:(MCCurrencyListViewController *)viewController;
-(void)currencyListViewControllerLeftBarButtonClick:(MCCurrencyListViewController *)viewController;

@end

@interface MCCurrencyListViewController : UIViewController
@property(nonatomic,assign)id<MCCurrencyListViewControllerDelegate> delegate;
@end
