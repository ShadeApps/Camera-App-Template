//
//  ViewController.m
//  CameraAppTemplate
//
//  Created by Sergey Grischyov on 17.02.16.
//  Copyright © 2016 ShadeApps. All rights reserved.
//

#import "SHDIntroViewController.h"
#import "SMPageControl.h"
#import "EAIntroView.h"
//CustomViews
#import "SHDIntroFirstPageView.h"
#import "SHDIntroSecondPageView.h"
#import "SHDIntroThirdPageView.h"

const CGFloat kButtonSide = 70.0;
const CGFloat kAnimatedThirdImgValue = 350.0;

@interface SHDIntroViewController ()<EAIntroDelegate, UITextFieldDelegate, UIGestureRecognizerDelegate>

@property (strong, nonatomic) EAIntroView *introView;
@property (weak, nonatomic) IBOutlet UIView *navBarContainerView;
@property (weak, nonatomic) IBOutlet UIImageView *imgBottomShadowView;
@property (weak, nonatomic) IBOutlet UIButton *btnOK;

@end

@implementation SHDIntroViewController{
    SHDIntroFirstPageView *firstPageView;
    SHDIntroSecondPageView *secondPageView;
    SHDIntroThirdPageView *thirdPageView;
    SMPageControl *pageControl;
    UIButton *btnSkip;
    UIButton *btnNext;
    NSUInteger currentPageIndex;
    CGFloat currentKeyboardHeight;
    CGFloat defaultFrameContainerViewTopConstraintValue;
}

- (BOOL)shouldAutorotate{
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self turnOnKeyboardTracking:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self turnOnKeyboardTracking:NO];
// Enable iOS 7 back gesture
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
// Disable iOS 7 back gesture
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUIElements];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    return NO;
}

#pragma mark - Button Actions

- (void)btnNextTapped{
    if (currentPageIndex == 1){
        [self btnSkipTapped];
        return;
    }
    [self.introView setCurrentPageIndex:++currentPageIndex animated:YES];
}
- (void)btnSkipTapped{
    currentPageIndex = 1;
    [self.introView hideWithFadeOutDuration:kRotationAnimationDuration];
}


- (IBAction)btnOKTapped:(id)sender{
    if ([thirdPageView.txtUsernameField.text stringByReplacingOccurrencesOfString:@" " withString:@""].length < 2){
        [CBTFunctions showAlertWithTitle:@"Error" andText:@"Please, fill in your name to continue"];
    }else{
        [thirdPageView.txtUsernameField resignFirstResponder];
        [self.view endEditing:YES];
        [SHDDefaultsUtility setSavedValue:@YES forKey:kSeenTutorialKey];
        AppDelegate *appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [appDel.window setRootViewController:[[UIStoryboard storyboardWithName:kCameraStoryboardName bundle:nil] instantiateInitialViewController]];
    }
}

#pragma mark - Keyboard Mngmnt On/Off & Text Field Mngmnt

- (void)turnOnKeyboardTracking:(BOOL)isOn{
    if (isOn){
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    }else{
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField == thirdPageView.txtUsernameField){
        [thirdPageView.txtUsernameField resignFirstResponder];
        [self btnOKTapped:nil];
    }
    
    return YES;
}

#pragma mark - Keyboard Methods & Hiding keyboard
//1st Step
- (void)keyboardWillShow:(NSNotification *)notification{
    [self animateKeyboardWithDuration:[[[notification userInfo] objectForKey: UIKeyboardAnimationDurationUserInfoKey] floatValue] frame:[[[notification userInfo]objectForKey:UIKeyboardFrameEndUserInfoKey]CGRectValue] options:[[notification userInfo][UIKeyboardAnimationCurveUserInfoKey] integerValue]<<16];
}

- (void)keyboardWillHide:(NSNotification *)notification{
    [self animateKeyboardWithDuration:[[[notification userInfo] objectForKey: UIKeyboardAnimationDurationUserInfoKey] floatValue] frame:CGRectZero options:[[notification userInfo][UIKeyboardAnimationCurveUserInfoKey] integerValue]<<16];
}

- (void)keyboardWillChangeFrame:(NSNotification *)notification{
    [self animateKeyboardWithDuration:[[[notification userInfo] objectForKey: UIKeyboardAnimationDurationUserInfoKey] floatValue] frame:[[[notification userInfo]objectForKey:UIKeyboardFrameEndUserInfoKey]CGRectValue] options:[[notification userInfo][UIKeyboardAnimationCurveUserInfoKey] integerValue]<<16];
}

