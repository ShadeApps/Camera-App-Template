//
//  UIView+roundLayer.m
//  Tagged.Pics
//
//  Created by Sergey Grischyov on 14.08.14.
//  Copyright (c) 2014 Cuberto. All rights reserved.
//

#import "UIView+roundLayer.h"

@implementation UIView (roundLayer)

- (void)makeViewRoundWithLayerColor:(UIColor *)color andWidth:(CGFloat)lineWidth{
    self.clipsToBounds = YES;
    self.layer.cornerRadius = self.frame.size.width/2;
    if (color) {
        self.layer.borderColor = color.CGColor;
    }
    
    if (lineWidth) {
        self.layer.borderWidth = lineWidth;
    }
}

- (void)makeViewRoundWithLayerColor:(UIColor *)color andWidth:(CGFloat)lineWidth useHeight:(BOOL)useH{
    self.clipsToBounds = YES;
    self.layer.cornerRadius = self.frame.size.height/2;
    if (color) {
        self.layer.borderColor = color.CGColor;
    }
    
    if (lineWidth) {
        self.layer.borderWidth = lineWidth;
    }
}

- (void)drawViewLayerWithLayerColor:(UIColor *)color andWidth:(CGFloat)lineWidth andCornerRadius:(CGFloat)radius{
    self.clipsToBounds = YES;
    self.layer.cornerRadius = radius;
    if (color) {
        self.layer.borderColor = color.CGColor;
    }
    
    if (lineWidth) {
        self.layer.borderWidth = lineWidth;
    }
}

@end
