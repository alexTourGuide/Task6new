//
//  UIView+HexColors.m
//  Task06New
//
//  Created by Alexander Porshnev on 7/9/20.
//  Copyright © 2020 Alexander Porshnev. All rights reserved.
//

#import "UIView+HexColors.h"

@implementation UIColor (HexColors)

+ (UIColor *)colorWithHexValue:(int)value {
    int redPart = (value >> 16)  & 0xff;
    int greenPart = (value >> 8) & 0xff;
    int bluePart = value & 0xff;
    
    if ((redPart >= 0) && (redPart <= 255) &&
        (greenPart >= 0) && (greenPart <= 255) &&
        (bluePart >= 0) && (bluePart <= 255)
        )
    {
        return [UIColor colorWithRed:(redPart/255.0) green:(greenPart/255.0) blue:(bluePart/255.0) alpha:1];
    } else {
        return nil;
    }
}

+ (UIColor *)requiredBlackColor {
    return [UIColor colorWithHexValue:0x101010];
}

+ (UIColor *)requiredWhiteColor {
    return [UIColor colorWithHexValue:0xFFFFFF];
}

+ (UIColor *)requiredRedColor {
    return [UIColor colorWithHexValue:0xEE686A];
}

+ (UIColor *)requiredBlueColor {
    return [UIColor colorWithHexValue:0x29C2D1];
}

+ (UIColor *)requiredGreenColor {
    return [UIColor colorWithHexValue:0x34C1A1];
}

+ (UIColor *)requiredYellowColor {
    return [UIColor colorWithHexValue:0xF9CC78];
}

+ (UIColor *)requiredGrayColor{
    return [UIColor colorWithHexValue:0x707070];
}

+ (UIColor *)requiredYellowHighlightedColor{
    return [UIColor colorWithHexValue:0xFDF4E3];
}

@end
