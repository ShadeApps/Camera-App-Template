//
//  AppDelegate.m
//  CameraAppTemplate
//
//  Created by Sergey Grischyov on 17.02.16.
//  Copyright © 2016 ShadeApps. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[UIApplication sharedApplication] setStatusBarHidden:YES];

    BOOL showCamera = [SHDDefaultsUtility savedValueForKey:kSeenTutorialKey];

    UIStoryboard *mainStroyboard = [UIStoryboard storyboardWithName:kIntroStoryboardName bundle:nil];
    UIViewController *tmpVC = [mainStroyboard instantiateInitialViewController];

    if (showCamera){
        mainStroyboard = [UIStoryboard storyboardWithName:kCameraStoryboardName bundle:nil];
        tmpVC = [mainStroyboard instantiateInitialViewController];
    }

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = tmpVC;
    [self.window makeKeyAndVisible];

    return YES;
}

@end