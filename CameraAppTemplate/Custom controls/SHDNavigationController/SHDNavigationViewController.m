//
//  SHDNavigationViewController.m
//  timewebmail
//
//  Created by Sergey Grischyov on 15.07.15.
//  Copyright (c) 2015 ShadeApps. All rights reserved.
//

#import "SHDNavigationViewController.h"

@interface SHDNavigationViewController ()

@end

@implementation SHDNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (BOOL)shouldAutorotate
{
    return self.topViewController.shouldAutorotate;
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return self.topViewController.supportedInterfaceOrientations;
}
@end
