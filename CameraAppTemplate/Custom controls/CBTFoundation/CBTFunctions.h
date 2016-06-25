//  SGFunctions.h
//
//  Created by Sergey Grischyov on 14.06.12.
//  Copyright (c) 2014 ShadeApps. All rights reserved.
//

#define IS_IOS_8 ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0)

#define COMMENT_KEY @"message key"
#define EVENT_KEY @"messages key"
#define COOKIE_KEY @"KCOOKIEKEY"
#define USER_KEY @"USER_ID"
#define LOCALE_KEY @"LOCALE"
#define ERROR_KEY @"error"

@interface CBTFunctions : NSObject{}

#pragma mark -
#pragma mark ==========КАСТОМИЗАЦИЯ==========
//-------------------Кастомизация------------------//
#pragma mark - UILabel

/**
 Creates new UILabel with a set of given params with no shadow

 @param fontName @c NSString value of a font name
 @param fontSize @c CGSize value of UIlabel's font size
 @return A newly created UILabel with right set parametrs and a correct @c CGSize
 */
+ (UILabel *)labelWithFontName:(NSString *)fontName fontSize:(float)fontSize fontColor:(NSString *)fontColor andDefaultText:(NSString *)text;

/**
 Creates new UILabel with a set of given params with a shadow and shadow offset
 
 @param fontName @c NSString value of a font name
 @param fontSize @c CGSize value of UIlabel's font size
 @return A newly created UILabel with right set parametrs with a shadow and shadow offset and a correct @c CGSize
 */
+ (UILabel *)labelWithFontName:(NSString *)fontName fontSize:(float)fontSize fontColor:(NSString *)fontColor shadowOffset:(CGSize)shadowOffset shadowColor:(NSString *)shadowColor andDefaultText:(NSString *)text;

#pragma mark - UITextField
#pragma mark ---Текстовое поле из одной картинки---

/**
 Creates new UITextField with a set of given params with only one image as a background
 
 @param imageName @c NSString value of UIImage name
 @param leftMargin @c float value of a left input margin
 @param fontName @c NSString value of a font name
 @param fontSize @c CGSize value of UITextField's font size
 @return A newly created UITextField with right set parametrs with a background image a correct @c CGSize
 */
+ (UITextField *)textFieldWithImageNamed:(NSString *)imageName margin:(float)leftMargin fontName:(NSString *)fontName fontSize:(float)fontSize fontColor:(NSString *)fontColor andPlaceholder:(NSString *)placeholder;

#pragma mark ---Текстовое поле из трех картинок---

/**
 Creates new UITextField with a set of given params with three custom images as a background
 
 @param width @c controls the width of the input field
 @param leftMargin @c float value of a left input margin
 @param fontName @c NSString value of a font name
 @param fontSize @c CGSize value of UITextField's font size
 @return A newly created UITextField with right set parametrs with a background image out of three images with a correct @c CGSize
 */
+ (UITextField *)textFieldWithLeftImageNamed:(NSString *)leftImageName middleImageNamed:(NSString *)middleImageName rightImageNamed:(NSString *)rightImageName fieldWidth:(float)width margin:(float)leftMargin fontName:(NSString *)fontName fontSize:(float)fontSize fontColor:(NSString *)fontColor andPlaceholder:(NSString *)placeholder;


#pragma mark - UIButton

#pragma mark ---Кнопка из одной картинки---

/**
 Creates new UIButton with custom image as a background and no text
 
 @param normalImageName @c NSString value of UIImage name
 @return A newly created UIButton with right set parametrs with a background image and correct @c CGSize
 */
+ (UIButton *)buttonWithImageNamed:(NSString *)normalImageName target:(id)target selector:(SEL)selector;

/**
 Creates new UIButton with custom image as a background and a highlightedImage and no text
 
 @param normalImageName @c NSString value of UIImage name
 @param highlightedImageName @c NSString value of highlighted UIImage name
 @return A newly created UIButton with right set parametrs with a background image and a highlightedImage and correct @c CGSize
 */
+ (UIButton *)buttonWithImageNamed:(NSString *)normalImageName highlightedImageName:(NSString *)highlightedImageName target:(id)target selector:(SEL)selector;

/**
 Creates new UIButton with custom image as a background and a highlightedImage and text with predefined params
 
 @param normalImageName @c NSString value of UIImage name
 @param highlightedImageName @c NSString value of highlighted UIImage name
 @param fontName @c NSString value of a font name
 @param fontSize @c CGSize value of UIButton title font size
 @param text @C NSString text of UIButton
 @return A newly created UIButton with right set parametrs with a background image and correct @c CGSize
 */
+ (UIButton *)buttonWithImageNamed:(NSString *)normalImageName highlightedImageName:(NSString *)highlightedImageName fontName:(NSString *)fontName fontSize:(float)fontSize fontColor:(NSString *)fontColor buttonText:(NSString *)text target:(id)target selector:(SEL)selector;

