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

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *keyBoardViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *keyBoardViewTopConstraint;
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

#pragma mark - Event Response
- (IBAction)tapGestureResponse:(UITapGestureRecognizer *)sender {
    [self dismiss];
}

- (IBAction)zeroButtonClick:(UIButton *)sender {
    [self.calculate inputNumber:@"0"];
}

- (IBAction)oneButtonClick:(UIButton *)sender {
    [self.calculate inputNumber:@"1"];
}

- (IBAction)twoButtonClick:(UIButton *)sender {
    [self.calculate inputNumber:@"2"];
}

- (IBAction)threeButtonClick:(UIButton *)sender {
    [self.calculate inputNumber:@"3"];
}

- (IBAction)fourButtonClick:(UIButton *)sender {
    [self.calculate inputNumber:@"4"];
}

- (IBAction)fiveButtonClick:(UIButton *)sender {
    [self.calculate inputNumber:@"5"];
}

- (IBAction)sixButtonClick:(UIButton *)sender {
    [self.calculate inputNumber:@"6"];
}

- (IBAction)sevenButtonClick:(UIButton *)sender {
    [self.calculate inputNumber:@"7"];
}

- (IBAction)eightButtonClick:(UIButton *)sender {
    [self.calculate inputNumber:@"8"];
}

- (IBAction)nineButtonClick:(UIButton *)sender {
    [self.calculate inputNumber:@"9"];
}

- (IBAction)pointButtonClick:(UIButton *)sender {
    [self.calculate inputPoint];
}

- (IBAction)clearButtonClick:(UIButton *)sender {
    [self.calculate clear];
}

- (IBAction)plusButtonClick:(UIButton *)sender {
    [self.calculate inputOperation:MCCalculateTypePlus];
}

- (IBAction)minusButtonClick:(UIButton *)sender {
    [self.calculate inputOperation:MCCalculateTypeMinus];
}

- (IBAction)multiplyButtonClick:(UIButton *)sender {
    [self.calculate inputOperation:MCCalculateTypeMultiply];
}

- (IBAction)divideButtonClick:(UIButton *)sender {
    [self.calculate inputOperation:MCCalculateTypeDivide];
}

#pragma mark - Public Motheds
-(void)showInView:(UIView *)view{
    self.frame=view.bounds;
    [view addSubview:self];
    [self showNumberKeyBoardWith:YES completion:nil];
}
-(void)dismiss{
    [self hideNumberKeyBoardWith:YES completion:^{
        [self removeFromSuperview];
    }];
}

@end
