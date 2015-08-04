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
#import "MCExchangeRate.h"
#import "MCCurrencyListNavigationController.h"
#import "MCCurrencyListViewController.h"

#define MCExchangeRateCellID @"MCExchangeRateCell"
#define MCCurrencyListNavigationControllerID @"MCCurrencyListNavigationController"
#define MCCurrencyListViewControllerID @"MCCurrencyListViewController"

@interface MCExchangeRateViewController ()<UITableViewDataSource,UITableViewDelegate,MCCurrencyListViewControllerDelegate,MCExchangeRateCellDelegate,MCPanCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@property(nonatomic,weak)MCExchangeRateCell *lastPanCell;

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
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGestureRecognized:)];
    [self.tableView addGestureRecognizer:longPress];
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
    lCell.panDelegate=self;
    [lCell updateUI];
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
    [[DataManager manager].selectedExchangeRate removeObjectAtIndex:lIndexPath.row];
    [[DataManager manager]saveSelectedCurrency];
    [self.tableView beginUpdates];
    [self.tableView deleteRowsAtIndexPaths:@[lIndexPath] withRowAnimation:UITableViewRowAnimationLeft];
    [self.tableView endUpdates];
}
#pragma mark - PanCell Delegate
-(void)panCellBeginGesture:(MCPanCell *)cell{
    if (![self.lastPanCell isEqual:cell]&&self.lastPanCell.status!=PanCellStatusNormal) {
        [self.lastPanCell showNormalWith:YES];
    }
}
-(void)panCellEndGesture:(MCPanCell *)cell{
    self.lastPanCell=(MCExchangeRateCell *)cell;
}

#pragma mark - Long Press Sort Cell
- (void)longPressGestureRecognized:(id)sender {
    
    UILongPressGestureRecognizer *longPress = (UILongPressGestureRecognizer *)sender;
    UIGestureRecognizerState state = longPress.state;
    
    CGPoint location = [longPress locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:location];
    
    static UIView       *snapshot = nil;        ///< A snapshot of the row user is moving.
    static NSIndexPath  *sourceIndexPath = nil; ///< Initial index path, where gesture begins.
    
    switch (state) {
        case UIGestureRecognizerStateBegan: {
            if (indexPath) {
                sourceIndexPath = indexPath;
                
                UITableViewCell *lCell = [self.tableView cellForRowAtIndexPath:indexPath];
                
                // Take a snapshot of the selected row using helper method.
                snapshot = [self customSnapshoFromView:lCell];
                
                // Add the snapshot as subview, centered at cell's center...
                __block CGPoint center = lCell.center;
                snapshot.center = center;
                snapshot.alpha = 0.0;
                [self.tableView addSubview:snapshot];
                [UIView animateWithDuration:0.25 animations:^{
                    // Offset for gesture location.
                    center.y = location.y;
                    snapshot.center = center;
                    snapshot.transform = CGAffineTransformMakeScale(1.05, 1.05);
                    snapshot.alpha = 0.98;
                    lCell.alpha = 0.0;
                    
                } completion:^(BOOL finished) {
                    lCell.hidden = YES;
                    
                }];
            }
            break;
        }
            
        case UIGestureRecognizerStateChanged: {
            CGPoint center = snapshot.center;
            center.y = location.y;
            snapshot.center = center;
            
            // Is destination valid and is it different from source?
            if (indexPath && ![indexPath isEqual:sourceIndexPath]) {
                
                // ... update data source.
                [[DataManager manager].selectedExchangeRate exchangeObjectAtIndex:indexPath.row withObjectAtIndex:sourceIndexPath.row];
                
                // ... move the rows.
                [self.tableView moveRowAtIndexPath:sourceIndexPath toIndexPath:indexPath];
                
                // ... and update source so it is in sync with UI changes.
                sourceIndexPath = indexPath;
            }
            break;
        }
            
        default: {
            // Clean up.
            UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:sourceIndexPath];
            cell.hidden = NO;
            cell.alpha = 0.0;
            
            [UIView animateWithDuration:0.25 animations:^{
                snapshot.center = cell.center;
                snapshot.transform = CGAffineTransformIdentity;
                snapshot.alpha = 0.0;
                cell.alpha = 1.0;
                
            } completion:^(BOOL finished) {
                
                sourceIndexPath = nil;
                [snapshot removeFromSuperview];
                snapshot = nil;
                
            }];
            
            break;
        }
    }
}

#pragma mark - Helper methods

/** @brief Returns a customized snapshot of a given view. */
- (UIView *)customSnapshoFromView:(UIView *)inputView {
    
    // Make an image from the input view.
    UIGraphicsBeginImageContextWithOptions(inputView.bounds.size, NO, 0);
    [inputView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // Create an image view.
    UIView *snapshot = [[UIImageView alloc] initWithImage:image];
    snapshot.layer.masksToBounds = NO;
    snapshot.layer.cornerRadius = 0.0;
    snapshot.layer.shadowOffset = CGSizeMake(-5.0, 0.0);
    snapshot.layer.shadowRadius = 5.0;
    snapshot.layer.shadowOpacity = 0.4;
    
    return snapshot;
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
