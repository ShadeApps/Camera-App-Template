//  SGFunctions.m
//
//  Created by Sergey Grischyov on 14.06.12.
//  Copyright (c) 2014 ShadeApps. All rights reserved.
//

#import "CBTFunctions.h"

#import <Availability.h>

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import <QuartzCore/QuartzCore.h>

#import <sys/utsname.h>
#if !__has_feature(objc_arc)
#error This library requires automatic reference counting
#endif

@implementation CBTFunctions{}
#pragma mark -
#pragma mark ==========КАСТОМИЗАЦИЯ==========
//##################################################//
//                                                  //
//                  КАСТОМИЗАЦИЯ                    //
//                                                  //
//##################################################//

#pragma mark - UILabel
+ (UILabel *)labelWithFontName:(NSString *)fontName fontSize:(float)fontSize fontColor:(NSString *)fontColor andDefaultText:(NSString *)text{
    return [CBTFunctions labelWithFontName:fontName fontSize:fontSize fontColor:fontColor shadowOffset:CGSizeMake(0, 0) shadowColor:@"#000000" andDefaultText:text];
}

+ (UILabel *)labelWithFontName:(NSString *)fontName fontSize:(float)fontSize fontColor:(NSString *)fontColor shadowOffset:(CGSize)shadowOffset shadowColor:(NSString *)shadowColor andDefaultText:(NSString *)text{
    UILabel *tmpLabel = [[UILabel alloc] init];
    [tmpLabel setBackgroundColor:[UIColor clearColor]];
    tmpLabel.font = [UIFont fontWithName:fontName size:fontSize];
    tmpLabel.textColor = [CBTFunctions colorFromHex:fontColor withAlpha:1.0f];
    
    if (!CGSizeEqualToSize(shadowOffset, CGSizeZero)){
        tmpLabel.shadowColor = [CBTFunctions colorFromHex:shadowColor withAlpha:1.0f];
        tmpLabel.shadowOffset = shadowOffset;
    }
    
    tmpLabel.text = text;
    [tmpLabel sizeToFit];
    return tmpLabel;
}

#pragma mark - UITextField
#pragma mark ---Текстовое поле из одной картинки---
+ (UITextField *)textFieldWithImageNamed:(NSString *)imageName margin:(float)leftMargin fontName:(NSString *)fontName fontSize:(float)fontSize fontColor:(NSString *)fontColor andPlaceholder:(NSString *)placeholder{
    UITextField *txtField = [[UITextField alloc] init];
    [txtField setBorderStyle:UITextBorderStyleNone];
    
    UIImage *tmpImage = [UIImage imageNamed:imageName];
    txtField.background = tmpImage;
    
    txtField.frame = CGRectMake(0, 0, tmpImage.size.width, tmpImage.size.height);
    
    txtField.textColor = [CBTFunctions colorFromHex:fontColor];
    txtField.font = [UIFont fontWithName:fontName size:fontSize];
    [txtField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    
    UIView *margin = [[UIView alloc] initWithFrame:CGRectMake(0, 0, leftMargin, txtField.frame.size.height)];
    [margin setUserInteractionEnabled:NO];
    
    [txtField setLeftView:margin];
    txtField.leftViewMode = UITextFieldViewModeAlways;
    [txtField setRightView:margin];
    txtField.rightViewMode = UITextFieldViewModeAlways;
    
    txtField.text = @"";
    
    txtField.placeholder = placeholder;
    
    return txtField;
}

#pragma mark ---Текстовое поле из трех картинок---
+ (UITextField *)textFieldWithLeftImageNamed:(NSString *)leftImageName middleImageNamed:(NSString *)middleImageName rightImageNamed:(NSString *)rightImageName fieldWidth:(float)width margin:(float)leftMargin fontName:(NSString *)fontName fontSize:(float)fontSize fontColor:(NSString *)fontColor andPlaceholder:(NSString *)placeholder{
    UITextField *txtField = [[UITextField alloc] init];
    
    UIImageView *leftImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:leftImageName]];
    
    UIImageView *rightImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:rightImageName]];
    rightImage.frame = CGRectMake(width - rightImage.frame.size.width, 0, rightImage.frame.size.width, rightImage.frame.size.height);
    
    UIImageView *middleImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:middleImageName]];
    middleImage.frame = CGRectMake(leftImage.frame.size.width, 0, width - leftImage.frame.size.width - rightImage.frame.size.width, middleImage.frame.size.height);
    
    UIView *resultImage = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, leftImage.frame.size.height)];
    
    [resultImage addSubview:leftImage];
    [resultImage addSubview:middleImage];
    [resultImage addSubview:rightImage];
    
    if (resultImage.frame.size.height && resultImage.frame.size.width){
        if (NULL != &UIGraphicsBeginImageContextWithOptions){
            UIGraphicsBeginImageContextWithOptions(resultImage.frame.size, NO, [[UIScreen mainScreen] scale]);
        }
        
        [resultImage.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage *screenshot = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
        txtField.frame = CGRectMake(0, 0, screenshot.size.width, screenshot.size.height);
        txtField.background = screenshot;
    }else{
        txtField.frame = CGRectMake(0, 0, resultImage.frame.size.width, fontSize);
    }
    
    txtField.textColor = [CBTFunctions colorFromHex:fontColor withAlpha:1.0f];
    txtField.font = [UIFont fontWithName:fontName size:fontSize];
    [txtField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    
    if (leftMargin > 0){
        UIView *leftMarginView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, leftMargin, txtField.frame.size.height)];
        leftMarginView.userInteractionEnabled = NO;
        [txtField setLeftView:leftMarginView];
        txtField.leftViewMode = UITextFieldViewModeAlways;
        
        UIView *rightMarginView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, leftMargin, txtField.frame.size.height)];
        rightMarginView.userInteractionEnabled = NO;
        [txtField setRightView:rightMarginView];
        txtField.rightViewMode = UITextFieldViewModeAlways;
    }
    
    txtField.placeholder = placeholder;
    
    txtField.text = @"";
    
    return txtField;
}

