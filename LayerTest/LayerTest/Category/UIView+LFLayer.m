//
//  UIView+LFLayer.m
//  LayerTest
//
//  Created by Lonelyflow on 19/04/2019.
//  Copyright © 2019 Lonely traveller. All rights reserved.
//

#import "UIView+LFLayer.h"
#import <objc/runtime.h>

@interface UIView ()
@property(nonatomic, assign) BOOL needUpdateRadius;
@property(nonatomic, strong) CAShapeLayer *maskLayer;
@property(nonatomic, strong) CAShapeLayer *borderLayer;
@property(nonatomic, assign) CGRect oldBounds;
@end
@implementation UIView (LFLayer)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        // 变化方法实现
        [self lf_swizzleMethod:[self class] orgSel:@selector(layoutSubviews) swizzSel:@selector(lf_layoutSubviews)];
    });
}
+ (void)lf_swizzleMethod:(Class)class orgSel:(SEL)originalSelector swizzSel:(SEL)swizzledSelector {
    
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    IMP swizzledImp = method_getImplementation(swizzledMethod);
    char *swizzledTypes = (char *)method_getTypeEncoding(swizzledMethod);
    
    IMP originalImp = method_getImplementation(originalMethod);
    char *originalTypes = (char *)method_getTypeEncoding(originalMethod);
    
    BOOL success = class_addMethod(class, originalSelector, swizzledImp, swizzledTypes);
    if (success) {
        class_replaceMethod(class, swizzledSelector, originalImp, originalTypes);
    }else {
        // 添加失败，表明已经有这个方法，直接交换
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}
#pragma mark - 
- (void)lf_layoutSubviews
{
    // 调用本身的实现
    [self lf_layoutSubviews];
    BOOL isFrameChange = NO;;
    if(!CGRectEqualToRect(self.oldBounds, self.bounds)){
        isFrameChange = YES;
        self.oldBounds = self.bounds;
    }
    UIBezierPath *maskPath = [UIBezierPath  bezierPathWithRoundedRect:self.bounds byRoundingCorners:(UIRectCorner)self.lf_clipType cornerRadii:CGSizeMake(self.lf_clipRadius, self.lf_clipRadius)];
    if(self.needUpdateRadius || isFrameChange){
        self.needUpdateRadius = NO;
        if (self.lf_clipType == CornerClipTypeNone || self.lf_clipRadius <= 0) {
            // 以前使用了maskLayer，去掉
            if(self.layer.mask == self.maskLayer){
                self.layer.mask = nil;
            }
            self.maskLayer = nil;
        } else {
            if (self.layer.mask == nil) {
                self.maskLayer = [[CAShapeLayer alloc] init];
            }
            
            self.maskLayer.frame = self.bounds;
            self.maskLayer.path = maskPath.CGPath;
            self.layer.mask = self.maskLayer;
            
        }
    }
    
    if(self.lf_borderWidth <= 0 || self.lf_borderColor == nil){
        if(self.borderLayer){
            [self.borderLayer removeFromSuperlayer];
        }
        self.borderLayer = nil;
    }else{
        if(self.borderLayer == nil){
            self.borderLayer = [CAShapeLayer layer];
            self.borderLayer.lineWidth = self.lf_borderWidth;
            self.borderLayer.fillColor = [UIColor clearColor].CGColor;
            self.borderLayer.strokeColor = self.lf_borderColor.CGColor;
            self.borderLayer.frame = self.bounds;
            self.borderLayer.path = maskPath.CGPath;
            
            [self.layer addSublayer:self.borderLayer];
        }
        
    }
    
}
/**
 便捷添加圆角
 
 @param clipType 圆角类型
 @param radius 圆角角度
 */
- (void)clipWithType:(CornerClipType)clipType radius:(CGFloat)radius
{
    self.lf_clipType = clipType;
    self.lf_clipRadius = radius;
}
/**
 便捷给添加border
 
 @param color 边框的颜色
 @param borderWidth 边框的宽度
 */
- (void)addBorderWithColor:(UIColor *)color borderWidth:(CGFloat)borderWidth
{
    self.lf_borderColor = color;
    self.lf_borderWidth = borderWidth;
}
#pragma mark - getter && setter
#pragma mark - radisu
- (void)setLf_clipType:(CornerClipType)lf_clipType
{
    if(self.lf_clipType == lf_clipType){
        // 数值相同不需要修改
        return;
    }
    // 以get方法名为key
    objc_setAssociatedObject(self, @selector(lf_clipType), @(lf_clipType), OBJC_ASSOCIATION_RETAIN);
    self.needUpdateRadius = YES;
}
- (CornerClipType)lf_clipType
{
    // 以get方面为key
    return [objc_getAssociatedObject(self, _cmd) unsignedIntegerValue];
}
- (void)setLf_clipRadius:(CGFloat)lf_clipRadius
{
    if(self.lf_clipRadius == lf_clipRadius){
        // 数值相同，不需要修改内如
        return;
    }
    // 以get方法名为key
    objc_setAssociatedObject(self, @selector(lf_clipRadius), @(lf_clipRadius), OBJC_ASSOCIATION_RETAIN);
    self.needUpdateRadius = YES;
}
- (CGFloat)lf_clipRadius
{
    // 以get方面为key
    return [objc_getAssociatedObject(self, _cmd) floatValue];
}
#pragma mark - border
- (void)setLf_borderColor:(UIColor *)lf_borderColor
{
    if(self.lf_borderColor == lf_borderColor){
        // 数值相同不需要修改
        return;
    }
    objc_setAssociatedObject(self, @selector(lf_borderColor), lf_borderColor, OBJC_ASSOCIATION_RETAIN);
    //self.needUpdateRadius = YES;
}
- (UIColor *)lf_borderColor
{
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setLf_borderWidth:(CGFloat)lf_borderWidth
{
    if(self.lf_borderWidth == lf_borderWidth){
        // 数值相同不需要修改
        return;
    }
    // 以get方法名为key
    objc_setAssociatedObject(self, @selector(lf_borderWidth), @(lf_borderWidth), OBJC_ASSOCIATION_RETAIN);
    //self.needUpdateRadius = YES;
}
- (CGFloat)lf_borderWidth
{
    // 以get方面为key
    return [objc_getAssociatedObject(self, _cmd) floatValue];
}
- (void)setBorderLayer:(CAShapeLayer *)borderLayer
{
    objc_setAssociatedObject(self, @selector(borderLayer), borderLayer, OBJC_ASSOCIATION_RETAIN);
}
- (CAShapeLayer *)borderLayer
{
    return objc_getAssociatedObject(self, _cmd);
}

#pragma mark -
- (BOOL)needUpdateRadius
{
    // 以get方面为key
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}
- (void)setNeedUpdateRadius:(BOOL)needUpdateRadius
{
    // 以get方法名为key
    objc_setAssociatedObject(self, @selector(needUpdateRadius), @(needUpdateRadius), OBJC_ASSOCIATION_RETAIN);
}
- (void)setOldBounds:(CGRect)oldBounds
{
    // 以get方法名为key
    objc_setAssociatedObject(self, @selector(oldBounds), [NSValue valueWithCGRect:oldBounds], OBJC_ASSOCIATION_RETAIN);
}
- (CGRect)oldBounds
{
    // 以get方面为key
    return [objc_getAssociatedObject(self, _cmd) CGRectValue];
}
- (void)setMaskLayer:(CAShapeLayer *)maskLayer
{
    objc_setAssociatedObject(self, @selector(maskLayer), maskLayer, OBJC_ASSOCIATION_RETAIN);
}
- (CAShapeLayer *)maskLayer
{
    return objc_getAssociatedObject(self, _cmd);
}

@end
