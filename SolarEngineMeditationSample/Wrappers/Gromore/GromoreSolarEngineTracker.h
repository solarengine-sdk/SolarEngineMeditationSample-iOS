//
//  GromoreSolarEngineTracker.h
//  SolarEngineMeditationSample
//
//  Created by Assistant on 2024/01/01.
//

#import <Foundation/Foundation.h>
#import <SolarEngineSDK/SolarEngineSDK.h>
#import <BUAdSDK/BUAdSDK.h>

NS_ASSUME_NONNULL_BEGIN

// GromoreAd type enum
typedef NS_ENUM(NSInteger, GromoreAdType) {
    GromoreAdTypeOther = 0,           // Other
    GromoreAdTypeRewardVideo = 1,     // Rewarded Video
    GromoreAdTypeSplash = 2,          // Splash
    GromoreAdTypeInterstitial = 3,    // Interstitial
    GromoreAdTypeFullScreenVideo = 4, // Full Screen Video
    GromoreAdTypeBanner = 5,          // Banner
    GromoreAdTypeNative = 6,          // Native Feed
    GromoreAdTypeShortVideoFeed = 7,  // 短视频Native Feed
    GromoreAdTypeLargeBanner = 8,     // Large Banner
    GromoreAdTypeVideoPatch = 9,      // Video Patch
    GromoreAdTypeMediumBanner = 10    // Medium Banner
};

@interface GromoreSolarEngineTracker : NSObject

+ (void)trackAdImpressionWithAdType:(GromoreAdType)adType ritInfo:(BUMRitInfo *)info;

@end

NS_ASSUME_NONNULL_END
