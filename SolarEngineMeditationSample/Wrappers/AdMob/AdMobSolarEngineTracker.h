//
//  AdMobSolarEngineTracker.h
//  SolarEngineMeditationSample
//
//  Created by Assistant on 2024/01/01.
//

#import <Foundation/Foundation.h>
#import <SolarEngineSDK/SolarEngineSDK.h>
#import <GoogleMobileAds/GoogleMobileAds.h>

NS_ASSUME_NONNULL_BEGIN

// AdMobAd type enum
typedef NS_ENUM(NSInteger, AdMobAdType) {
    AdMobAdTypeOther = 0,           // Other
    AdMobAdTypeRewardVideo = 1,     // Rewarded Video
    AdMobAdTypeSplash = 2,          // Splash
    AdMobAdTypeInterstitial = 3,    // Interstitial
    AdMobAdTypeFullScreenVideo = 4, // Full Screen Video
    AdMobAdTypeBanner = 5,          // Banner
    AdMobAdTypeNative = 6,          // Native Feed
    AdMobAdTypeShortVideoFeed = 7,  // 短视频Native Feed
    AdMobAdTypeLargeBanner = 8,     // Large Banner
    AdMobAdTypeVideoPatch = 9,      // Video Patch
    AdMobAdTypeMediumBanner = 10    // Medium Banner
};

@interface AdMobSolarEngineTracker : NSObject

+ (void)trackAdImpressionWithAdType:(AdMobAdType)adType adUnitId:(NSString *)adUnitId adValue:(GADAdValue *)adValue responseInfo:(GADResponseInfo*)responseInfo;

@end

NS_ASSUME_NONNULL_END
