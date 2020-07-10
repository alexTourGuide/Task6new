//
//  FiguresView.h
//  Task06New
//
//  Created by Alexander Porshnev on 7/9/20.
//  Copyright © 2020 Alexander Porshnev. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

// Define a figure view type
typedef NS_ENUM(NSInteger, FigureViewType) {
    CircleView = 0,
    RectangleView = 1,
    TriangleView = 2
};

@interface FiguresView : UIView

@property (nonatomic, assign) FigureViewType figureType;
@property (nonatomic, strong) UIColor *figureColor;

// Initialization with frame, type ans color
- (instancetype)initWithFrame:(CGRect)frame figureType:(FigureViewType)figureType color:(UIColor *)figureColor;
// Animation setting
- (void)startAnimation;

@end

NS_ASSUME_NONNULL_END
