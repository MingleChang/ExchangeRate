//
//  MCExchangeRateViewController.m
//  ExchangeRate
//
//  Created by 常峻玮 on 15/7/27.
//  Copyright (c) 2015年 MingleChang. All rights reserved.
//

#import "MCExchangeRateViewController.h"
#import "MCExchangeRateCell.h"
#import "DataManager.h"
#import "ToastManager.h"
#import "MBProgressHUD.h"
#import "MingleChang.h"
#import "MCCurrencyListNavigationController.h"
#import "MCCurrencyListViewController.h"

#define MCExchangeRateCellID @"MCExchangeRateCell"
#define MCCurrencyListNavigationControllerID @"MCCurrencyListNavigationController"
#define MCCurrencyListViewControllerID @"MCCurrencyListViewController"

@interface MCExchangeRateViewController ()<UITableViewDataSource,UITableViewDelegate,MCCurrencyListViewControllerDelegate,MCExchangeRateCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIView *emptyView;
- (IBAction)emptyViewTapGestureClick:(UITapGestureRecognizer *)sender;
- (IBAction)rightBarButtonItemClick:(UIBarButtonItem *)sender;

@end

@implementation MCExchangeRateViewController
-(void)dealloc{
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initAllSubviewAndData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Private Motheds
-(void)initAllSubviewAndData{
    [self initAllSubviews];
    [self initAllData];
}
-(void)initAllSubviews{
    [self.tableView registerNib:[UINib nibWithNibName:MCExchangeRateCellID bundle:nil] forCellReuseIdentifier:MCExchangeRateCellID];
    [self changeEmptyHidden];
}
-(void)initAllData{
    [self checkUpdateAllExchangeRate];
}
-(void)checkUpdateAllExchangeRate{
    if (![DataManager manager].allExchangeRateUpdateDate) {
        MBProgressHUD *lProgress=[MBProgressHUD showHUDAddedTo:[MCDevice getAppFrontWindow] animated:YES];
        [[DataManager manager]updateAllExchangeCompletion:^(BOOL isSucceed) {
            [lProgress hide:YES];
        }];
    }
}
-(void)changeEmptyHidden{
    if ([DataManager manager].selectedExchangeRate.count>0) {
        self.emptyView.hidden=YES;
    }else{
        self.emptyView.hidden=NO;
    }
}
#pragma mark - Event Response
- (IBAction)emptyViewTapGestureClick:(UITapGestureRecognizer *)sender {
    [self performSegueWithIdentifier:MCCurrencyListNavigationControllerID sender:nil];
}

- (IBAction)rightBarButtonItemClick:(UIBarButtonItem *)sender {
    [self performSegueWithIdentifier:MCCurrencyListNavigationControllerID sender:nil];
}
#pragma mark - TableView DataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [DataManager manager].selectedExchangeRate.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MCExchangeRateCell *lCell=[tableView dequeueReusableCellWithIdentifier:MCExchangeRateCellID forIndexPath:indexPath];
    NSInteger row=[indexPath row];
    lCell.exchangeRate=[[DataManager manager].selectedExchangeRate objectAtIndex:row];
    lCell.delegate=self;
    return lCell;
}
#pragma mark - MCCurrencyListViewController Delegate
-(void)currencyListViewControllerRightBarButtonClick:(MCCurrencyListViewController *)viewController{
    [self changeEmptyHidden];
    [self.tableView reloadData];
}
-(void)currencyListViewControllerLeftBarButtonClick:(MCCurrencyListViewController *)viewController{
    
}
#pragma mark - MCExchangeRateCell Delegate
-(void)exchangeRateCellChangeButtonClick:(MCExchangeRateCell *)cell{
    
}
-(void)exchangeRateCellDeleteButtonClick:(MCExchangeRateCell *)cell{
    NSIndexPath *lIndexPath=[self.tableView indexPathForCell:cell];
    if (lIndexPath==nil) {
        return;
    }
    NSMutableArray *lArray=[[DataManager manager].selectedExchangeRate mutableCopy];
    [lArray removeObjectAtIndex:lIndexPath.row];
    [DataManager manager].selectedExchangeRate=[lArray copy];
    [[DataManager manager]saveSelectedCurrency];
    [self.tableView beginUpdates];
    [self.tableView deleteRowsAtIndexPaths:@[lIndexPath] withRowAnimation:UITableViewRowAnimationLeft];
    [self.tableView endUpdates];
}
#pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:MCCurrencyListNavigationControllerID]) {
        MCCurrencyListNavigationController *lNavigationController=[segue destinationViewController];
        MCCurrencyListViewController *lViewController=(MCCurrencyListViewController *)lNavigationController.topViewController;
        lViewController.delegate=self;
    }
    if ([segue.identifier isEqualToString:MCCurrencyListViewControllerID]) {
        
    }
}
 
@end
