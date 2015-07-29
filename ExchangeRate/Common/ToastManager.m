//
//  ToastManager.m
//  ExchangeRate
//
//  Created by 常峻玮 on 15/7/29.
//  Copyright (c) 2015年 MingleChang. All rights reserved.
//

#import "ToastManager.h"
#import "MBProgressHUD.h"
#import "MingleChang.h"
@implementation ToastManager
+(void)toastText:(NSString *)string{
    UIView *lView=[MCDevice getAppFrontWindow];
    [self toastText:string inView:lView];
}
+(void)toastText:(NSString *)string inView:(UIView *)view{
    CGRect lFrame=view.frame;
    CGPoint offset=CGPointMake(0, lFrame.size.height/2-30);
    [self toastText:string inView:view withOffset:offset];
}
+(void)toastText:(NSString *)string inView:(UIView *)view withOffset:(CGPoint)offset{
    MBProgressHUD *lProgess=[MBProgressHUD showHUDAddedTo:view animated:YES];
    lProgess.mode=MBProgressHUDModeText;
    lProgess.labelText=string;
    lProgess.margin=5;
    lProgess.xOffset=offset.x;
    lProgess.yOffset=offset.y;
    lProgess.userInteractionEnabled=NO;
    lProgess.removeFromSuperViewOnHide=YES;
    [lProgess hide:YES afterDelay:1.0];
}
@end
