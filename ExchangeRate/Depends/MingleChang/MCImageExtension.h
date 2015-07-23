//
//  UIImage+Extension.h
//  Category_OS
//
//  Created by admin001 on 14/12/2.
//  Copyright (c) 2014年 MingleChang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)
/*
 将image的缩小或者放大到size，不产生虚边和锯齿
 参数：
    size：CGSize，image设置后的尺寸大小
 返回值：UIImage，设置之后得到的UIImage对象
 */
-(UIImage *)resetToSize:(CGSize)size;
/*
 将image的透明度设置为alpha
 参数：
    alpha：CGFloat，image设置的透明度
 返回值：UIImage，设置之后得到的UIImage对象
 */
-(UIImage *)resetToAlpha:(CGFloat)alpha;
/*
 将image进行缩放，宽度缩放比例为scaleW，高度缩放比例为scaleH
 参数：
    scaleW：CGFloat，image宽度缩放比例
    scaleH：CGFloat，image高度缩放比例
 返回值：UIImage，设置之后得到的UIImage对象
 */
-(UIImage *)resetToScaleWidth:(CGFloat)scaleW andScaleHeight:(CGFloat)scaleH;
/*
 将image进行宽度和高度的同比例缩放
 参数：
    scale：CGFloat，image缩放比例
 返回值：UIImage，设置之后得到的UIImage对象
 */
-(UIImage *)resetToScale:(CGFloat)scale;
/*
 将image进行宽度缩放
 参数：
    scaleW：CGFloat，image宽度缩放比例
 返回值：UIImage，设置之后得到的UIImage对象
 */
-(UIImage *)resetToScaleWidth:(CGFloat)scaleW;
/*
 将image进行高度缩放
 参数：
    scaleH：CGFloat，image高度缩放比例
 返回值：UIImage，设置之后得到的UIImage对象
 */
-(UIImage *)resetToScaleHeight:(CGFloat)scaleH;
/*
 为image的纹理区域设置颜色
 参数：
    color：UIColor，为image设置的颜色
 返回值：UIImage，设置之后得到的UIImage对象
 */
-(UIImage *)resetWithColor:(UIColor *)color;
/*
 为image的设置遮罩
 参数：
    mask：UIImage，为image设置的遮罩
 返回值：UIImage，设置之后得到的UIImage对象
*/
-(UIImage*)resetWithMask:(UIImage*)mask;
/*
 将image的纹理设置到区域rect，但image的尺寸不变，其他区域为透明
 参数：
    rect：CGRect，为image纹理设置的新的frame
 返回值：UIImage，设置之后得到的UIImage对象
 */
-(UIImage*)resetToRect:(CGRect)rect;
/*
 将image的纹理偏移，但image的尺寸不变，其他区域为透明
 参数：
    offset：CGPoint，为image纹理设置偏移量
 返回值：UIImage，设置之后得到的UIImage对象
 */
-(UIImage*)resetToOffset:(CGPoint)offset;
/*
 裁剪image，根据裁剪区域rect得到新的图片
 参数：
 rect：CGRect，裁剪区域
 返回值：UIImage，将裁剪区域的纹理返回的UIImage对象
 */
- (UIImage *)clipInRect:(CGRect)rect;

-(UIImage *)grayImage;
@end

@interface UIImage (ImageEffects)//为UIImage添加高斯模糊效果

- (UIImage *)applyLightEffect;
- (UIImage *)applyExtraLightEffect;
- (UIImage *)applyDarkEffect;
- (UIImage *)applyTintEffectWithColor:(UIColor *)tintColor;
- (UIImage *)applyBlurWithRadius:(CGFloat)blurRadius tintColor:(UIColor *)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage *)maskImage;

@end
