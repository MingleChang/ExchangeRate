//
//  DrawImage.h
//  Category_OS
//
//  Created by admin001 on 14/12/1.
//  Copyright (c) 2014年 MingleChang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface MCDrawImage : NSObject

/*
 绘制一张纯色的UIImage
 参数：
    size：CGSize，要绘制的Image的尺寸，尺寸请按照低分辨率的尺寸计算
    color：UIColor，绘制的Image的填充色
 返回值：UIImage，绘制后得到的Image
 */
+(UIImage *)drawImageSize:(CGSize)size withColor:(UIColor *)color;

/*
 将View上的纹理生成一张UIImage,或者说将View转换为Image
 参数：
    view：UIView，用于生成Image的View
 返回值：UIImage，绘制后得到的Image
 */
+(UIImage *)drawImageWithView:(UIView *)view;

@end
