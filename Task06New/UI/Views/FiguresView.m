//
//  FiguresView.m
//  Task06New
//
//  Created by Alexander Porshnev on 7/9/20.
//  Copyright © 2020 Alexander Porshnev. All rights reserved.
//

#import "FiguresView.h"
#import "UIView+HexColors.h"
#import <QuartzCore/QuartzCore.h>

@implementation FiguresView

- (instancetype)initWithFrame:(CGRect)frame figureType:(FigureViewType)figureType color:(UIColor *)figureColor {
    self = [super initWithFrame:frame];
    if (self) {
        _figureType = figureType;
        _figureColor = figureColor;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    switch (self.figureType) {
        case CircleView:
            [self drawCircle:rect];
            break;
        case RectangleView:
            [self drawRectangle:rect];
            break;
        case TriangleView:
            [self drawTriangle:rect];
            break;
    }
}

#pragma mark - Draw the figures

- (void)drawCircle:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, _figureColor.CGColor);
    CGContextFillEllipseInRect(context, CGRectMake(0.0, 0.0, rect.size.width, rect.size.height));
}

- (void)drawRectangle:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, _figureColor.CGColor);
    CGContextFillRect(context, rect);
}

- (void)drawTriangle:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, _figureColor.CGColor);
    CGContextMoveToPoint(context, CGRectGetMinX(rect), CGRectGetMinY(rect)); // top left
    CGContextAddLineToPoint(context, CGRectGetMaxX(rect), CGRectGetMidY(rect)); // mid right
    CGContextAddLineToPoint(context, CGRectGetMinX(rect), CGRectGetMaxY(rect)); // bottom left
    CGContextFillPath(context);
}

#pragma mark - Figures animation

- (void)animateCircle {
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.duration = 1.0;
    scaleAnimation.repeatCount = INFINITY;
    scaleAnimation.fromValue = [NSNumber numberWithDouble:0.9];
    scaleAnimation.toValue = [NSNumber numberWithDouble:1.1];
    scaleAnimation.autoreverses = YES;
    scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.layer addAnimation:scaleAnimation forKey:@"scaleAnimation"];
}

- (void)animateRectangle {
    CABasicAnimation *positionAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    positionAnimation.duration = 1.0;
    positionAnimation.repeatCount = INFINITY;
    positionAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(self.center.x, self.center.y - 7.0)];
    positionAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(self.center.x, self.center.y + 7.0)];
    positionAnimation.autoreverses = YES;
    positionAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [self.layer addAnimation:positionAnimation forKey:@"positionAnimation"];
}

- (void)animateTriangle {
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.duration = 5.0;
    rotationAnimation.repeatCount = INFINITY;
    rotationAnimation.fromValue = [NSNumber numberWithDouble:0.0];
    rotationAnimation.toValue = [NSNumber numberWithDouble:2 * M_PI];
    [self.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

- (void)startAnimation {
    switch (self.figureType) {
        case CircleView:
            [self animateCircle];
            break;
        case RectangleView:
            [self animateRectangle];
            break;
        case TriangleView:
            [self animateTriangle];
            break;
    }
}

@end
