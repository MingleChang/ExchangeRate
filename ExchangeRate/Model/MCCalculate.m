//
//  MCCalculate.m
//  KeyBoard
//
//  Created by 常峻玮 on 15/8/4.
//  Copyright (c) 2015年 MingleChang. All rights reserved.
//

#import "MCCalculate.h"

@implementation MCCalculate
-(void)inputNumber:(NSString *)numberStr{
    if (self.variable2>=999999999) {
        return;
    }
    if ([self.inputStr containsString:@"."]) {
        NSRange lRange=[self.inputStr rangeOfString:@"."];
        NSInteger lLocation=lRange.location;
        NSInteger lStrLen=self.inputStr.length;
        if (lLocation<=(lStrLen-3)) {
            
        }else{
            self.inputStr=[self.inputStr stringByAppendingString:numberStr];
        }
        return;
    }
    if ([numberStr isEqualToString:@"0"]&&self.variable2<=0) {
        return;
    }
    self.inputStr=[self.inputStr stringByAppendingString:numberStr];
}
-(void)inputPoint{
    if ([self.inputStr containsString:@"."]) {
        return;
    }
    self.inputStr=[self.inputStr stringByAppendingString:@"."];
}
-(void)inputOperation:(MCCalculateType)operation{
    self.variable1=self.result;
    self.inputStr=@"";
    self.calculateType=operation;
}
-(void)clear{
    self.calculateType=MCCalculateTypePlus;
    self.variable1=0;
    self.inputStr=@"";
}
-(double)calculate{
    switch (self.calculateType) {
        case MCCalculateTypePlus:
            return self.variable1+self.variable2;
            break;
        case MCCalculateTypeMinus:
            return self.variable1-self.variable2;
            break;
        case MCCalculateTypeMultiply:
            return self.variable1*self.variable2;
            break;
        case MCCalculateTypeDivide:
            if (self.variable2==0) {
                return 0.0;
            }
            return self.variable1/self.variable2;
            break;
        default:
            return 0.0;
            break;
    }
}
#pragma mark - Setter And Getter
-(NSString *)inputStr{
    if (_inputStr) {
        return _inputStr;
    }
    _inputStr=@"";
    return _inputStr;
}
-(double)variable2{
    return [self.inputStr doubleValue];
}
-(double)result{
    if (self.variable1==0) {
        return self.variable2;
    }
    if (self.variable2==0) {
        return self.variable1;
    }
    return [self calculate];
}

//-(void)test{
//    NSLog(@"%f  %f  %f  %@",self.variable1,self.variable2,self.result,self.inputStr);
//}
@end
