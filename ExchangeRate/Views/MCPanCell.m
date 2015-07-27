//
//  MCPanCell.m
//  CellTest
//
//  Created by 常峻玮 on 15/7/27.
//  Copyright (c) 2015年 MingleChang. All rights reserved.
//

#import "MCPanCell.h"

@interface MCPanCell()

@property(nonatomic,assign)CGAffineTransform forwardBeginTransform;

- (void)panGestureResponse:(UIPanGestureRecognizer *)sender;

@end
@implementation MCPanCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    
    self.leftDistance=10;
    self.rightDistance=100;
    
    UIPanGestureRecognizer *lPan=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGestureResponse:)];
    [self.contentView addGestureRecognizer:lPan];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

#pragma mark - PanGesture
- (void)panGestureResponse:(UIPanGestureRecognizer *)sender {
    switch (sender.state) {
        case UIGestureRecognizerStateBegan:{
            [self panGestureResponseBegin];
        }break;
        case UIGestureRecognizerStateChanged:{
            CGPoint translation = [sender translationInView:self.contentView];
            [self panGestureResponseChangeWithTranslation:translation];
        }break;
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:{
            CGPoint velocity = [sender velocityInView:self];
            [self panGestureResponseEndWithVelocity:velocity];
        }break;
        default:
            break;
    }
}
-(void)panGestureResponseBegin{
    self.forwardBeginTransform=self.forwardView.transform;
}
-(void)panGestureResponseChangeWithTranslation:(CGPoint )translation{
    self.forwardView.transform=CGAffineTransformTranslate(self.forwardBeginTransform, translation.x, 0);
    if (self.forwardView.transform.tx>self.leftDistance) {
        self.forwardView.transform=CGAffineTransformMakeTranslation(self.leftDistance, 0);
    }
    if (self.forwardView.transform.tx<-self.rightDistance) {
        self.forwardView.transform=CGAffineTransformMakeTranslation(-self.rightDistance, 0);
    }
}
-(void)panGestureResponseEndWithVelocity:(CGPoint )velocity{
    PanCellStatus lStatus=PanCellStatusNormal;
    if (self.forwardView.transform.tx>self.leftDistance/2) {
        lStatus=PanCellStatusLeft;
    }else if (self.forwardView.transform.tx<-self.rightDistance/2){
        lStatus=PanCellStatusRight;
    }
    [UIView animateWithDuration:0.2 animations:^{
        switch (lStatus) {
            case PanCellStatusNormal:
                self.forwardView.transform=CGAffineTransformIdentity;
                break;
            case PanCellStatusLeft:
                self.forwardView.transform=CGAffineTransformMakeTranslation(self.leftDistance, 0);
                break;
            case PanCellStatusRight:
                self.forwardView.transform=CGAffineTransformMakeTranslation(-self.rightDistance, 0);
                break;
            default:
                break;
        }
    } completion:^(BOOL finished) {
        self.status=lStatus;
    }];
}
@end