//2nd Step
- (void)animateKeyboardWithDuration:(CGFloat)duration frame:(CGRect)keyboardFrame options:(UIViewAnimationOptions)animOptions{
    currentKeyboardHeight = keyboardFrame.size.height;
    if (currentKeyboardHeight == 0){
        [UIView animateWithDuration:duration delay:0 options:(animOptions | UIViewAnimationOptionBeginFromCurrentState) animations:^{
            thirdPageView.imgFrameContainerViewTopConstraint.constant = defaultFrameContainerViewTopConstraintValue;
            thirdPageView.imgFrameContainerView.alpha = 1.0;
            [self.view layoutIfNeeded];
        }completion:nil];
    }else{
        [UIView animateWithDuration:duration / 2 delay:0 options:(animOptions | UIViewAnimationOptionBeginFromCurrentState) animations:^{
            thirdPageView.imgFrameContainerViewTopConstraint.constant = -kAnimatedThirdImgValue;
            thirdPageView.imgFrameContainerView.alpha = 0.0;
            [self.view layoutIfNeeded];
        }completion:nil];
    }
}

//Keyboard Dismissal
- (void)dismissGestureRecognized:(id)sender {
    [self.view endEditing:YES];
}

#pragma mark - UI Setup
- (void)setupUIElements{
    thirdPageView = [SHDIntroThirdPageView new];
    thirdPageView.txtUsernameField.delegate = self;
    defaultFrameContainerViewTopConstraintValue = thirdPageView.imgFrameContainerViewTopConstraint.constant;
    thirdPageView.frame = self.view.bounds;
    [self.view addSubview:thirdPageView];
    [self.view bringSubviewToFront:self.btnOK];
//Adding Gesture Recognizer
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissGestureRecognized:)];
    [self.view addGestureRecognizer:tapGesture];
    
//PageControll
    pageControl = [[SMPageControl alloc] init];
    pageControl.pageIndicatorImage = [UIImage imageNamed:@"imgPageDot"];
    pageControl.currentPageIndicatorImage = [UIImage imageNamed:@"imgSelectedPageDot"];
    [pageControl sizeToFit];
    
//Intro Pages
    firstPageView = [SHDIntroFirstPageView new];
    secondPageView = [SHDIntroSecondPageView new];
        EAIntroPage *page1 = [EAIntroPage pageWithCustomView:firstPageView];
    page1.bgImage = [UIImage imageNamed:@"imgIntroBackground1"];
    EAIntroPage *page2 = [EAIntroPage pageWithCustomView:secondPageView];
    page2.bgImage = [UIImage imageNamed:@"imgIntroBackground2"];
    self.introView = [[EAIntroView alloc] initWithFrame:self.view.bounds andPages:@[page1,page2]];
    currentPageIndex = 0;
    self.introView.skipButton = nil;
    self.introView.pageControl = (UIPageControl *)pageControl;
    self.introView.pageControl.numberOfPages = 3;
    [self.introView setDelegate:self];
    self.introView.easeOutCrossDisolves = YES;
    [self.introView showInView:self.view animateDuration:kRotationAnimationDuration];
    [self.view bringSubviewToFront:self.navBarContainerView];
    [self.view bringSubviewToFront:self.imgBottomShadowView];
//Buttons
    btnSkip = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, kButtonSide, kButtonSide)];
    [btnSkip setTitle:@"SKIP" forState:UIControlStateNormal];
    [btnSkip addTarget:self action:@selector(btnSkipTapped) forControlEvents:UIControlEventTouchUpInside];
    btnSkip.titleLabel.font = [UIFont fontWithName:@"Lato-Bold" size:15.0];
    btnSkip.titleLabel.textColor = [UIColor whiteColor];
    [self.introView addSubview:btnSkip];
    btnSkip.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-40-[btnSkip(==70)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(btnSkip)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[btnSkip(==70)]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(btnSkip)]];
    
    btnNext = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, kButtonSide, kButtonSide)];
    [btnNext setTitle:@"NEXT" forState:UIControlStateNormal];
    [btnNext addTarget:self action:@selector(btnNextTapped) forControlEvents:UIControlEventTouchUpInside];
    btnNext.titleLabel.font = [UIFont fontWithName:@"Lato-Bold" size:15.0];
    btnNext.titleLabel.textColor = [UIColor whiteColor];
    [self.introView addSubview:btnNext];
    btnNext.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[btnNext(==70)]-40-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(btnNext)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[btnNext(==70)]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(btnNext)]];
}

#pragma mark - EAIntroDelegate
- (void)introDidFinish:(EAIntroView *)introView{
    [UIView animateKeyframesWithDuration:0.1 delay:0.00 options:UIViewKeyframeAnimationOptionBeginFromCurrentState |UIViewAnimationOptionCurveEaseIn animations:^{
        btnNext.alpha = btnSkip.alpha = self.imgBottomShadowView.alpha = 0.0;
    }completion:^(BOOL finished){
        [self.view bringSubviewToFront:self.btnOK];
    }];
}

@end
