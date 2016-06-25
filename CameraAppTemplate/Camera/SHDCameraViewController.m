//
//  SHDCameraViewController.m
//  CameraAppTemplate
//
//  Created by Sergey Grischyov on 07.03.16.
//  Copyright © 2016 ShadeApps. All rights reserved.
//

#import "SHDCameraViewController.h"
#import "SHDCameraUtility.h"
#import "SHDPhotoPreviewViewController.h"

@interface SHDCameraViewController () <SHDCameraUtilityDelegate>
@property (weak, nonatomic) IBOutlet UIView *cameraParentView;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *rotatedElements;
@end

@implementation SHDCameraViewController{
    BOOL isOnScreen;
    SHDCameraUtility *cameraUtility;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    isOnScreen = YES;
    cameraUtility = [[SHDCameraUtility alloc] initWithView:_cameraParentView andDelegate:self];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [cameraUtility finalizeLoadWithView:_cameraParentView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    isOnScreen = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    isOnScreen = NO;
}

#pragma mark - Camera controls

- (IBAction)btnSwitchCameraTapped:(id)sender{
    [cameraUtility switchCameraPosition];
}

- (IBAction)btnSwitchFlashTapped:(id)sender{
    UIButton *button = sender;
    if (button.isSelected){
        button.selected = NO;
    }else{
        button.selected = YES;
    }
    [cameraUtility switchFlash];
}

- (IBAction)btnShootTouchedDown:(id)sender{
    [cameraUtility touchDown];
}

- (IBAction)btnShootTouchedLifted:(id)sender{
    [cameraUtility touchUp];
}
#pragma mark - Camera delegate

- (void)cameraUtilityDidStartVideoOutput:(NSError *)error{
    if (error) [CBTFunctions showAlertWithTitle:@"Error" andText:error.userInfo[@"description"]];
}

- (void)cameraUtilityDidTakePhoto:(UIImage *)photo{
    SHDPhotoPreviewViewController *photoPreviewVC = [[UIStoryboard storyboardWithName:kCameraStoryboardName bundle:nil] instantiateViewControllerWithIdentifier:@"photoPreviewVC"];
    photoPreviewVC.sourceImage = photo;
    [self presentViewController:photoPreviewVC animated:YES completion:nil];
}

@end