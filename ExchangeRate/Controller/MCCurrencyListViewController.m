//
//  MCCurrencyListViewController.m
//  ExchangeRate
//
//  Created by 常峻玮 on 15/7/28.
//  Copyright (c) 2015年 MingleChang. All rights reserved.
//

#import "MCCurrencyListViewController.h"
#import "DataManager.h"
#import "MCCurrencyListCell.h"
#import "MCCurrency.h"
#import "MingleChang.h"
#define MCCurrencyListCellID @"MCCurrencyListCell"

@interface MCCurrencyListViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic,strong)NSMutableArray *selectedCurrencies;
@property(nonatomic,strong)NSMutableArray *unselectedCurrencies;
- (IBAction)leftBarButtonClick:(UIBarButtonItem *)sender;
- (IBAction)rightBarButtonClick:(UIBarButtonItem *)sender;

@end

@implementation MCCurrencyListViewController
-(void)dealloc{
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initAllSubViewAndData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)initAllSubViewAndData{
    [self initAllSubViews];
    [self initAllData];
}
-(void)initAllSubViews{
    [self.tableView registerNib:[UINib nibWithNibName:MCCurrencyListCellID bundle:nil] forCellReuseIdentifier:MCCurrencyListCellID];
    self.tableView.editing=YES;
}
-(void)initAllData{
    self.selectedCurrencies=[[DataManager manager].selectedCurrencies mutableCopy];
    self.unselectedCurrencies=[[DataManager manager].unselectedCurrencies mutableCopy];
}
#pragma mark - Event Response
- (IBAction)leftBarButtonClick:(UIBarButtonItem *)sender {
    if ([self.delegate respondsToSelector:@selector(currencyListViewControllerLeftBarButtonClick:)]) {
        [self.delegate currencyListViewControllerLeftBarButtonClick:self];
    }
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)rightBarButtonClick:(UIBarButtonItem *)sender {
    [DataManager manager].selectedCurrencies=[self.selectedCurrencies copy];
    [[DataManager manager]saveSelectedCurrency];
    if ([self.delegate respondsToSelector:@selector(currencyListViewControllerRightBarButtonClick:)]) {
        [self.delegate currencyListViewControllerRightBarButtonClick:self];
    }
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - TableView DataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return self.selectedCurrencies.count;
    }else{
        return self.unselectedCurrencies.count;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MCCurrencyListCell *lCell=[tableView dequeueReusableCellWithIdentifier:MCCurrencyListCellID forIndexPath:indexPath];
    NSInteger row=[indexPath row];
    NSInteger section=[indexPath section];
    MCCurrency *lCurrency=nil;
    if (section==0) {
        lCurrency=[self.selectedCurrencies objectAtIndex:row];
        lCell.backgroundColor=RGBA(0, 0, 0, 0.2);
    }else{
        lCurrency=[self.unselectedCurrencies objectAtIndex:row];
        lCell.backgroundColor=[UIColor clearColor];
    }
    lCell.currency=lCurrency;
    return lCell;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath section] == 0) {
        return YES;
    }else{
        return NO;
    }
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath == nil) {//5s 7.1 点快了会传回nil
        return;
    }
    NSInteger row=[indexPath row];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        MCCurrency *lCurrency=[self.selectedCurrencies objectAtIndex:row];
        [self.selectedCurrencies removeObjectAtIndex:row];
        [tableView beginUpdates];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        [tableView endUpdates];
        
        [self.unselectedCurrencies addObject:lCurrency];
        [tableView beginUpdates];
        [tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.unselectedCurrencies.count - 1 inSection:1]] withRowAnimation:UITableViewRowAnimationAutomatic];
        [tableView endUpdates];
        
        if (self.unselectedCurrencies.count==1) {
            [tableView reloadSections:[[NSIndexSet alloc] initWithIndex:1] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
    }else if (editingStyle == UITableViewCellEditingStyleInsert)
    {
        MCCurrency *lCurrency=[self.unselectedCurrencies objectAtIndex:row];
        [self.unselectedCurrencies removeObjectAtIndex:row];
        [tableView beginUpdates];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        [tableView endUpdates];
        
        [self.selectedCurrencies addObject:lCurrency];
        [tableView beginUpdates];
        [tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.selectedCurrencies.count - 1 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
        [tableView endUpdates];
        
        if (self.unselectedCurrencies.count == 0) {
            [tableView reloadSections:[[NSIndexSet alloc] initWithIndex:1] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
    }
}
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    
    [self.selectedCurrencies exchangeObjectAtIndex:sourceIndexPath.row withObjectAtIndex:destinationIndexPath.row];
}
#pragma mark - TableView Delegate
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return 44;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section==1) {
        UIView *lView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 44)];
        lView.backgroundColor=[UIColor clearColor];
        UIView *lLineView=[[UIView alloc]initWithFrame:CGRectMake(0,44-ONE_PIXEL, tableView.frame.size.width, ONE_PIXEL)];
        lLineView.backgroundColor=RGB(137, 137, 137);
        [lView addSubview:lLineView];
        UILabel *lLabel=[[UILabel alloc]initWithFrame:CGRectMake(13, 44-25, tableView.frame.size.width, 20)];
        lLabel.textColor=[UIColor whiteColor];
        lLabel.font=[UIFont systemFontOfSize:15];
        lLabel.text=@"未选择货币";
        [lView addSubview:lLabel];
        return lView;
    }else{
        return nil;
    }
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([indexPath section]==0) {
        return UITableViewCellEditingStyleDelete;
    }else{
        return UITableViewCellEditingStyleInsert;
    }
}
- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath
{
    if (proposedDestinationIndexPath.section == 1) {
        return sourceIndexPath;
    }else{
        return proposedDestinationIndexPath;
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
