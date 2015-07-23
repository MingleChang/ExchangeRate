//
//  DrawImage.m
//  Category_OS
//
//  Created by admin001 on 14/12/1.
//  Copyright (c) 2014年 MingleChang. All rights reserved.
//

#import "MCDrawImage.h"

@implementation MCDrawImage

+(UIImage *)drawImageSize:(CGSize)size withColor:(UIColor *)color{
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, CGRectMake(0, 0, size.width, size.height));
    UIImage *lResultImage=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndPDFContext();
    return lResultImage;
}

+(UIImage *)drawImageWithView:(UIView *)view{
    UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, 0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *lResultImage=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndPDFContext();
    return lResultImage;
}

@end
