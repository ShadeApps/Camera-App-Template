//
//  UIView+roundLayer.h
//  Tagged.Pics
//
//  Created by Sergey Grischyov on 14.08.14.
//  Copyright (c) 2014 Cuberto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (roundLayer)

- (void)makeViewRoundWithLayerColor:(UIColor *)color andWidth:(CGFloat)lineWidth;

- (void)makeViewRoundWithLayerColor:(UIColor *)color andWidth:(CGFloat)lineWidth useHeight:(BOOL)useH;

- (void)drawViewLayerWithLayerColor:(UIColor *)color andWidth:(CGFloat)lineWidth andCornerRadius:(CGFloat)radius;

@end
