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

#define MCExchangeRateCellID @"MCExchangeRateCell"

@interface MCExchangeRateViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MCExchangeRateViewController

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
}
-(void)initAllData{
    
}
#pragma mark - TableView DataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [DataManager manager].selectedExchangeRate.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MCExchangeRateCell *lCell=[tableView dequeueReusableCellWithIdentifier:MCExchangeRateCellID forIndexPath:indexPath];
    return lCell;
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
