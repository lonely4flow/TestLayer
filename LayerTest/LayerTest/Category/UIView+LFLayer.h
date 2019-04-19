//
//  UIView+LFLayer.h
//  LayerTest
//
//  Created by Lonelyflow on 19/04/2019.
//  Copyright © 2019 Lonely traveller. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS (NSUInteger, CornerClipType) {
    CornerClipTypeNone = 0,  // 不切
    CornerClipTypeTopLeft     = UIRectCornerTopLeft, // 左上角
    CornerClipTypeTopRight    = UIRectCornerTopRight, // 右上角
    CornerClipTypeBottomLeft  = UIRectCornerBottomLeft, // 左下角
    CornerClipTypeBottomRight = UIRectCornerBottomRight, // 右下角
    CornerClipTypeAll  = UIRectCornerAllCorners,// 全部四个角
    // 上面2个角
    CornerClipTypeBothTop  = CornerClipTypeTopLeft | CornerClipTypeTopRight,
    // 下面2个角
    CornerClipTypeBothBottom  = CornerClipTypeBottomLeft | CornerClipTypeBottomRight,
    // 左侧2个角
    CornerClipTypeBothLeft  = CornerClipTypeTopLeft | CornerClipTypeBottomLeft,
    // 右面2个角
    CornerClipTypeBothRight  = CornerClipTypeTopRight | CornerClipTypeBottomRight
};

@interface UIView (LFLayer)
// 圆角
@property(nonatomic, assign) CGFloat lf_clipRadius;
@property(nonatomic, assign) CornerClipType lf_clipType;

// border
@property(nonatomic, assign) CGFloat lf_borderWidth;
@property(nonatomic, strong) UIColor *lf_borderColor;

/**
 便捷添加圆角

 @param clipType 圆角类型
 @param radius 圆角角度
 */
- (void)clipWithType:(CornerClipType)clipType radius:(CGFloat)radius;

/**
 便捷给添加border

 @param color 边框的颜色
 @param borderWidth 边框的宽度
 */
- (void)addBorderWithColor:(UIColor *)color borderWidth:(CGFloat)borderWidth;
@end

