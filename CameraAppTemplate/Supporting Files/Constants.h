//
//  Constants.h
//  CameraAppTemplate
//
//  Created by Sergey Grischyov on 09.02.16.
//  Copyright © 2016 ShadeApps. All rights reserved.
//

#ifndef Constants_h

#define SHD_DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)
#define kRotationAnimationDuration 0.3

#define Constants_h

static NSString * const kDefaultBackgroundHex = @"F4F4F4";
static NSString * const kSelectedBackgroundHex = @"FFCE21";
static NSString * const kDefaultTextColorHex = @"414141";
static NSString * const kSelectedTextColorHex = @"white";
static NSString * const kDefaultTextFont = @"HelveticaNeue";
static NSString * const kSelectedTextFont = @"HelveticaNeue-Medium";

static NSString * const kIntroStoryboardName = @"Intro";
static NSString * const kCameraStoryboardName = @"Camera";

static NSString * const kSeenTutorialKey = @"seenTutorial";

//seenTutorial

static NSString * const kNoAccessErrorDescription = @"Couldn't locate camera, you might need to enable camera access in iOS privacy settings for this app.";

#endif /* Constants_h */
