//
//  MCNumberKeyboard.m
//  KeyBoard
//
//  Created by 常峻玮 on 15/8/4.
//  Copyright (c) 2015年 MingleChang. All rights reserved.
//

#import "MCNumberKeyboard.h"
@interface MCNumberKeyboard()

@property (weak, nonatomic) IBOutlet UIButton *zeroButton;
@property (weak, nonatomic) IBOutlet UIButton *oneButton;
@property (weak, nonatomic) IBOutlet UIButton *twoButton;
@property (weak, nonatomic) IBOutlet UIButton *threeButton;
@property (weak, nonatomic) IBOutlet UIButton *fourButton;
@property (weak, nonatomic) IBOutlet UIButton *fiveButton;
@property (weak, nonatomic) IBOutlet UIButton *sixButton;
@property (weak, nonatomic) IBOutlet UIButton *sevenButton;
@property (weak, nonatomic) IBOutlet UIButton *eightButton;
@property (weak, nonatomic) IBOutlet UIButton *nineButton;
@property (weak, nonatomic) IBOutlet UIButton *pointButton;
@property (weak, nonatomic) IBOutlet UIButton *clearButton;
@property (weak, nonatomic) IBOutlet UIButton *plusButton;
@property (weak, nonatomic) IBOutlet UIButton *minusButton;
@property (weak, nonatomic) IBOutlet UIButton *multiplyButton;
@property (weak, nonatomic) IBOutlet UIButton *divideButton;


@property (weak, nonatomic) IBOutlet UIView *keyBoardView;

@property (weak, nonatomic) IBOutlet UIView *verticalLineView1;
@property (weak, nonatomic) IBOutlet UIView *verticalLineView2;
@property (weak, nonatomic) IBOutlet UIView *verticalLineView3;

@property (weak, nonatomic) IBOutlet UIView *horizontalLineView1;
@property (weak, nonatomic) IBOutlet UIView *horizontalLineView2;
@property (weak, nonatomic) IBOutlet UIView *horizontalLineView3;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *verticalLineViewWidthConstraint1;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *verticalLineViewWidthConstraint2;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *verticalLineViewWidthConstraint3;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *horizontalLineViewHeightConstraint1;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *horizontalLineViewHeightConstraint2;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *horizontalLineViewHeightConstraint3;

- (IBAction)tapGestureResponse:(UITapGestureRecognizer *)sender;
- (IBAction)zeroButtonClick:(UIButton *)sender;
- (IBAction)oneButtonClick:(UIButton *)sender;
- (IBAction)twoButtonClick:(UIButton *)sender;
- (IBAction)threeButtonClick:(UIButton *)sender;
- (IBAction)fourButtonClick:(UIButton *)sender;
- (IBAction)fiveButtonClick:(UIButton *)sender;
- (IBAction)sixButtonClick:(UIButton *)sender;
- (IBAction)sevenButtonClick:(UIButton *)sender;
- (IBAction)eightButtonClick:(UIButton *)sender;
- (IBAction)nineButtonClick:(UIButton *)sender;
- (IBAction)pointButtonClick:(UIButton *)sender;
- (IBAction)clearButtonClick:(UIButton *)sender;
- (IBAction)plusButtonClick:(UIButton *)sender;
- (IBAction)minusButtonClick:(UIButton *)sender;
- (IBAction)multiplyButtonClick:(UIButton *)sender;
- (IBAction)divideButtonClick:(UIButton *)sender;

@end
@implementation MCNumberKeyboard

-(void)awakeFromNib{
    [super awakeFromNib];
    [self initAllSubViewAndData];
}

#pragma mark - Private Motheds
-(void)initAllSubViewAndData{
    [self initAllSubView];
    [self initAllData];
}
-(void)initAllSubView{
    CGFloat onePixel=1/[UIScreen mainScreen].scale;
    self.keyBoardViewHeightConstraint.constant=[UIScreen mainScreen].bounds.size.width/3*2;
    self.keyBoardViewTopConstraint.constant=0;
    self.verticalLineViewWidthConstraint1.constant=onePixel;
    self.verticalLineViewWidthConstraint2.constant=onePixel;
    self.verticalLineViewWidthConstraint3.constant=onePixel;
    self.horizontalLineViewHeightConstraint1.constant=onePixel;
    self.horizontalLineViewHeightConstraint2.constant=onePixel;
    self.horizontalLineViewHeightConstraint3.constant=onePixel;
    [self layoutIfNeeded];
}
-(void)initAllData{
    self.calculate=[[MCCalculate alloc]init];
}

