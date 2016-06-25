//
//  SHDDefaultsUtility.m
//  CameraAppTemplate
//
//  Created by Sergey Grischyov on 12.08.14.
//  Copyright (c) 2014 ShadeApps. All rights reserved.
//

#import "SHDDefaultsUtility.h"

@implementation SHDDefaultsUtility

+ (void)setSavedValue:(id)value forKey:(id)key{
    [[NSUserDefaults standardUserDefaults] setValue:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (id)savedValueForKey:(id)key{
    return [[NSUserDefaults standardUserDefaults] valueForKey:key];
}

@end