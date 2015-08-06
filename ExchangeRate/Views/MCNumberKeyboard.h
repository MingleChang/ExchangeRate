//
//  MCNumberKeyboard.h
//  KeyBoard
//
//  Created by 常峻玮 on 15/8/4.
//  Copyright (c) 2015年 MingleChang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCCalculate.h"
@class MCNumberKeyboard;
@protocol MCNumberKeyboardDelegate <NSObject>
@optional
-(void)numberKeyboardWillShow:(MCNumberKeyboard *)numberKeyboard;
-(void)numberKeyboardDidShow:(MCNumberKeyboard *)numberKeyboard;
-(void)numberKeyboardWillDismiss:(MCNumberKeyboard *)numberKeyboard;
-(void)numberKeyboardDidDismiss:(MCNumberKeyboard *)numberKeyboard;
-(void)numberKeyboardClickNumberButton:(MCNumberKeyboard *)numberKeyboard;
-(void)numberKeyboardClickPointButton:(MCNumberKeyboard *)numberKeyboard;
-(void)numberKeyboardClickOperationButton:(MCNumberKeyboard *)numberKeyboard;
-(void)numberKeyboardClickClearButton:(MCNumberKeyboard *)numberKeyboard;
@end

@interface MCNumberKeyboard : UIView
@property(nonatomic,assign)id<MCNumberKeyboardDelegate> delegate;
@property(nonatomic,strong)MCCalculate *calculate;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *keyBoardViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *keyBoardViewTopConstraint;

-(void)showInView:(UIView *)view;
-(void)dismiss;
@end
