//
//  UILabel+Boldify.h
//  Swaggy
//
//  Created by Sergey Grischyov on 21.11.15.
//  Copyright © 2015 ShadeApps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Boldify)
- (void) boldSubstring: (NSString*) substring;
- (void) boldRange: (NSRange) range;
@end