-(void)showNumberKeyBoardWith:(BOOL)animation completion:(void (^)())completion{
    if (animation) {
        [self layoutIfNeeded];
        [UIView animateWithDuration:0.2 animations:^{
            self.keyBoardViewTopConstraint.constant=-self.keyBoardViewHeightConstraint.constant;
            [self layoutIfNeeded];
        } completion:^(BOOL finished) {
            if (completion) {
                completion();
            };
        }];
    }else{
        self.keyBoardViewTopConstraint.constant=-self.keyBoardViewHeightConstraint.constant;
        [self layoutIfNeeded];
        completion();
    }
}
-(void)hideNumberKeyBoardWith:(BOOL)animation completion:(void (^)())completion{
    if (animation) {
        [UIView animateWithDuration:0.2 animations:^{
            self.keyBoardViewTopConstraint.constant=0;
            [self layoutIfNeeded];
        } completion:^(BOOL finished) {
            if (completion) {
                completion();
            };
        }];
    }else{
        self.keyBoardViewTopConstraint.constant=0;
        [self layoutIfNeeded];
        completion();
    }
}
#pragma mark - Response Delegate
-(void)responseWillShowDelegate{
    if ([self.delegate respondsToSelector:@selector(numberKeyboardWillShow:)]) {
        [self.delegate numberKeyboardWillShow:self];
    }
}
-(void)responseDidShowDelegate{
    if ([self.delegate respondsToSelector:@selector(numberKeyboardDidShow:)]) {
        [self.delegate numberKeyboardDidShow:self];
    }
}
-(void)responseWillDismissDelegate{
    if ([self.delegate respondsToSelector:@selector(numberKeyboardWillDismiss:)]) {
        [self.delegate numberKeyboardWillDismiss:self];
    }
}
-(void)responseDidDismissDelegate{
    if ([self.delegate respondsToSelector:@selector(numberKeyboardDidDismiss:)]) {
        [self.delegate numberKeyboardDidDismiss:self];
    }
}
-(void)responseClickNumberButtonDelegate{
    if ([self.delegate respondsToSelector:@selector(numberKeyboardClickNumberButton:)]) {
        [self.delegate numberKeyboardClickNumberButton:self];
    }
}
-(void)responseClickPointDelegate{
    if ([self.delegate respondsToSelector:@selector(numberKeyboardClickPointButton:)]) {
        [self.delegate numberKeyboardClickPointButton:self];
    }
}
-(void)responseClickOperationDelegate{
    if ([self.delegate respondsToSelector:@selector(numberKeyboardClickOperationButton:)]) {
        [self.delegate numberKeyboardClickOperationButton:self];
    }
}
-(void)responseClickClearDelegate{
    if ([self.delegate respondsToSelector:@selector(numberKeyboardClickClearButton:)]) {
        [self.delegate numberKeyboardClickClearButton:self];
    }
}
#pragma mark - Event Response
- (IBAction)tapGestureResponse:(UITapGestureRecognizer *)sender {
    [self dismiss];
}

- (IBAction)zeroButtonClick:(UIButton *)sender {
    [self.calculate inputNumber:@"0"];
    [self responseClickNumberButtonDelegate];
}

- (IBAction)oneButtonClick:(UIButton *)sender {
    [self.calculate inputNumber:@"1"];
    [self responseClickNumberButtonDelegate];
}

- (IBAction)twoButtonClick:(UIButton *)sender {
    [self.calculate inputNumber:@"2"];
    [self responseClickNumberButtonDelegate];
}

- (IBAction)threeButtonClick:(UIButton *)sender {
    [self.calculate inputNumber:@"3"];
    [self responseClickNumberButtonDelegate];
}

- (IBAction)fourButtonClick:(UIButton *)sender {
    [self.calculate inputNumber:@"4"];
    [self responseClickNumberButtonDelegate];
}

- (IBAction)fiveButtonClick:(UIButton *)sender {
    [self.calculate inputNumber:@"5"];
    [self responseClickNumberButtonDelegate];
}

- (IBAction)sixButtonClick:(UIButton *)sender {
    [self.calculate inputNumber:@"6"];
    [self responseClickNumberButtonDelegate];
}

- (IBAction)sevenButtonClick:(UIButton *)sender {
    [self.calculate inputNumber:@"7"];
    [self responseClickNumberButtonDelegate];
}

- (IBAction)eightButtonClick:(UIButton *)sender {
    [self.calculate inputNumber:@"8"];
    [self responseClickNumberButtonDelegate];
}

- (IBAction)nineButtonClick:(UIButton *)sender {
    [self.calculate inputNumber:@"9"];
    [self responseClickNumberButtonDelegate];
}

- (IBAction)pointButtonClick:(UIButton *)sender {
    [self.calculate inputPoint];
    [self responseClickPointDelegate];
}

- (IBAction)clearButtonClick:(UIButton *)sender {
    [self.calculate clear];
    [self responseClickClearDelegate];
}

- (IBAction)plusButtonClick:(UIButton *)sender {
    [self.calculate inputOperation:MCCalculateTypePlus];
    [self responseClickOperationDelegate];
}

- (IBAction)minusButtonClick:(UIButton *)sender {
    [self.calculate inputOperation:MCCalculateTypeMinus];
    [self responseClickOperationDelegate];
}

- (IBAction)multiplyButtonClick:(UIButton *)sender {
    [self.calculate inputOperation:MCCalculateTypeMultiply];
    [self responseClickOperationDelegate];
}

- (IBAction)divideButtonClick:(UIButton *)sender {
    [self.calculate inputOperation:MCCalculateTypeDivide];
    [self responseClickOperationDelegate];
}

#pragma mark - Public Motheds
-(void)showInView:(UIView *)view{
    self.frame=view.bounds;
    [view addSubview:self];
    [self responseWillShowDelegate];
    [self showNumberKeyBoardWith:YES completion:^{
        [self responseDidShowDelegate];
    }];
}
-(void)dismiss{
    [self responseWillDismissDelegate];
    [self hideNumberKeyBoardWith:YES completion:^{
        [self responseDidDismissDelegate];
        [self removeFromSuperview];
    }];
}

@end
