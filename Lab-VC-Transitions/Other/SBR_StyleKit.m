//
//  SBR_StyleKit.m
//  Lab-VC-Transitions
//
//  Created by Hari Karam Singh on 21/05/2014.
//  Copyright (c) 2014 Air Craft. All rights reserved.
//

#import "SBR_StyleKit.h"

/////////////////////////////////////////////////////////////////////////
#pragma mark - Consts
/////////////////////////////////////////////////////////////////////////

static NSMutableDictionary *_cache;


/////////////////////////////////////////////////////////////////////////
#pragma mark -
/////////////////////////////////////////////////////////////////////////


@implementation SBR_StyleKit


/////////////////////////////////////////////////////////////////////////
#pragma mark - Life Cycle
/////////////////////////////////////////////////////////////////////////

+ (void)initialize
{
    _cache = [NSMutableDictionary dictionary];
}

//---------------------------------------------------------------------

+ (void)flushCache
{
    [_cache removeAllObjects];
}

//---------------------------------------------------------------------

+ (id)cached:(NSString *)objName orInit:(id (^)(void))initBlock
{
    id obj = _cache[objName];
    if (!obj) {
        obj = initBlock();
        _cache[objName] = obj;
    }
    return obj;
}

/////////////////////////////////////////////////////////////////////////
#pragma mark - Colors, Fonts
/////////////////////////////////////////////////////////////////////////

+ (UIColor *)backgroundColor
{
    return [UIColor blackColor];
}

//---------------------------------------------------------------------

+ (UIColor *)yellowTextColor { return [UIColor colorWithHue:0.162 saturation:0.378 brightness:1 alpha:1]; }
+ (UIColor *)yellowTextHighlightColor { return [UIColor colorWithHue:0.162 saturation:0.378 brightness:0.5 alpha:1]; }
+ (UIFont *)settingsMenuFont { return [UIFont fontWithName:@"OCRAStd" size:20.0]; }



/////////////////////////////////////////////////////////////////////////
#pragma mark - Ready-made UIImages
/////////////////////////////////////////////////////////////////////////

+ (UIImage *)swipeUpIcon
{
    return [self cached:@"icon-swipe" orInit:^id{
        return [UIImage imageNamed:@"icon-swipe"];
    }];
}

//---------------------------------------------------------------------

+ (UIImage *)swipeRightIcon
{
    return [self cached:@"icon-swipe-right" orInit:^id{
        
        // Rotate the swip icon
        return [[UIImage imageNamed:@"icon-swipe"] imageRotatedByRadians:-M_PI_2];
    }];
}

//---------------------------------------------------------------------

+ (UIButton *)swipeRightIconButton
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[self swipeRightIcon] forState:UIControlStateNormal];
    btn.size = CGSizeMake(44, 44);
    return btn;
}

//---------------------------------------------------------------------

+ (UIImage *)imageForSettingsMenuGlowingTextButtonWithText:(NSString *)text
                                               highlighted:(BOOL)highlighted
{
    UIColor *color = highlighted ? [self yellowTextHighlightColor] : [self yellowTextColor];
    return [self _glowingTextWithText:text
                                 font:[self settingsMenuFont]
                                color:color
                            alignment:NSTextAlignmentLeft
                            maskWidth:250];
}

/////////////////////////////////////////////////////////////////////////
#pragma mark - Additional Privates
/////////////////////////////////////////////////////////////////////////

+ (UIImage *)_glowingTextWithText:(NSString *)text
                             font:(UIFont *)font
                            color:(UIColor *)color
                        alignment:(NSTextAlignment)alignment
                        maskWidth:(CGFloat)maskWidth
{
    // Create the gradient based around the color
    NSDictionary *grad = @{
                           @(0.0): [color colorWithBrightenessScaledBy:0.4],
                           @(0.2): color,
                           @(1.0): [color colorWithBrightenessScaledBy:0.3]
                           };
    
    
    // Create the label
    UILabel *lbl = [[UILabel alloc] init];
    lbl.text = text;
    lbl.font = font;
    lbl.textColor = [UIColor colorWithPatternImage:[UIImage horizontalGradientImageWithSize:CGSizeMake(maskWidth, 50) colors:grad]];
    lbl.textAlignment = alignment;
    [lbl sizeToFit];
    CGRect f = lbl.frame;
    f.size.height *= 2.0;
    lbl.frame = f;
    CGSize size = { maskWidth, lbl.frame.size.height };
    
    lbl.layer.shadowRadius = 4;
    lbl.layer.shadowColor = color.CGColor;
    lbl.layer.shadowOpacity = 0.6;
    lbl.layer.shadowOffset = CGSizeZero;
    
    // Draw...
    UIImage *resultImg;
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    {
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        [lbl.layer renderInContext:ctx];
        resultImg = UIGraphicsGetImageFromCurrentImageContext();
    }
    UIGraphicsEndImageContext();

    return resultImg;
}

//---------------------------------------------------------------------



@end
