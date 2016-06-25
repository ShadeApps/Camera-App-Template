//
//  SHDPhotoPreviewViewController.m
//  CameraAppTemplate
//
//  Created by Sergey Grischyov on 07.03.16.
//  Copyright © 2016 ShadeApps. All rights reserved.
//

#import "SHDPhotoPreviewViewController.h"
#import "SHDSharePopupView.h"
#import <MessageUI/MessageUI.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <Social/Social.h>


//UI Constants
static const CGFloat kPopupViewHeight = 307.0;
@interface SHDPhotoPreviewViewController ()<SHDSharePopupViewDelegate, MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imgPreviewView;
@property (weak, nonatomic) IBOutlet UIView *buttonsContainerView;
@property (strong, nonatomic) CALayer *middleLineLayer;
@property (nonatomic, strong) UIDocumentInteractionController *documentController;

@end

@implementation SHDPhotoPreviewViewController{
    UIView *blackView;
    SHDSharePopupView *sharePopupView;
}

- (BOOL)shouldAutorotate{
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUIElements];
    _imgPreviewView.image = _sourceImage;
}

#pragma mark - Button Actions

- (IBAction)btnCancelTapped:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)btnAcceptTapped:(id)sender{
    UIImageWriteToSavedPhotosAlbum(_imgPreviewView.image, nil, nil, nil);
    if (!blackView.superview) [self.view insertSubview:blackView belowSubview:sharePopupView];
    [UIView animateWithDuration:0.3 delay:0.0 usingSpringWithDamping:1.4 initialSpringVelocity:0.2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        blackView.alpha = 1.0;
        sharePopupView.y = self.view.height - kPopupViewHeight;
    }completion:^(BOOL finished) {
        [sharePopupView displayShareTextWithName:@""];
    }];
}

- (void)setupUIElements{
    AppDelegate *appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    self.middleLineLayer = [self layerWithColor:[CBTFunctions colorFromHex:@"b0b0ac"]];
    if (!self.middleLineLayer.superlayer){
        self.middleLineLayer.frame = CGRectMake(appDel.window.width / 2 - 0.5, 0.0, 0.5, self.buttonsContainerView.height);
        [self.buttonsContainerView.layer addSublayer:self.middleLineLayer];
    }

    blackView = [[UIView alloc] initWithFrame:self.view.bounds];
    blackView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];

    sharePopupView = [SHDSharePopupView new];
    sharePopupView.x = 0;
    sharePopupView.y = appDel.window.height;
    sharePopupView.width = appDel.window.width;
    sharePopupView.height = kPopupViewHeight;
    sharePopupView.delegate = self;
    [self.view addSubview:sharePopupView];
}

#pragma mark - SHDSharePopupView delegate

- (void)sharePopupBtnInstagramTapped:(SHDSharePopupView *)senderView{
    NSURL *instagramURL = [NSURL URLWithString:@"instagram://app"];
    if([[UIApplication sharedApplication] canOpenURL:instagramURL]){
        UIImageView *imageMain = _imgPreviewView;
        CGFloat cropVal = (imageMain.image.size.height > imageMain.image.size.width ? imageMain.image.size.width : imageMain.image.size.height);

        cropVal *= [imageMain.image scale];

        CGRect cropRect = (CGRect){.size.height = cropVal, .size.width = cropVal};
        CGImageRef imageRef = CGImageCreateWithImageInRect([imageMain.image CGImage], cropRect);

        NSData *imageData = UIImageJPEGRepresentation([UIImage imageWithCGImage:imageRef], 1.0);
        CGImageRelease(imageRef);

        NSString *writePath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"instagram.igo"];
        if (![imageData writeToFile:writePath atomically:YES]) {
            // failure
            NSLog(@"image save failed to path %@", writePath);
            return;
        } else {
            // success.
        }

        // send it to instagram.
        NSURL *fileURL = [NSURL fileURLWithPath:writePath];
        self.documentController = [UIDocumentInteractionController interactionControllerWithURL:fileURL];
        [self.documentController setUTI:@"com.instagram.exclusivegram"];
        [self.documentController setAnnotation:@{@"InstagramCaption" : @"Check out this shot I made with CameraAppTemplate for iOS! #CameraAppTemplate #ShadeApps"}];
        [self.documentController presentOpenInMenuFromRect:CGRectMake(0, 0, 320, 480) inView:self.view animated:YES];
    }
}

- (void)sharePopupBtnFBTapped:(SHDSharePopupView *)senderView{
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]){
        SLComposeViewController *fbSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        [fbSheet addImage:_imgPreviewView.image];
        [fbSheet setInitialText:@"Check out this shot I made with CameraAppTemplate for iOS! #CameraAppTemplate #ShadeApps"];
        [self presentViewController:fbSheet animated:YES completion:nil];
    }
}

- (void)sharePopupBtnTwitterTapped:(SHDSharePopupView *)senderView{
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]){
        SLComposeViewController *tweetSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        [tweetSheet addImage:_imgPreviewView.image];
        [tweetSheet setInitialText:@"Check out this shot I made with CameraAppTemplate for iOS! #CameraAppTemplate #ShadeApps"];
        [self presentViewController:tweetSheet animated:YES completion:nil];
    }
}


- (void)sharePopupBtniMessageTapped:(SHDSharePopupView *)senderView{
    MFMessageComposeViewController* messageComposer = [[MFMessageComposeViewController alloc] init];
    messageComposer.messageComposeDelegate = self;
    if([MFMessageComposeViewController canSendText]){
        if([MFMessageComposeViewController respondsToSelector:@selector(canSendAttachments)] && [MFMessageComposeViewController canSendAttachments]){
            NSString* uti = (NSString*)kUTTypeMessage;
            NSData *jpegData = UIImageJPEGRepresentation(_imgPreviewView.image, 1.0);
            [messageComposer addAttachmentData:jpegData typeIdentifier:uti filename:@"filename.jpg"];
        }

        [self presentViewController:messageComposer animated:YES completion:nil];
    }
}

- (void)sharePopupBtnEmailTapped:(SHDSharePopupView *)senderView{
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *composeViewController = [[MFMailComposeViewController alloc] initWithNibName:nil bundle:nil];
        [composeViewController setMailComposeDelegate:self];
        [composeViewController setSubject:@"CameraAppTemplate for iOS"];
        NSString *htmlMsg = @"<html><body><p>Check out this shot I made with CameraAppTemplate for iOS! #CameraAppTemplate #ShadeApps</p></body></html>";

        NSData *jpegData = UIImageJPEGRepresentation(_imgPreviewView.image, 1.0);

        NSString *fileName = @"test";
        fileName = [fileName stringByAppendingPathExtension:@"jpeg"];
        [composeViewController addAttachmentData:jpegData mimeType:@"image/jpeg" fileName:fileName];
        [composeViewController setMessageBody:htmlMsg isHTML:YES];

        [self presentViewController:composeViewController animated:YES completion:nil];
    }
}

- (void)sharePopupBtnDoneTapped:(SHDSharePopupView *)senderView{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Generating Lines

- (CALayer *)layerWithColor:(UIColor *)color{
    CALayer *tmpLayer = [CALayer new];
    tmpLayer.backgroundColor = color.CGColor;
    tmpLayer.shouldRasterize = YES;
    tmpLayer.rasterizationScale = [[UIScreen mainScreen] scale];
    return tmpLayer;
}

#pragma mark - Email composer

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end