#pragma mark - UIButton
#pragma mark ---Кнопка из трех картинок---
+ (UIButton *)buttonWithMinWidth:(float)minWidth leftImageNamed:(NSString *)leftImageName middleImageNamed:(NSString *)middleImageName rightImageNamed:(NSString *)rightImageName imageShadow:(float)shadow iconImageNamed:(NSString *)iconImageName fontName:(NSString *)fontName fontSize:(float)fontSize fontColor:(NSString *)fontColor buttonText:(NSString *)text target:(id)target selector:(SEL)selector{
    return [CBTFunctions buttonWithMinWidth:minWidth leftImageNamed:leftImageName middleImageNamed:middleImageName rightImageNamed:rightImageName imageShadow:shadow iconImageNamed:iconImageName fontName:fontName fontSize:fontSize fontColor:fontColor buttonText:text shadowColor:@"#000000" shadowOffset:CGSizeMake(0, 0) target:target selector:selector];
}

+ (UIButton *)buttonWithMinWidth:(float)minWidth leftImageNamed:(NSString *)leftImageName middleImageNamed:(NSString *)middleImageName rightImageNamed:(NSString *)rightImageName imageShadow:(float)shadow iconImageNamed:(NSString *)iconImageName fontName:(NSString *)fontName fontSize:(float)fontSize fontColor:(NSString *)fontColor buttonText:(NSString *)text shadowColor:(NSString *)shadowColor shadowOffset:(CGSize)shadowOffset target:(id)target selector:(SEL)selector{
    
    UIButton *tmpButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    UIImageView *leftImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:leftImageName]];
    UIImageView *middleImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:middleImageName]];
    UIImageView *rightImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:rightImageName]];
    
    UIImageView *iconImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:iconImageName]];
    
    UILabel *tmpLabel = [[UILabel alloc] init];
    tmpLabel.backgroundColor = [UIColor clearColor];
    tmpLabel.font = [UIFont fontWithName:fontName size:fontSize];
    tmpLabel.textColor = [CBTFunctions colorFromHex:fontColor withAlpha:1.0f];
    
    if (!CGSizeEqualToSize(shadowOffset, CGSizeZero)){
        tmpLabel.shadowColor = [CBTFunctions colorFromHex:shadowColor withAlpha:1.0f];
        tmpLabel.shadowOffset = shadowOffset;
    }

    tmpLabel.text = text;
    if ([CBTFunctions systemVersion] >= 60000){
        tmpLabel.textAlignment = NSTextAlignmentCenter;
    }
    [tmpLabel sizeToFit];
    
    float resultWidth;
    
    if (iconImageName.length > 0){
        resultWidth = leftImage.frame.size.width + iconImage.frame.size.width + tmpLabel.frame.size.width + rightImage.frame.size.width;
    }else{
        resultWidth = leftImage.frame.size.width + tmpLabel.frame.size.width + rightImage.frame.size.width;
    }
    
    if (resultWidth < minWidth) resultWidth = minWidth;
    
    UIView *resultImage = [[UIView alloc] initWithFrame:CGRectMake(0, 0, resultWidth, leftImage.frame.size.height)];
    [resultImage addSubview:leftImage];
    
    middleImage.frame = CGRectMake(leftImage.frame.size.width, 0, resultWidth - leftImage.frame.size.width - rightImage.frame.size.width, middleImage.frame.size.height);
    [resultImage addSubview:middleImage];
    
    rightImage.frame = CGRectMake(middleImage.frame.origin.x + middleImage.frame.size.width, 0, rightImage.frame.size.width, rightImage.frame.size.height);
    [resultImage addSubview:rightImage];
    
    if (iconImageName.length > 0){
        iconImage.frame = CGRectMake(leftImage.frame.size.width, floorf((resultImage.frame.size.height - iconImage.frame.size.height) / 2), iconImage.frame.size.width, iconImage.frame.size.height);
        [resultImage addSubview:iconImage];
        
        float leftMargin = iconImage.frame.origin.x + iconImage.frame.size.width;
        
        tmpLabel.frame = CGRectMake(leftMargin, floorf((resultImage.frame.size.height - tmpLabel.frame.size.height) / 2) - shadow, resultImage.frame.size.width - leftMargin - shadow, tmpLabel.frame.size.height);
    }else{
        tmpLabel.frame = CGRectMake(leftImage.frame.size.width, floorf((resultImage.frame.size.height - tmpLabel.frame.size.height) / 2) - shadow, resultImage.frame.size.width - leftImage.frame.size.width - rightImage.frame.size.width, tmpLabel.frame.size.height);
    }
    
    
    [resultImage addSubview:tmpLabel];
    
    if (NULL != &UIGraphicsBeginImageContextWithOptions){
        UIGraphicsBeginImageContextWithOptions(resultImage.frame.size, NO, [[UIScreen mainScreen] scale]);
    }
    
    [resultImage.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *screenshot = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    tmpButton.titleLabel.text = @"";
    [tmpButton setBackgroundImage:screenshot forState:UIControlStateNormal];
    [tmpButton sizeToFit];
    
    [tmpButton addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    
    return tmpButton;
}


#pragma mark ---Кнопка из одной картинки---
+ (UIButton *)buttonWithImageNamed:(NSString *)normalImageName target:(id)target selector:(SEL)selector{
    return [CBTFunctions buttonWithImageNamed:normalImageName highlightedImageName:nil fontName:@"Helvetica-Bold" fontSize:12 fontColor:@"ffffff" buttonText:@"" shadowColor:@"#000000" shadowOffset:CGSizeMake(0, 0) target:target selector:selector];
}

+ (UIButton *)buttonWithImageNamed:(NSString *)normalImageName highlightedImageName:(NSString *)highlightedImageName target:(id)target selector:(SEL)selector{
    return [CBTFunctions buttonWithImageNamed:normalImageName highlightedImageName:highlightedImageName fontName:@"Helvetica-Bold" fontSize:12 fontColor:@"ffffff" buttonText:@"" shadowColor:@"#000000" shadowOffset:CGSizeMake(0, 0) target:target selector:selector];
}

+ (UIButton *)buttonWithImageNamed:(NSString *)normalImageName highlightedImageName:(NSString *)highlightedImageName fontName:(NSString *)fontName fontSize:(float)fontSize fontColor:(NSString *)fontColor buttonText:(NSString *)text target:(id)target selector:(SEL)selector{
    return [CBTFunctions buttonWithImageNamed:normalImageName highlightedImageName:highlightedImageName fontName:fontName fontSize:fontSize fontColor:fontColor buttonText:text shadowColor:@"#000000" shadowOffset:CGSizeMake(0, 0) target:target selector:selector];
}

+ (UIButton *)buttonWithImageNamed:(NSString *)normalImageName highlightedImageName:(NSString *)highlightedImageName fontName:(NSString *)fontName fontSize:(float)fontSize fontColor:(NSString *)fontColor buttonText:(NSString *)text shadowColor:(NSString *)shadowColor shadowOffset:(CGSize)shadowOffset target:(id)target selector:(SEL)selector{
    UIButton *tmpButton = [[UIButton alloc] init];
    
    [tmpButton setImage:[UIImage imageNamed:normalImageName] forState:UIControlStateNormal];
    if (highlightedImageName) [tmpButton setImage:[UIImage imageNamed:highlightedImageName] forState:UIControlStateHighlighted];
    [tmpButton sizeToFit];
    
    tmpButton.adjustsImageWhenHighlighted = YES;
    
    tmpButton.contentMode = UIViewContentModeCenter;
    
    [tmpButton setTitle:text forState:UIControlStateNormal];
    [tmpButton setTitleColor:[CBTFunctions colorFromHex:fontColor] forState:UIControlStateNormal];
    [tmpButton setTitleColor:[CBTFunctions colorFromHex:fontColor withAlpha:0.6] forState:UIControlStateHighlighted];
    [tmpButton setTitleColor:[CBTFunctions colorFromHex:fontColor withAlpha:0.5] forState:UIControlStateDisabled];
    tmpButton.titleLabel.font = [UIFont fontWithName:fontName size:fontSize];
    
    if (!CGSizeEqualToSize(shadowOffset, CGSizeZero)){
        [tmpButton setTitleShadowColor:[CBTFunctions colorFromHex:shadowColor] forState:UIControlStateNormal];
        tmpButton.titleLabel.shadowOffset = shadowOffset;
    }
    
    [tmpButton addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    
    return tmpButton;
}

+ (UIButton *)buttonWithImageNamed:(NSString *)normalImageName highlightedImageName:(NSString *)highlightedImageName labelLeftMargin:(float)labelLeftMargin fontName:(NSString *)fontName fontSize:(float)fontSize fontColor:(NSString *)fontColor buttonText:(NSString *)text shadowColor:(UIColor *)shadowColor shadowOffset:(CGSize)shadowOffset target:(id)target selector:(SEL)selector{
    UIButton *tmpButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [tmpButton setImage:[UIImage imageNamed:normalImageName] forState:UIControlStateNormal];
    if (highlightedImageName) [tmpButton setImage:[UIImage imageNamed:highlightedImageName] forState:UIControlStateHighlighted];
    
    tmpButton.adjustsImageWhenHighlighted = YES;
    
    [tmpButton setTitle:text forState:UIControlStateNormal];
    [tmpButton setTitleColor:[CBTFunctions colorFromHex:fontColor] forState:UIControlStateNormal];
    [tmpButton setTitleColor:[CBTFunctions colorFromHex:fontColor withAlpha:0.4] forState:UIControlStateHighlighted];
    [tmpButton setTitleColor:[CBTFunctions colorFromHex:fontColor withAlpha:0.3] forState:UIControlStateDisabled];
    tmpButton.titleLabel.font = [UIFont fontWithName:fontName size:fontSize];
    
    if (!CGSizeEqualToSize(shadowOffset, CGSizeZero)){
        [tmpButton setTitleShadowColor:shadowColor forState:UIControlStateNormal];
        tmpButton.titleLabel.shadowOffset = shadowOffset;
    }
    
    tmpButton.titleEdgeInsets = UIEdgeInsetsMake(0, labelLeftMargin, 0, 0);
    
    [tmpButton sizeToFit];
    
    tmpButton.frame = CGRectMake(tmpButton.frame.origin.x, tmpButton.frame.origin.y, tmpButton.frame.size.width + labelLeftMargin, tmpButton.frame.size.height);
    
    [tmpButton addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    
    return tmpButton;
}


#pragma mark ---Кнопка вместо ячеек таблицы---
+ (UIButton *)createCellLikeButtonWithImageNamed:(NSString *)imageName leftMargin:(float)leftMargin fontName:(NSString *)fontName fontSize:(float)fontSize fontColor:(NSString *)fontColor buttonText:(NSString *)text target:(id)target selector:(SEL)selector{
    return [CBTFunctions createCellLikeButtonWithImageNamed:imageName leftMargin:leftMargin fontName:fontName fontSize:fontSize fontColor:fontColor buttonText:text shadowColor:@"#000000" shadowOffset:CGSizeMake(0, 0) target:target selector:selector];
}

+ (UIButton *)createCellLikeButtonWithImageNamed:(NSString *)imageName leftMargin:(float)leftMargin fontName:(NSString *)fontName fontSize:(float)fontSize fontColor:(NSString *)fontColor buttonText:(NSString *)text shadowColor:(NSString *)shadowColor shadowOffset:(CGSize)shadowOffset target:(id)target selector:(SEL)selector{
    UIButton *tmpButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [tmpButton setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [tmpButton setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateHighlighted];
    [tmpButton sizeToFit];
    
    UILabel *tmpLabel = [[UILabel alloc] init];
    tmpLabel.backgroundColor = [UIColor clearColor];
    tmpLabel.font = [UIFont fontWithName:fontName size:fontSize];
    tmpLabel.textColor = [CBTFunctions colorFromHex:fontColor withAlpha:1.0f];
    
    if (!CGSizeEqualToSize(shadowOffset, CGSizeZero)){
        tmpLabel.shadowColor = [CBTFunctions colorFromHex:shadowColor withAlpha:1.0f];
        tmpLabel.shadowOffset = shadowOffset;
    }
    
    tmpLabel.text = text;
    if ([CBTFunctions systemVersion] >= 60000){
        tmpLabel.textAlignment = NSTextAlignmentLeft;
    }
    [tmpLabel sizeToFit];
    tmpLabel.frame = CGRectMake(leftMargin, floorf((tmpButton.frame.size.height - tmpLabel.frame.size.height) / 2), tmpButton.frame.size.width - leftMargin * 2, tmpLabel.frame.size.height);
    
    [tmpButton addSubview:tmpLabel];
    [tmpButton addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    
    return tmpButton;
}

#pragma mark ---Кастомизация существующей кнопки---
+ (void) remakeButton:(UIButton *)tmpButton setBothImagesNamed:(NSString *)imageName{
    [tmpButton setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [tmpButton setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateHighlighted];
    [tmpButton sizeToFit];
}

+ (void) remakeButton:(UIButton *)tmpButton setBothImagesNamed:(NSString *)imageName andTitle:(NSString *)newTitle{
    [tmpButton setTitle:newTitle forState:UIControlStateNormal];
    [tmpButton setTitle:newTitle forState:UIControlStateHighlighted];
    [CBTFunctions remakeButton:tmpButton setBothImagesNamed:imageName];
}


#pragma mark - UINavigationBar
+ (UINavigationBar *)createNavigationBarWithImageNamed:(NSString *)imageName{
    return [CBTFunctions createNavigationBarWithImageNamed:imageName shadowImageNamed:nil andTitle:nil];
}

+ (UINavigationBar *)createNavigationBarWithImageNamed:(NSString *)imageName andTitle:(NSString *)title{
    return [CBTFunctions createNavigationBarWithImageNamed:imageName shadowImageNamed:nil andTitle:title];
}

+ (UINavigationBar *)createNavigationBarWithImageNamed:(NSString *)imageName shadowImageNamed:(NSString *)shadowImageNamed andTitle:(NSString *)title{
    UINavigationBar *navigationBar = [[UINavigationBar alloc] init];
    
    [navigationBar setBackgroundImage:[UIImage imageNamed:imageName] forBarMetrics:UIBarMetricsDefault];
    [navigationBar sizeToFit];
    
    UINavigationItem *topItem = [[UINavigationItem alloc] init];
    [navigationBar setItems:@[topItem]];
    
    if (shadowImageNamed){
        if ([CBTFunctions systemVersion] >= 60000){
            navigationBar.shadowImage = [UIImage imageNamed:shadowImageNamed];
        }else{
            UIImageView *shadowImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:shadowImageNamed]];
            shadowImage.frame = CGRectMake(0, navigationBar.frame.size.height, shadowImage.frame.size.width, shadowImage.frame.size.height);
            [navigationBar addSubview:shadowImage];
        }
    }
    

    UILabel *tmpLabel = [[UILabel alloc]init];
    tmpLabel.text = title;
    tmpLabel.backgroundColor = [UIColor clearColor];
    if ([CBTFunctions systemVersion] >= 60000){
        tmpLabel.textAlignment = NSTextAlignmentCenter;
    }
    [tmpLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:15.0]];
    [tmpLabel sizeToFit];
    
    tmpLabel.textColor = [UIColor whiteColor];
    
    [navigationBar.topItem setTitleView:tmpLabel];
    
    navigationBar.frame = CGRectMake(0, 0, navigationBar.frame.size.width, navigationBar.frame.size.height);
    
    return navigationBar;
}


#pragma mark - UIBarButtonItem
+ (UIBarButtonItem *)createBarButtonItemWithImageNamed:(NSString *)imageName target:(id)target selector:(SEL)selector{
    return [CBTFunctions createBarButtonItemWithImageNamed:imageName fontName:@"" fontSize:12 fontColor:@"#ffffff" buttonText:@"" shadowColor:@"#000000" shadowOffset:CGSizeMake(0, 0) target:target selector:selector];
}

+ (UIBarButtonItem *)createBarButtonItemWithImageNamed:(NSString *)imageName buttonText:(NSString *)text target:(id)target selector:(SEL)selector{
    return [CBTFunctions createBarButtonItemWithImageNamed:imageName fontName:@"HelveticaNeue" fontSize:12 fontColor:@"#ffffff" buttonText:text shadowColor:@"#000000" shadowOffset:CGSizeMake(0, 0) target:target selector:selector];
}

+ (UIBarButtonItem *)createBarButtonItemWithImageNamed:(NSString *)imageName fontName:(NSString *)fontName fontSize:(float)fontSize fontColor:(NSString *)fontColor buttonText:(NSString *)text target:(id)target selector:(SEL)selector{
    return [CBTFunctions createBarButtonItemWithImageNamed:imageName fontName:fontName fontSize:fontSize fontColor:fontColor buttonText:text shadowColor:@"#000000" shadowOffset:CGSizeMake(0, 0) target:target selector:selector];
}

+ (UIBarButtonItem *)createBarButtonItemWithImageNamed:(NSString *)imageName fontName:(NSString *)fontName fontSize:(float)fontSize fontColor:(NSString *)fontColor buttonText:(NSString *)text shadowColor:(NSString *)shadowColor shadowOffset:(CGSize)shadowOffset target:(id)target selector:(SEL)selector{
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] init];
    UIButton *tmpButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [tmpButton addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    [tmpButton setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [tmpButton sizeToFit];
    
    if (text){
        UILabel *tmpLabel = [[UILabel alloc] init];
        tmpLabel.text = text;
        tmpLabel.font = [UIFont fontWithName:fontName size:fontSize];
        tmpLabel.textColor = [CBTFunctions colorFromHex:fontColor];
        tmpLabel.backgroundColor = [UIColor clearColor];
        
        if (!CGSizeEqualToSize(shadowOffset, CGSizeZero)){
            tmpLabel.shadowColor = [CBTFunctions colorFromHex:shadowColor withAlpha:1.0f];
            tmpLabel.shadowOffset = shadowOffset;
        }
        
        if ([CBTFunctions systemVersion] >= 60000){
            tmpLabel.textAlignment = NSTextAlignmentCenter;
        }
        
        [tmpLabel sizeToFit];
        tmpLabel.frame = CGRectMake(0, 0, tmpButton.frame.size.width, tmpButton.frame.size.height);
        [tmpButton addSubview:tmpLabel];
        
    }
    [barButton setCustomView:tmpButton];
    
    return barButton;
}

+ (void) changeTitleAtCustomizedBarButtonItem:(UIBarButtonItem *)barButton toNew:(NSString *)newTitle{
    UIView *tmpView = barButton.customView;
    for (UILabel *obj in tmpView.subviews) {
        if ([obj isKindOfClass:[UILabel class]] == YES){
            obj.text = newTitle;
            return;
        }
    }
}

#pragma mark -
#pragma mark ==========ДОПОЛНИТЕЛЬНЫЕ ФУНКЦИИ==========
//##################################################//
//                                                  //
//              ДОПОЛНИТЕЛЬНЫЕ ФУНКЦИИ              //
//                                                  //
//##################################################//

+ (int) systemVersion{
    NSString *version = [[UIDevice currentDevice] systemVersion];
    version = [version stringByReplacingOccurrencesOfString: @"." withString: @""];
    for (unsigned long i = [version length] + 1; i <= 5; i++) {
        version = [NSString stringWithFormat:@"%@0",version];
    }
    
    return [version intValue];
}



+ (UIColor *) colorFromHex:(NSString*)stringColor{
    return [CBTFunctions colorFromHex:stringColor withAlpha:1.0f];
}

+ (UIColor *) colorFromHex:(NSString*) stringColor withAlpha:(float)alpha{
    
    //Several rules
    if ([stringColor isEqualToString:@"white"]) return [[UIColor whiteColor] colorWithAlphaComponent:alpha];
    if ([stringColor isEqualToString:@"black"]) return [[UIColor blackColor]  colorWithAlphaComponent:alpha];
    if ([stringColor isEqualToString:@"lightGray"]) return [[UIColor lightGrayColor]  colorWithAlphaComponent:alpha];
    if ([stringColor isEqualToString:@"gray"]) return [[UIColor grayColor] colorWithAlphaComponent:alpha];
    if ([stringColor isEqualToString:@"red"]) return [[UIColor redColor] colorWithAlphaComponent:alpha];
    if ([stringColor isEqualToString:@"green"]) return [[UIColor greenColor] colorWithAlphaComponent:alpha];
    if ([stringColor isEqualToString:@"blue"]) return [[UIColor blueColor] colorWithAlphaComponent:alpha];
    
    if (stringColor.length == 0) return [UIColor blackColor];
    if ([[stringColor substringToIndex:1] isEqualToString:@"#"] == YES) stringColor = [stringColor substringFromIndex:1];
    
    if ([stringColor length] != 6) return [UIColor blackColor];
    
    stringColor = [stringColor uppercaseString];
    
    float red = 0;
    float green = 0;
    float blue = 0;
    
    int i = 0;
    while (i < [stringColor length])
    {
        NSString * hexChar = [stringColor substringWithRange: NSMakeRange(i, 2)];
        int value = 0;
        sscanf([hexChar cStringUsingEncoding:NSASCIIStringEncoding], "%x", &value);
        
        if (i == 0) red = value;
        if (i == 2) green = value;
        if (i == 4) blue = value;
        
        i+=2;
    }
    
    if (red < 0 || red > 255 || green < 0 || green > 255 || blue < 0 || blue > 255) return [UIColor blackColor];
    
    return [UIColor colorWithRed:red / 255.0f green:green / 255.0f blue:blue / 255.0f alpha:alpha];
}

+ (NSString *)getCurrentLocale{
    return [NSLocale preferredLanguages][0];
}

+ (NSString *)getCurrentRegion{
    NSLocale *locale = [NSLocale currentLocale];
    NSLocale *frLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    NSString *displayNameString = [frLocale displayNameForKey:NSLocaleIdentifier value:[locale localeIdentifier]];
    
    displayNameString = [displayNameString substringToIndex:[displayNameString length] - 1];
    NSRange prefixRange = [displayNameString rangeOfString:@"("];
    displayNameString = [displayNameString substringFromIndex:prefixRange.location + 1];
    
    return displayNameString;
}

+ (void)showAlertWithTitle:(NSString *)title andText:(NSString *)text{
    [[[UIAlertView alloc] initWithTitle:title message:text delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
}

+ (void) showNoWiFiAlert{
    NSString *title=@"Отсутствует доступ к WiFi";
    NSString *cancelTitle=@"OK";
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Ошибка" message:title delegate:self cancelButtonTitle:cancelTitle otherButtonTitles:nil];
    
    [alertView show];
}

+ (void) showOfflineModeAlert{
    NSString *title=@"Активирован оффлайн-режим";
    NSString *cancelTitle=@"OK";
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:title delegate:self cancelButtonTitle:cancelTitle otherButtonTitles:nil];
    [alertView show];
}

+ (void) showNoConnectionAlert{
    NSString *title = @"No network connection";
    NSString *cancelTitle = @"OK";
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:title delegate:nil cancelButtonTitle:cancelTitle otherButtonTitles:nil];
    [alertView show];
}

+ (void) showWrongEmailAlert{
    NSString *title = NSLocalizedString(@"WrongEmailAlertTitle", @"");
    NSString *message = NSLocalizedString(@"WrongEmailAlertBody", @"");
    NSString *cancelTitle = @"OK";
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:cancelTitle otherButtonTitles:nil];
    [alertView show];
}

+ (void) showGeneralLoginErrorAlert{
    NSString *title = @"Authorisation error";
    NSString *cancelTitle = @"OK";
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:title delegate:nil cancelButtonTitle:cancelTitle otherButtonTitles:nil];
    
    [alertView show];
}

+ (void) showWrongPassLoginErrorAlert{
    NSString *title = @"Incorrect login or passsword";
    NSString *cancelTitle = @"OK";
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:title delegate:nil cancelButtonTitle:cancelTitle otherButtonTitles:nil];
    
    [alertView show];
}

