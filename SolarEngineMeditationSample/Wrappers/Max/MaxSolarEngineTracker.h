//
//  MaxSolarEngineTracker.h
//  SolarEngineMeditationSample
//
//  Created by Assistant on 2024/01/01.
//

#import <Foundation/Foundation.h>
#import <SolarEngineSDK/SolarEngineSDK.h>
#import <AppLovinSDK/AppLovinSDK.h>

NS_ASSUME_NONNULL_BEGIN

// MAXAd type enum
typedef NS_ENUM(NSInteger, MaxAdType) {
    MaxAdTypeOther = 0,           // Other
    MaxAdTypeRewardVideo = 1,     // Rewarded Video
    MaxAdTypeSplash = 2,          // Splash
    MaxAdTypeInterstitial = 3,    // Interstitial
    MaxAdTypeFullScreenVideo = 4, // Full Screen Video
    MaxAdTypeBanner = 5,          // Banner
    MaxAdTypeNative = 6,          // Native Feed
    MaxAdTypeShortVideoFeed = 7,  // 短视频Native Feed
    MaxAdTypeLargeBanner = 8,     // Large Banner
    MaxAdTypeVideoPatch = 9,      // Video Patch
    MaxAdTypeMediumBanner = 10    // Medium Banner
};

@interface MaxSolarEngineTracker : NSObject

+ (void)trackAdImpressionWithAdType:(MaxAdType)adType ad:(MAAd *)ad;

@end

NS_ASSUME_NONNULL_END
