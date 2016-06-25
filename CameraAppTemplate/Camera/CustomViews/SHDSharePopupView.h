//
//  SHDSharePopupView.h
//  CameraAppTemplate
//
//  Created by Sergey Grischyov on 07.03.16.
//  Copyright © 2016 ShadeApps. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SHDSharePopupView;

@protocol SHDSharePopupViewDelegate <NSObject>

@optional

//View Button actions
- (void)sharePopupBtnInstagramTapped:(SHDSharePopupView *)senderView;
- (void)sharePopupBtnFBTapped:(SHDSharePopupView *)senderView;
- (void)sharePopupBtnTwitterTapped:(SHDSharePopupView *)senderView;
- (void)sharePopupBtniMessageTapped:(SHDSharePopupView *)senderView;
- (void)sharePopupBtnEmailTapped:(SHDSharePopupView *)senderView;
- (void)sharePopupBtnDoneTapped:(SHDSharePopupView *)senderView;

@end

@interface SHDSharePopupView : UIView
@property (nonatomic, weak) id <SHDSharePopupViewDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIView *container;

- (void)displayShareTextWithName:(NSString *)name;

@end