+ (void) stopUserInteraction{
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
}

+ (void) startUserInteraction{
     [[UIApplication sharedApplication] endIgnoringInteractionEvents];
}

+ (void) showNetworkActivityIndicator{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

+ (void) hideNetworkActivityIndicator{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

+ (BOOL) isValidEmail:(NSString *)checkString{
    NSString *stricterFilterString = @"[A-Z0-9a-zА-Яа-я._%+-]+@[A-Za-z0-9А-Яа-я.-]+\\.[A-Za-zА-Яа-я]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", stricterFilterString];
    return [emailTest evaluateWithObject:checkString];
}

+ (BOOL)isiPhone4{
    NSString *deviceType;
    struct utsname systemInfo;
    uname(&systemInfo);
    deviceType = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    if ([deviceType rangeOfString:@"iPhone3"].location == NSNotFound) {
        return NO;
    }else{
        return YES;
    }
}

+ (BOOL)isiPhone4S{
    NSString *deviceType;
    struct utsname systemInfo;
    uname(&systemInfo);
    deviceType = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    if ([deviceType isEqualToString:@"iPhone4,1"]){
        return YES;
    }else{
        return NO;
    }
}

+ (BOOL)isRetina4Inch{
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    return [UIScreen mainScreen].scale == 2.f && screenHeight == 568.0f;
}

+ (BOOL)isRetina3_5Inch{
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    return [UIScreen mainScreen].scale == 2.f && screenHeight == 480.0f;
}

+ (BOOL)isRetina3_5or4Inch{
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    return [UIScreen mainScreen].scale == 2.f && screenWidth == 320.0f;
}

+ (BOOL)isRetina4_7Inch{
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    return [UIScreen mainScreen].scale == 2.f && screenWidth == 375.0f;
}

+ (BOOL)isRetina5_5Inch{
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    return [UIScreen mainScreen].scale == 3.f && screenWidth == 414.0f;
}

+ (UIImage *)iPhone5ImageNamed:(NSString *)imageName{
    UIImage *tmpImage;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    if ([UIScreen mainScreen].scale == 2.f && screenHeight == 568.0f) {
        NSString *fileName = [imageName stringByDeletingPathExtension];
        NSString *extention = [imageName pathExtension];
        
        tmpImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@-568h.%@", fileName, extention]];
    } else {
        tmpImage = [UIImage imageNamed:imageName];
    }
    
    return tmpImage;
}



+ (u_int32_t)randomInRangeLo:(u_int32_t)loBound toHi:(u_int32_t)hiBound {
    int32_t   range = hiBound - loBound + 1;
    return loBound + arc4random_uniform(range);
}


+ (NSString *)pathForDocuments{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return paths[0];
}

+ (void) showAllNamesForFont:(NSString *)fontName{
    NSLog(@"Names = %@", [UIFont fontNamesForFamilyName:fontName]);
}

+ (NSString *)MD5HashOfString:(NSString *)string{
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    const char *input = [string UTF8String];
    CC_MD5(input, (int)[string length], result);
    string = [[NSString stringWithFormat: @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X", result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7], result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15]] lowercaseString];
    
    return string;
}

+ (UIImage *)imageFromImage:(UIImage *)targetImage withAlpha:(CGFloat)alpha {
    UIGraphicsBeginImageContextWithOptions(targetImage.size, NO, 0.0f);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect area = CGRectMake(0, 0, targetImage.size.width, targetImage.size.height);
    
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -area.size.height);
    
    CGContextSetBlendMode(ctx, kCGBlendModeMultiply);
    
    CGContextSetAlpha(ctx, alpha);
    
    CGContextDrawImage(ctx, area, targetImage.CGImage);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

+ (NSInteger)degreeForOrientation:(UIDeviceOrientation)inputOrientation{
    if (inputOrientation == UIDeviceOrientationPortrait) return 0;

    if (inputOrientation == UIDeviceOrientationPortraitUpsideDown) return 180;

    if (inputOrientation == UIDeviceOrientationLandscapeLeft) return 90;

    if (inputOrientation == UIDeviceOrientationLandscapeRight) return -90;

    return 0;
}

+ (void)customizeNavBar{
    [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"HelveticaNeue" size:17], NSFontAttributeName, [CBTFunctions colorFromHex:@"7ac13c"], NSForegroundColorAttributeName, nil];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-Medium" size:17], NSForegroundColorAttributeName: [CBTFunctions colorFromHex:@"black"]}];
    [UINavigationBar appearance].tintColor = [CBTFunctions colorFromHex:@"7ac13c"];
    [[UIBarButtonItem appearance] setTitleTextAttributes:attributes forState:UIControlStateNormal];
}

+ (UIImageView *)viewFromImageNamed:(NSString *)name{
    UIImageView *newImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:name]];
    return newImageView;
}

