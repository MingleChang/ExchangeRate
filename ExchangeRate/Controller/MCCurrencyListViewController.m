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

@import GoogleMobileAds;

#define MCCurrencyListCellID @"MCCurrencyListCell"

@interface MCCurrencyListViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)UISearchBar *searchBar;

@property(nonatomic,copy)NSArray *showCurrencies;


@property (weak, nonatomic) IBOutlet GADBannerView *bannerView;

- (void)leftBarButtonClick:(UIBarButtonItem *)sender;
- (void)rightBarButtonClick:(UIBarButtonItem *)sender;

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
    [self loadGoogleAds];
}
-(void)initAllSubViews{
    [self.tableView registerNib:[UINib nibWithNibName:MCCurrencyListCellID bundle:nil] forCellReuseIdentifier:MCCurrencyListCellID];
    self.searchBar=[[UISearchBar alloc]init];
    self.searchBar.barStyle=UIBarStyleBlackTranslucent;
    self.searchBar.delegate=self;
    self.navigationItem.titleView=self.searchBar;
    UIBarButtonItem *lRightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonClick:)];
    self.navigationItem.rightBarButtonItem=lRightBarButtonItem;
}
-(void)initAllData{
    self.showCurrencies=self.showCurrencies=[DataManager manager].allCurrencies;
}
-(void)refreshTableView{
    if ([self.searchBar isFirstResponder]) {
        NSString *lSearchString=[self.searchBar.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if (lSearchString.length==0) {
            self.showCurrencies=[DataManager manager].allCurrencies;
        }else{
            NSString *lPredicateStr=[NSString stringWithFormat:@"self.name LIKE '%@*' or self.unit LIKE '%@*'",[lSearchString uppercaseString],[lSearchString uppercaseString]];
            NSPredicate *lPredicate=[NSPredicate predicateWithFormat:lPredicateStr];
            self.showCurrencies=[[DataManager manager].allCurrencies filteredArrayUsingPredicate:lPredicate];
        }
        
    }else{
        self.showCurrencies=[DataManager manager].allCurrencies;
    }
    [self.tableView reloadData];
}
-(void)loadGoogleAds{
    self.bannerView.adUnitID = @"ca-app-pub-3940256099942544/2934735716";
    self.bannerView.rootViewController = self;
    [self.bannerView loadRequest:[GADRequest request]];
}
#pragma mark - Event Response
- (void)leftBarButtonClick:(UIBarButtonItem *)sender {
}

- (void)rightBarButtonClick:(UIBarButtonItem *)sender {
    if ([self.searchBar isFirstResponder]) {
        self.searchBar.text=@"";
        [self.searchBar resignFirstResponder];
        [self refreshTableView];
    }else{
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }
}
#pragma mark - TableView DataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.showCurrencies.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MCCurrencyListCell *lCell=[tableView dequeueReusableCellWithIdentifier:MCCurrencyListCellID forIndexPath:indexPath];
    NSInteger row=[indexPath row];
    MCCurrency *lCurrency=self.showCurrencies[row];
    [lCell setupCurrency:lCurrency withIsSelected:[[DataManager manager].selectedCurrencies containsObject:lCurrency]];
    return lCell;
}

#pragma mark - TableView Delegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MCCurrencyListCell *lCell=(MCCurrencyListCell *)[tableView cellForRowAtIndexPath:indexPath];
    if (lCell.isSelected) {
        return;
    }
    [DataManager manager].selectedCurrencies=[[DataManager manager].selectedCurrencies arrayByAddingObject:lCell.currency];
    [[DataManager manager]saveSelectedCurrency];
    if ([self.delegate respondsToSelector:@selector(currencyListViewControllerSelectNewCurrency:)]) {
        [self.delegate currencyListViewControllerSelectNewCurrency:self];
    }
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - SearchBar Delegate
-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    return YES;
}
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    
}
-(BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar{
    return YES;
}
-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    
}
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    [self refreshTableView];
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
