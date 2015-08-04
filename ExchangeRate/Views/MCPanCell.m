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
-(void)panGestureResponseBegin;
-(void)panGestureResponseChangeWithTranslation:(CGPoint )translation;
-(void)panGestureResponseEndWithVelocity:(CGPoint )velocity;
-(void)panGestureResponse:(UIPanGestureRecognizer *)sender;

@end
@implementation MCPanCell

-(void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    
    UIPanGestureRecognizer *lPan=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGestureResponse:)];
    lPan.delegate=self;
    [self.contentView addGestureRecognizer:lPan];
}

-(void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

#pragma mark - Private Motheds
#pragma mark - PanGesture
-(void)panGestureResponseBegin{
    if ([self.panDelegate respondsToSelector:@selector(panCellBeginGesture:)]) {
        [self.panDelegate panCellBeginGesture:self];
    }
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
    if ([self.panDelegate respondsToSelector:@selector(panCellEndGesture:)]) {
        [self.panDelegate panCellEndGesture:self];
    }
}

#pragma mark - PanGesture Response
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

#pragma mark - Public Motheds
-(void)showStatus:(PanCellStatus)status with:(BOOL)animation{
    switch (status) {
        case PanCellStatusLeft:
            [self showLeftWith:animation];
            break;
        case PanCellStatusRight:
            [self showRightWith:animation];
            break;
        case PanCellStatusNormal:
            [self showNormalWith:animation];
            break;
        default:
            break;
    }
}
-(void)showLeftWith:(BOOL)animation{
    if (animation) {
        [UIView animateWithDuration:0.2 animations:^{
            self.forwardView.transform=CGAffineTransformMakeTranslation(self.leftDistance, 0);
        } completion:^(BOOL finished) {
            self.status=PanCellStatusLeft;
        }];
    }else{
        self.forwardView.transform=CGAffineTransformMakeTranslation(self.leftDistance, 0);
        self.status=PanCellStatusLeft;
    }
}
-(void)showRightWith:(BOOL)animation{
    if (animation) {
        [UIView animateWithDuration:0.2 animations:^{
            self.forwardView.transform=CGAffineTransformMakeTranslation(self.rightDistance, 0);
        } completion:^(BOOL finished) {
            self.status=PanCellStatusRight;
        }];
    }else{
        self.forwardView.transform=CGAffineTransformMakeTranslation(self.rightDistance, 0);
        self.status=PanCellStatusRight;
    }
}
-(void)showNormalWith:(BOOL)animation{
    if (animation) {
        [UIView animateWithDuration:0.2 animations:^{
            self.forwardView.transform=CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            self.status=PanCellStatusNormal;
        }];
    }else{
        self.forwardView.transform=CGAffineTransformIdentity;
        self.status=PanCellStatusNormal;
    }
}

#pragma mark UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        CGPoint translation = [(UIPanGestureRecognizer *)gestureRecognizer translationInView:self];
        return ((fabs(translation.x) / fabs(translation.y) > 1) ? YES : NO);
    }
    return NO;
}
@end