+ (UIImage *)filledImageFrom:(UIImage *)source withColor:(UIColor *)color{
    
    // begin a new image context, to draw our colored image onto with the right scale
    UIGraphicsBeginImageContextWithOptions(source.size, NO, [UIScreen mainScreen].scale);
    
    // get a reference to that context we created
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // set the fill color
    [color setFill];
    
    // translate/flip the graphics context (for transforming from CG* coords to UI* coords
    CGContextTranslateCTM(context, 0, source.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    CGContextSetBlendMode(context, kCGBlendModeColorBurn);
    CGRect rect = CGRectMake(0, 0, source.size.width, source.size.height);
    CGContextDrawImage(context, rect, source.CGImage);
    
    CGContextSetBlendMode(context, kCGBlendModeSourceIn);
    CGContextAddRect(context, rect);
    CGContextDrawPath(context,kCGPathFill);
    
    // generate a new UIImage from the graphics context we drew onto
    UIImage *coloredImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //return the color-burned image
    return coloredImg;
}

+ (NSString *)currentDeviceModel{
    NSString *deviceType;
    struct utsname systemInfo;
    uname(&systemInfo);
    return deviceType = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
}

+ (NSString *)currentDeviceExtendedModel{
    struct utsname systemInfo;
    uname(&systemInfo);
    
    NSString *modelName = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    NSString *machinename = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    NSString *modelnumber = @"Not listed";
    
    //Simulator
    if([modelName isEqualToString:@"i386"] || [modelName isEqualToString:@"x86_64"]) {
        modelName = @"iPhone Simulator";
        modelnumber = @"XXXXX";
        
    }
    
    //iPhone
    else if([modelName isEqualToString:@"iPhone1,1"]) {
        modelName = @"iPhone";
        modelnumber = @"A1203";
    }
    else if([modelName isEqualToString:@"iPhone1,2"]) {
        modelName = @"iPhone 3G";
        modelnumber = @"A1241/A1324";
    }
    else if([modelName isEqualToString:@"iPhone2,1"]) {
        modelName = @"iPhone 3GS";
        modelnumber = @"A1303/A1325";
    }
    else if([modelName isEqualToString:@"iPhone3,1"]) {
        modelName = @"iPhone 4 (GSM)";
        modelnumber = @"A1332";
    }
    else if([modelName isEqualToString:@"iPhone3,2"]) {
        modelName = @"iPhone 4 GSM Rev A";
        modelnumber = @"Not listed";
    }
    else if([modelName isEqualToString:@"iPhone3,3"]) {
        modelName = @"iPhone 4 (CDMA)";
        modelnumber = @"A1349";
    }
    else if([modelName isEqualToString:@"iPhone4,1"]) {
        modelName = @"iPhone 4S";
        modelnumber = @"A1387/A1431";
    }
    else if([modelName isEqualToString:@"iPhone5,1"]) {
        modelName = @"iPhone 5 (GSM)";
        modelnumber = @"A1428";
    }
    else if([modelName isEqualToString:@"iPhone5,2"]) {
        modelName = @"iPhone 5 (GSM+CDMA)";
        modelnumber = @"A1429/A1442";
    }
    else if([modelName isEqualToString:@"iPhone5,3"]) {
        modelName = @"iPhone 5c (GSM)";
        modelnumber = @"A1456/A1532";
    }
    else if([modelName isEqualToString:@"iPhone5,4"]) {
        modelName = @"iPhone 5c (GSM+CDMA)";
        modelnumber = @"A1507/A1516/A1526/A1529";
    }
    else if([modelName isEqualToString:@"iPhone6,1"]) {
        modelName = @"iPhone 5s (GSM)";
        modelnumber = @"A1433/A1533";
    }
    else if([modelName isEqualToString:@"iPhone6,2"]) {
        modelName = @"iPhone 5s (GSM+CDMA)";
        modelnumber = @"A1457/A1518/A1528/A1530";
    }
    
    else if([modelName isEqualToString:@"iPhone7,1"]) {
        modelName = @"iPhone 6 Plus (GSM+CDMA)";
        modelnumber = @"A1522/A1524/A1593";
    }
    
    else if([modelName isEqualToString:@"iPhone7,2"]) {
        modelName = @"iPhone 6 (GSM+CDMA)";
        modelnumber = @"A1586/A1589/A1549";
    }
    
    //iPod touch
    else if([modelName isEqualToString:@"iPod1,1"]) {
        modelName = @"iPod touch 1G";
        modelnumber = @"A1213";
    }
    else if([modelName isEqualToString:@"iPod2,1"]) {
        modelName = @"iPod touch 2G";
        modelnumber = @"A1288";
    }
    else if([modelName isEqualToString:@"iPod3,1"]) {
        modelName = @"iPod touch 3G";
        modelnumber = @"A1318";
    }
    else if([modelName isEqualToString:@"iPod4,1"]) {
        modelName = @"iPod touch 4G";
        modelnumber = @"A1367";
    }
    else if([modelName isEqualToString:@"iPod5,1"]) {
        modelName = @"iPod touch 5G";
        modelnumber = @"A1421";
    }
    
    //iPad
    else if([modelName isEqualToString:@"iPad1,1"]) {
        modelName = @"iPad 1G";
        modelnumber = @"A1219/A1337";
    }
    else if([modelName isEqualToString:@"iPad2,1"]) {
        modelName = @"iPad 2 (WiFi)";
        modelnumber = @"A1395";
    }
    else if([modelName isEqualToString:@"iPad2,2"]) {
        modelName = @"iPad 2 (GSM)";
        modelnumber = @"A1396";
    }
    else if([modelName isEqualToString:@"iPad2,3"]) {
        modelName = @"iPad 2 (CDMA)";
        modelnumber = @"A1397";
    }
    else if([modelName isEqualToString:@"iPad2,4"]) {
        modelName = @"iPad 2 (WiFi + Rev A)";
        modelnumber = @"A1395";
    }
    else if([modelName isEqualToString:@"iPad3,1"]) {
        modelName = @"iPad 3 (WiFi)";
        modelnumber = @"A1416";
    }
    else if([modelName isEqualToString:@"iPad3,2"]) {
        modelName = @"iPad 3 (GSM+CDMA)";
        modelnumber = @"A1403";
    }
    else if([modelName isEqualToString:@"iPad3,3"]) {
        modelName = @"iPad 3 (GSM)";
        modelnumber = @"A1430";
    }
    else if([modelName isEqualToString:@"iPad3,4"]) {
        modelName = @"iPad 4 (WiFi)";
        modelnumber = @"A1458";
    }
    else if([modelName isEqualToString:@"iPad3,5"]) {
        modelName = @"iPad 4 (GSM)";
        modelnumber = @"A1459";
    }
    else if([modelName isEqualToString:@"iPad3,6"]) {
        modelName = @"iPad 4 (GSM+CDMA)";
        modelnumber = @"A1460";
    }
    
    //iPad Air
    else if([modelName isEqualToString:@"iPad4,1"]) {
        modelName = @"iPad Air (WiFi)";
        modelnumber = @"A1474";
    }
    else if([modelName isEqualToString:@"iPad4,2"]) {
        modelName = @"iPad Air (GSM)";
        modelnumber = @"A1475";
    }
    else if([modelName isEqualToString:@"iPad4,3"]) {
        modelName = @"iPad Air (GSM+CDMA)";
        modelnumber = @"A1476";
    }
    
    //iPad Air 2
    else if([modelName isEqualToString:@"iPad5,3"]) {
        modelName = @"iPad Air 2 (Wi-Fi)";
        modelnumber = @"A1566";
    }
    
    else if([modelName isEqualToString:@"iPad5,4"]) {
        modelName = @"iPad Air 2 (Wi-Fi + Cellular)";
        modelnumber = @"A1567";
    }
    
    //iPad mini
    else if([modelName isEqualToString:@"iPad2,5"]) {
        modelName = @"iPad mini (WiFi)";
        modelnumber = @"A1432";
    }
    else if([modelName isEqualToString:@"iPad2,6"]) {
        modelName = @"iPad mini (GSM)";
        modelnumber = @"A1454";
    }
    else if([modelName isEqualToString:@"iPad2,7"]) {
        modelName = @"iPad mini (GSM+CDMA)";
        modelnumber = @"A1455";
    }
    
    //iPad mini 2
    else if([modelName isEqualToString:@"iPad4,4"]) {
        modelName = @"iPad mini with Retina Display (WiFi)";
        modelnumber = @"A1489";
    }
    
    else if([modelName isEqualToString:@"iPad4,5"]) {
        modelName = @"iPad mini with Retina Display (GSM)";
        modelnumber = @"A1490";
    }
    
    else if([modelName isEqualToString:@"iPad4,6"]) {
        modelName = @"iPad mini with Retina Display (GSM+CDMA)";
        modelnumber = @"A1491";
    }
    
    //iPad mini 3
    else if([modelName isEqualToString:@"iPad4,7"]) {
        modelName = @"iPad mini 3 (Wi-Fi)";
        modelnumber = @"A1599";
    }
    
    else if([modelName isEqualToString:@"iPad4,8"]) {
        modelName = @"iPad mini 3 (Wi-Fi + Cellular)";
        modelnumber = @"A1600";
    }
    
    //Apple TV, just for fun:)
    else if([modelName isEqualToString:@"AppleTV2,1"]) {
        modelName = @"Apple TV 2G";
        modelnumber = @"A1378";
    }
    else if([modelName isEqualToString:@"AppleTV3,1"]) {
        modelName = @"Apple TV 3G";
        modelnumber = @"A1427";
    }
    else if([modelName isEqualToString:@"AppleTV3,2"]) {
        modelName = @"Apple TV 3G (Rev A)";
        modelnumber = @"A1469";
    }
    
    return [NSString stringWithFormat:@"Device model - %@, %@, %@.", modelName, machinename, modelnumber];
}

#pragma mark -
#pragma mark ==========НАСТРОЙКИ==========
//##################################################//
//                                                  //
//                    НАСТРОЙКИ                     //
//                                                  //
//##################################################//

+ (NSString *) apiHostName{
    return @"https://api.flipcupstudios.com/CameraAppTemplate/v1/";
}

+ (NSString *) apiHostNameShort{
    return @"http://app.beswaggy.com:8080/";
}

+ (UIColor *) backgroundColor{
    return [CBTFunctions colorFromHex:@"#fffeef" withAlpha:1.0f];
}

//--------------------------------------------------//

#pragma mark -
#pragma mark ==========ДРУГОЕ==========
//##################################################//
//                                                  //
//                      ДРУГОЕ                      //
//                                                  //
//##################################################//

+ (NSString *)dateStringFromTimestampString:(NSString *)dateStr{
    //Формат даты для сравнения
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[dateStr intValue]];
    
    NSString *tmpDate = [dateFormat stringFromDate:[NSDate dateWithTimeIntervalSince1970:[dateStr intValue]]];
    NSString *today = [dateFormat stringFromDate:[NSDate date]];
    
    NSDateFormatter *dateFormatResult = [[NSDateFormatter alloc] init];
    
    if ([tmpDate isEqualToString:today]){
        [dateFormatResult setDateFormat:@"HH:mm"];
        
        return [dateFormatResult stringFromDate:date];
    }else{
        [dateFormatResult setDateFormat:@"MM"];
        
        if ([[dateFormatResult stringFromDate:date] isEqualToString:[dateFormatResult stringFromDate:[NSDate date]]]){
            [dateFormatResult setDateFormat:@"dd MMMM"];
            return [dateFormatResult stringFromDate:date];
        }else{
            [dateFormatResult setDateFormat:@"dd.MM.yy"];
            return [dateFormatResult stringFromDate:date];
        }
    }
}
@end

