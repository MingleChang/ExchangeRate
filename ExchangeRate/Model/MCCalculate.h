//
//  MCCalculate.h
//  KeyBoard
//
//  Created by 常峻玮 on 15/8/4.
//  Copyright (c) 2015年 MingleChang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, MCCalculateType) {
    MCCalculateTypePlus,
    MCCalculateTypeMinus,
    MCCalculateTypeMultiply,
    MCCalculateTypeDivide,
};

@interface MCCalculate : NSObject

@property(nonatomic,assign)MCCalculateType calculateType;
@property(nonatomic,assign)double variable1;
@property(nonatomic,assign,readonly)double variable2;
@property(nonatomic,assign,readonly)double result;
@property(nonatomic,copy)NSString *inputStr;
-(void)inputNumber:(NSString *)numberStr;
-(void)inputPoint;
-(void)inputOperation:(MCCalculateType)operation;
-(void)clear;
@end