/**
 Creates new UIButton with custom image as a background and a highlightedImage and text with predefined params and text shadow
 
 @param normalImageName @c NSString value of UIImage name
 @param highlightedImageName @c NSString value of highlighted UIImage name
 @param fontName @c NSString value of a font name
 @param fontSize @c CGSize value of UIButton title font size
 @param text @c NSString text of UIButton
 @param shadowColor @c Hex value of shadow color
 @return A newly created UIButton with right set parametrs with a background image and correct @c CGSize
 */
+ (UIButton *)buttonWithImageNamed:(NSString *)normalImageName highlightedImageName:(NSString *)highlightedImageName fontName:(NSString *)fontName fontSize:(float)fontSize fontColor:(NSString *)fontColor buttonText:(NSString *)text shadowColor:(NSString *)shadowColor shadowOffset:(CGSize)shadowOffset target:(id)target selector:(SEL)selector;

/**
 Creates new UIButton with custom image as a background and a highlightedImage and text with predefined params and text shadow
 
 @param normalImageName @c NSString value of UIImage name
 @param highlightedImageName @c NSString value of highlighted UIImage name
 @param fontName @c NSString value of a font name
 @param fontSize @c CGSize value of UIButton title font size
 @param text @c NSString text of UIButton
 @param shadowColor @c Hex value of shadow color
 @return A newly created UIButton with right set parametrs with a background image and correct @c CGSize
 */
+ (UIButton *)buttonWithImageNamed:(NSString *)normalImageName highlightedImageName:(NSString *)highlightedImageName labelLeftMargin:(float)labelLeftMargin fontName:(NSString *)fontName fontSize:(float)fontSize fontColor:(NSString *)fontColor buttonText:(NSString *)text shadowColor:(UIColor *)shadowColor shadowOffset:(CGSize)shadowOffset target:(id)target selector:(SEL)selector;

#pragma mark ---Кнопка из трех картинок---

/**
 Creates new UIButton with custom width and three images image as a background icon image and text with predefined params
 
 @param fontName @c NSString value of a font name
 @param fontSize @c CGSize value of UIButton title font size
 @param text @c NSString text of UIButton
 @return A newly created UIButton with right set parametrs with a background image and correct @c CGSize
 */
+ (UIButton *)buttonWithMinWidth:(float)minWidth leftImageNamed:(NSString *)leftImageName middleImageNamed:(NSString *)middleImageName rightImageNamed:(NSString *)rightImageName imageShadow:(float)shadow iconImageNamed:(NSString *)iconImageName fontName:(NSString *)fontName fontSize:(float)fontSize fontColor:(NSString *)fontColor buttonText:(NSString *)text target:(id)target selector:(SEL)selector;

/**
 Creates new UIButton with custom width and three images image as a background icon image and text with predefined params and text shadow
 
 @param fontName @c NSString value of a font name
 @param fontSize @c CGSize value of UIButton title font size
 @param text @c NSString text of UIButton
 @return A newly created UIButton with right set parametrs with a background image and correct @c CGSize
 */
+ (UIButton *)buttonWithMinWidth:(float)minWidth leftImageNamed:(NSString *)leftImageName middleImageNamed:(NSString *)middleImageName rightImageNamed:(NSString *)rightImageName imageShadow:(float)shadow iconImageNamed:(NSString *)iconImageName fontName:(NSString *)fontName fontSize:(float)fontSize fontColor:(NSString *)fontColor buttonText:(NSString *)text shadowColor:(NSString *)shadowColor shadowOffset:(CGSize)shadowOffset target:(id)target selector:(SEL)selector;

#pragma mark ---Кнопка вместо ячеек таблицы---
+ (UIButton *)createCellLikeButtonWithImageNamed:(NSString *)imageName leftMargin:(float)leftMargin fontName:(NSString *)fontName fontSize:(float)fontSize fontColor:(NSString *)fontColor buttonText:(NSString *)text target:(id)target selector:(SEL)selector;
+ (UIButton *)createCellLikeButtonWithImageNamed:(NSString *)imageName leftMargin:(float)leftMargin fontName:(NSString *)fontName fontSize:(float)fontSize fontColor:(NSString *)fontColor buttonText:(NSString *)text shadowColor:(NSString *)shadowColor shadowOffset:(CGSize)shadowOffset target:(id)target selector:(SEL)selector;

#pragma mark ---Кастомизация существующей кнопки---
+ (void) remakeButton:(UIButton *)tmpButton setBothImagesNamed:(NSString *)imageName;
+ (void) remakeButton:(UIButton *)tmpButton setBothImagesNamed:(NSString *)imageName andTitle:(NSString *)newTitle;

#pragma mark - UINavigationBar
+ (UINavigationBar *)createNavigationBarWithImageNamed:(NSString *)imageName;
+ (UINavigationBar *)createNavigationBarWithImageNamed:(NSString *)imageName andTitle:(NSString *)title;
+ (UINavigationBar *)createNavigationBarWithImageNamed:(NSString *)imageName shadowImageNamed:(NSString *)shadowImageNamed andTitle:(NSString *)title;


