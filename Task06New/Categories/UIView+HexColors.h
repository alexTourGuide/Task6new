//
//  UIView+HexColors.h
//  Task06New
//
//  Created by Alexander Porshnev on 7/9/20.
//  Copyright © 2020 Alexander Porshnev. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (HexColors)

+ (UIColor *)requiredBlackColor;
+ (UIColor *)requiredWhiteColor;
+ (UIColor *)requiredRedColor;
+ (UIColor *)requiredBlueColor;
+ (UIColor *)requiredGreenColor;
+ (UIColor *)requiredYellowColor;
+ (UIColor *)requiredGrayColor;
+ (UIColor *)requiredYellowHighlightedColor;

+ (UIColor *)colorWithHexValue:(int)value;

@end

NS_ASSUME_NONNULL_END
