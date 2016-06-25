//
//  SHDCameraManager.h
//  CameraAppTemplate
//
//  Created by Sergey Grischyov on 07.03.16.
//  Copyright © 2016 ShadeApps. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SHDCameraUtilityDelegate;

@interface SHDCameraUtility : NSObject

@property (nonatomic, weak) id <SHDCameraUtilityDelegate>delegate;

- (instancetype)initWithView:(UIView *)sourceView andDelegate:(id)delegate NS_DESIGNATED_INITIALIZER;
- (void)finalizeLoadWithView:(UIView *)sourceView;

- (void)switchCameraPosition;
- (void)switchFlash;

- (void)touchDown;
- (void)touchUp;

- (void)selfDestruct;

@end

@protocol SHDCameraUtilityDelegate <NSObject>
@optional

- (void)cameraUtilityDidStartVideoOutput:(NSError *)error;
- (void)cameraUtilityDidTakePhoto:(UIImage *)photo;

@end