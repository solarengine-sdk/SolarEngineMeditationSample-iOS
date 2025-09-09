//
//  TopOnSolarEngineTracker.h
//  SolarEngineMeditationSample
//
//  Created by Assistant on 2024/01/01.
//

#import <Foundation/Foundation.h>
#import <SolarEngineSDK/SolarEngineSDK.h>

NS_ASSUME_NONNULL_BEGIN

// TopOnAd type enum
typedef NS_ENUM(NSInteger, TopOnAdType) {
    TopOnAdTypeOther = 0,           // Other
    TopOnAdTypeRewardVideo = 1,     // Rewarded Video
    TopOnAdTypeSplash = 2,          // Splash
    TopOnAdTypeInterstitial = 3,    // Interstitial
    TopOnAdTypeFullScreenVideo = 4, // Full Screen Video
    TopOnAdTypeBanner = 5,          // Banner
    TopOnAdTypeNative = 6,          // Native Feed
    TopOnAdTypeShortVideoFeed = 7,  // 短视频Native Feed
    TopOnAdTypeLargeBanner = 8,     // Large Banner
    TopOnAdTypeVideoPatch = 9,      // Video Patch
    TopOnAdTypeMediumBanner = 10    // Medium Banner
};

@interface TopOnSolarEngineTracker : NSObject

+ (void)trackAdImpressionWithAdType:(TopOnAdType)adType extra:(NSDictionary *)adData;

@end

NS_ASSUME_NONNULL_END
