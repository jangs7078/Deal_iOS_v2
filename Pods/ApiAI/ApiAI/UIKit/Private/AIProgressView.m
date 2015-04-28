//
//  AIProgressView.m
//  MicButtonProject
//
//  Created by Kuragin Dmitriy on 21/11/14.
//  Copyright (c) 2014 Kuragin Dmitriy. All rights reserved.
//

#import "AIProgressView.h"

NSString *const kAIProgressAnimationKey = @"AIProgressAnimationKey";

@interface AIProgressLayer : CALayer

@property(nonatomic, assign) CGFloat radiusOffset;
@property(nonatomic, assign) CGFloat radiusFill;
@property(nonatomic, copy) UIColor *color;

@end

@implementation AIProgressLayer

@synthesize color=_color;

- (id)initWithLayer:(AIProgressLayer *)layer
{
    self = [super initWithLayer:layer];
    if (self) {
        self.color = layer.color;
    }
    return self;
}

+ (BOOL)needsDisplayForKey:(NSString *)key
{
    if ([key isEqualToString:@"radiusOffset"] || [key isEqualToString:@"radiusFill"] || [key isEqualToString:@"color"]) {
        return YES;
    }
    return [super needsDisplayForKey:key];
}

- (void)drawInContext:(CGContextRef)context
{
    CGContextSetInterpolationQuality(context, kCGInterpolationHigh);
    CGContextSaveGState(context);
    
    CGFloat x = self.bounds.size.width / 2.f;
    CGFloat y = self.bounds.size.height / 2.f;
    
    CGFloat radius = MIN(self.bounds.size.width, self.bounds.size.height) / 2.f - 1.f;
    
    CGContextSetLineJoin(context, kCGLineJoinRound);
    CGContextSetLineCap(context, kCGLineCapRound);
    
    CGContextBeginPath(context);
    
    CGContextAddArc(context, x, y, radius, _radiusOffset + _radiusFill, _radiusOffset, YES);
    
    CGContextSetStrokeColorWithColor(context, self.color.CGColor);
    CGContextSetLineWidth(context, 2.f);
    
    CGContextDrawPath(context, kCGPathStroke);
    
    CGContextRestoreGState(context);
}

- (UIColor *)color
{
    return _color;
}

- (void)setColor:(UIColor *)color
{
    _color = color;
}

@end

@interface AIProgressView ()

@end

@implementation AIProgressView

+ (Class)layerClass
{
    return [AIProgressLayer class];
}

- (void)setColor:(UIColor *)color
{
    _color = color;
    
    AIProgressLayer *layer = (AIProgressLayer *)self.layer;
    layer.color = color;
}

- (void)awakeFromNib
{
    AIProgressLayer *layer = (AIProgressLayer *)self.layer;
    layer.contentsScale = [UIScreen mainScreen].scale;
}

- (void)startAnimating
{
    AIProgressLayer *layer = (AIProgressLayer *)self.layer;
    [[self animations] enumerateObjectsUsingBlock:^(CAAnimation *animation, NSUInteger idx, BOOL *stop) {
        [layer addAnimation:animation forKey:nil];
    }];
}

- (NSArray *)animations
{
    CABasicAnimation *spinAnimation = [CABasicAnimation animationWithKeyPath:@"radiusOffset"];
    spinAnimation.toValue = @(M_PI * 2.f);
    spinAnimation.fromValue = @(0.f);
    spinAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    spinAnimation.duration = 2.0;
    spinAnimation.repeatCount = INFINITY;
    spinAnimation.removedOnCompletion = NO;
    spinAnimation.beginTime = CACurrentMediaTime() + 1.f;

    CABasicAnimation *fillAnimation = [CABasicAnimation animationWithKeyPath:@"radiusFill"];
    fillAnimation.toValue = @(M_PI);
    fillAnimation.fromValue = @(0.f);
    fillAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    fillAnimation.duration = 1.0;
    fillAnimation.removedOnCompletion = NO;
    fillAnimation.fillMode = kCAFillModeForwards;
    
    return @[spinAnimation, fillAnimation];
}

- (void)stopAnimating
{
    AIProgressLayer *layer = (AIProgressLayer *)self.layer;
    [layer removeAllAnimations];
}

@end
