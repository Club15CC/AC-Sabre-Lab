//
//  SBR_StyleKit.h
//  Lab-VC-Transitions
//
//  Created by Hari Karam Singh on 21/05/2014.
//  Copyright (c) 2014 Air Craft. All rights reserved.
//

#import <Foundation/Foundation.h>


/** Factory for colors images and drawing assets */
@interface SBR_StyleKit : NSObject

+ (void)flushCache;
+ (id)cached:(NSString *)objName orInit:(id(^)(void))initBlock;

+ (UIColor *)backgroundColor;
+ (UIColor *)yellowTextColor;
+ (UIColor *)yellowTextHighlightColor;
+ (UIFont *)settingsMenuFont;

+ (UIImage *)swipeUpIcon;
+ (UIImage *)swipeRightIcon;

+ (UIButton *)swipeRightIconButton;


+ (UIImage *)imageForSettingsMenuGlowingTextButtonWithText:(NSString *)text
                                               highlighted:(BOOL)highlighted;

@end
