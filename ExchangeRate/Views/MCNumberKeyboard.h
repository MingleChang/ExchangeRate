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

-(void)numberKeyboardWillShow:(MCNumberKeyboard *)numberKeyboard;
-(void)numberKeyboardDidShow:(MCNumberKeyboard *)numberKeyboard;
-(void)numberKeyboardWillDismiss:(MCNumberKeyboard *)numberKeyboard;
-(void)numberKeyboardDidDismiss:(MCNumberKeyboard *)numberKeyboard;

@end

@interface MCNumberKeyboard : UIView
@property(nonatomic,strong)MCCalculate *calculate;
-(void)showInView:(UIView *)view;
-(void)dismiss;
@end
