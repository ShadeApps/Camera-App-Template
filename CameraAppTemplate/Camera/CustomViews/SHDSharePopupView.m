//
//  SHDSharePopupView.m
//  CameraAppTemplate
//
//  Created by Sergey Grischyov on 07.03.16.
//  Copyright © 2016 ShadeApps. All rights reserved.
//

#import "SHDSharePopupView.h"

@interface SHDSharePopupView ()
@property (weak, nonatomic) IBOutlet UIButton *btnDone;
@property (weak, nonatomic) IBOutlet UIView *photoSavedcontainerView;
@property (weak, nonatomic) IBOutlet UIView *shareContainerView;
@property (weak, nonatomic) IBOutlet UILabel *lblSharePrompt;

@end

@implementation SHDSharePopupView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self == nil) return nil;
    [self initalizeSubviews];
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self == nil) return nil;
    [self initalizeSubviews];
    return self;
}

- (void)initalizeSubviews{
    if (self.subviews.count == 0){
        NSString *nibName = NSStringFromClass([self class]);
        [[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil];
        self.bounds = self.container.bounds;
        [self addSubview:self.container];
        
        [self stretchToSuperView:self.container];
    }
}

- (void) stretchToSuperView:(UIView*) view {
    view.translatesAutoresizingMaskIntoConstraints = NO;
    NSDictionary *bindings = NSDictionaryOfVariableBindings(view);
    NSString *formatTemplate = @"%@:|[view]|";
    for (NSString * axis in @[@"H",@"V"]) {
        NSString * format = [NSString stringWithFormat:formatTemplate,axis];
        NSArray * constraints = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:nil views:bindings];
        [view.superview addConstraints:constraints];
    }
    [self.btnDone makeViewRoundWithLayerColor:nil andWidth:0.0 useHeight:YES];
}

- (void)displayShareTextWithName:(NSString *)name{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:kRotationAnimationDuration delay:0.0 usingSpringWithDamping:1.4 initialSpringVelocity:0.2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.photoSavedcontainerView.alpha = 0.0;
            self.shareContainerView.alpha = 1.0;
        }completion:nil];
    });
}

#pragma mark - Button Actions
- (IBAction)sharePopupBtnInstagramTapped:(id)sender{
    if ([self.delegate respondsToSelector:@selector(sharePopupBtnInstagramTapped:)] && self.delegate !=nil){
        [self.delegate sharePopupBtnInstagramTapped:self];
    }
}

- (IBAction)sharePopupBtnFBTapped:(id)sender{
    if ([self.delegate respondsToSelector:@selector(sharePopupBtnFBTapped:)] && self.delegate !=nil){
        [self.delegate sharePopupBtnFBTapped:self];
    }
}

- (IBAction)sharePopupBtnTwitterTapped:(id)sender{
    if ([self.delegate respondsToSelector:@selector(sharePopupBtnTwitterTapped:)] && self.delegate !=nil){
        [self.delegate sharePopupBtnTwitterTapped:self];
    }
}

- (IBAction)sharePopupBtniMessageTapped:(id)sender{
    if ([self.delegate respondsToSelector:@selector(sharePopupBtniMessageTapped:)] && self.delegate !=nil){
        [self.delegate sharePopupBtniMessageTapped:self];
    }
}
- (IBAction)sharePopupBtnEmailTapped:(id)sender{
    if ([self.delegate respondsToSelector:@selector(sharePopupBtnEmailTapped:)] && self.delegate !=nil){
        [self.delegate sharePopupBtnEmailTapped:self];
    }
}
- (IBAction)sharePopupBtnDoneTapped:(id)sender{
    if ([self.delegate respondsToSelector:@selector(sharePopupBtnDoneTapped:)] && self.delegate !=nil){
        [self.delegate sharePopupBtnDoneTapped:self];
    }
}

@end
