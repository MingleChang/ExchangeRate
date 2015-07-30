//
//  MCPanCell.h
//  CellTest
//
//  Created by 常峻玮 on 15/7/27.
//  Copyright (c) 2015年 MingleChang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, PanCellStatus) {
    PanCellStatusNormal,
    PanCellStatusLeft,
    PanCellStatusRight,
};

@interface MCPanCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIView *forwardView;
@property(nonatomic,assign)PanCellStatus status;
@property(nonatomic,assign)CGFloat leftDistance;
@property(nonatomic,assign)CGFloat rightDistance;

-(void)showStatus:(PanCellStatus)status with:(BOOL)animation;
-(void)showLeftWith:(BOOL)animation;
-(void)showRightWith:(BOOL)animation;
-(void)showNormalWith:(BOOL)animation;

@end
