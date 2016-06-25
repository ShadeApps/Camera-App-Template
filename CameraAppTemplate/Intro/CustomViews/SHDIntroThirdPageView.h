//
//  SHDIntroThirdPageView.h
//  CameraAppTemplate
//
//  Created by Sergey Grischyov on 07.03.16.
//  Copyright © 2016 ShadeApps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SHDIntroThirdPageView : UIView
@property (weak, nonatomic) IBOutlet UIView *container;
@property (weak, nonatomic) IBOutlet UIView *imgFrameContainerView;
@property (weak, nonatomic) IBOutlet UITextField *txtUsernameField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgFrameContainerViewTopConstraint;

@end