#pragma mark - UIView
@implementation UIView (Frame)
- (float)height{
    return self.frame.size.height;
}

- (float)width{
    return self.frame.size.width;
}

- (float)x{
    return self.frame.origin.x;
}

- (float)y{
    return self.frame.origin.y;
}

- (CGSize)size{
    return self.frame.size;
}

- (CGPoint)origin{
    return self.frame.origin;
}

- (void)setWidth:(float)width{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, width, self.frame.size.height);
}

- (void)setHeight:(float)height{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, height);
}

- (void)setX:(float)x{
    self.frame = CGRectMake(x, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
}

- (void)setY:(float)y{
    self.frame = CGRectMake(self.frame.origin.x, y,  self.frame.size.width, self.frame.size.height);
}

- (void)setSize:(CGSize)size{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, size.width, size.height);
}

- (void)setOrigin:(CGPoint)origin{
    self.frame = CGRectMake(origin.x, origin.y, self.frame.size.width, self.frame.size.height);
}

- (void)removeSubviewsOfClass:(Class)cls{
    for (UIView * sub in [self subviews]){
        if ([sub isKindOfClass:cls])
            [sub removeFromSuperview];
    }
}

- (void)removeSubviewsRecursively{
    for (UIView * sub in [self subviews]){
        [sub removeSubviewsRecursively];
        [sub removeFromSuperview];
    }
}

- (void) removeSubviews{
	for (UIView *subView in self.subviews){
		[subView removeFromSuperview];
	}
}
@end

#pragma mark - UIFont
@implementation UIFont (CBTFunctions)
+ (void) showAllFontsWithName:(NSString *)fontName{
    NSLog(@"Names = %@", [UIFont fontNamesForFamilyName:fontName]);
}


@end