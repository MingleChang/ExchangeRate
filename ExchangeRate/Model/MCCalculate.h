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
@property(nonatomic,copy)NSString *variableStr1;
@property(nonatomic,assign)double variable2;
@property(nonatomic,copy)NSString *variableStr2;
@property(nonatomic,assign)double result;

@end