#pragma mark - UIBarButtonItem
+ (UIBarButtonItem *)createBarButtonItemWithImageNamed:(NSString *)imageName target:(id)target selector:(SEL)selector;
+ (UIBarButtonItem *)createBarButtonItemWithImageNamed:(NSString *)imageName buttonText:(NSString *)text target:(id)target selector:(SEL)selector;
+ (UIBarButtonItem *)createBarButtonItemWithImageNamed:(NSString *)imageName fontName:(NSString *)fontName fontSize:(float)fontSize fontColor:(NSString *)fontColor buttonText:(NSString *)text target:(id)target selector:(SEL)selector;
+ (UIBarButtonItem *)createBarButtonItemWithImageNamed:(NSString *)imageName fontName:(NSString *)fontName fontSize:(float)fontSize fontColor:(NSString *)fontColor buttonText:(NSString *)text shadowColor:(NSString *)shadowColor shadowOffset:(CGSize)shadowOffset target:(id)target selector:(SEL)selector;
+ (void) changeTitleAtCustomizedBarButtonItem:(UIBarButtonItem *)barButton toNew:(NSString *)newTitle;
//--------------------------------------------------//

#pragma mark -
#pragma mark ==========ДОПОЛНИТЕЛЬНЫЕ ФУНКЦИИ==========
//--------------Дополнительные функции--------------//

#pragma mark - UIColor

+ (UIColor *)colorFromHex:(NSString*)stringColor;
+ (UIColor *)colorFromHex:(NSString*)stringColor withAlpha:(float)alpha;

#pragma mark - OS Version and Locale

+ (int) systemVersion;
+ (NSString *)getCurrentLocale;
+ (NSString *)getCurrentRegion;

#pragma mark - Showing Alerts and Controling Notifications

+ (void) showAlertWithTitle:(NSString *)title andText:(NSString *)text;
+ (void) showNoWiFiAlert;
+ (void) showOfflineModeAlert;
+ (void) showNoConnectionAlert;
+ (void) showWrongEmailAlert;
+ (void) showGeneralLoginErrorAlert;
+ (void) showWrongPassLoginErrorAlert;

+ (void) stopUserInteraction;
+ (void) startUserInteraction;

+ (void) showNetworkActivityIndicator;
+ (void) hideNetworkActivityIndicator;

#pragma mark - Device specific values

+ (BOOL)isiPhone4;

+ (BOOL) isiPhone4S;

//Sorry for those

//iPhone 4,4S,5,5C,5S
+ (BOOL) isRetina3_5or4Inch;

+ (BOOL) isRetina3_5Inch;

//iPhone 5
+ (BOOL) isRetina4Inch;

//iPhone 6
+ (BOOL)isRetina4_7Inch;

//iPhone 6 Plus
+ (BOOL)isRetina5_5Inch;

#pragma mark - Working with images

+ (UIImage *)iPhone5ImageNamed:(NSString *)imageName;

+ (UIImage *)imageFromImage:(UIImage *)targetImage withAlpha:(CGFloat)alpha;

+ (UIImageView *)viewFromImageNamed:(NSString *)name;

+ (UIImage *)filledImageFrom:(UIImage *)source withColor:(UIColor *)color;

#pragma mark - Strings, random ints and etc.

+ (NSString *)currentDeviceModel;

+ (NSString *)currentDeviceExtendedModel;

+ (BOOL)isValidEmail:(NSString *)checkString;

+ (u_int32_t)randomInRangeLo:(u_int32_t)loBound toHi:(u_int32_t)hiBound;

+ (NSString *)pathForDocuments;

+ (void) showAllNamesForFont:(NSString *)fontName;

+ (NSString *)MD5HashOfString:(NSString *)string;

+ (void)customizeNavBar;

+ (NSInteger)degreeForOrientation:(UIDeviceOrientation)inputOrientation;

//--------------------------------------------------//

#pragma mark -
#pragma mark ==========НАСТРОЙКИ==========
//--------------------Настройки---------------------//
+ (NSString *)apiHostName;
+ (NSString *)apiHostNameShort;
+ (UIColor *)backgroundColor;
//--------------------------------------------------//

#pragma mark -
#pragma mark ==========ДРУГОЕ==========
//----------------------Другое----------------------//
+ (NSString *)dateStringFromTimestampString:(NSString *)dateStr;
//--------------------------------------------------//

@end

//UPDATE 2.0

#pragma mark - UIView
@interface UIView (Frame)
@property (nonatomic, assign) float width;
@property (nonatomic, assign) float height;
@property (nonatomic, assign) float x;
@property (nonatomic, assign) float y;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;
- (void) removeSubviews;
- (void) removeSubviewsRecursively;
- (void) removeSubviewsOfClass:(Class)cls;
@end

#pragma mark - UIFont
@interface UIFont (CBTFunctions)
+ (void) showAllFontsWithName:(NSString *)fontName;
@end
