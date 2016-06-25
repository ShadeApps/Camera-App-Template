//
//  SHDDefaultsUtility.h
//  CameraAppTemplate
//
//  Created by Sergey Grischyov on 12.08.14.
//  Copyright (c) 2014 ShadeApps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SHDDefaultsUtility : NSObject

+ (void)setSavedValue:(id)value forKey:(id)key;
+ (id)savedValueForKey:(id)key;

@end