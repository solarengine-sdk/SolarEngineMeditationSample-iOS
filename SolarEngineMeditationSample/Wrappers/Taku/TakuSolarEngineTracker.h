//
//  TakuSolarEngineTracker.h
//  SolarEngineMeditationSample
//
//  Created by Assistant on 2024/01/01.
//

#import <Foundation/Foundation.h>
#import <SolarEngineSDK/SolarEngineSDK.h>

NS_ASSUME_NONNULL_BEGIN

// TakuAd type enum
typedef NS_ENUM(NSInteger, TakuAdType) {
    TakuAdTypeOther = 0,           // Other
    TakuAdTypeRewardVideo = 1,     // Rewarded Video
    TakuAdTypeSplash = 2,          // Splash
    TakuAdTypeInterstitial = 3,    // Interstitial
    TakuAdTypeFullScreenVideo = 4, // Full Screen Video
    TakuAdTypeBanner = 5,          // Banner
    TakuAdTypeNative = 6,          // Native Feed
    TakuAdTypeShortVideoFeed = 7,  // 短视频Native Feed
    TakuAdTypeLargeBanner = 8,     // Large Banner
    TakuAdTypeVideoPatch = 9,      // Video Patch
    TakuAdTypeMediumBanner = 10    // Medium Banner
};

@interface TakuSolarEngineTracker : NSObject

+ (void)trackAdImpressionWithAdType:(TakuAdType)adType extra:(NSDictionary *)adData;

@end

NS_ASSUME_NONNULL_END
