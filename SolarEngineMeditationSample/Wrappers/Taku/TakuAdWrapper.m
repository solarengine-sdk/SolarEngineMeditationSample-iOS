//
//  TakuAdWrapper.m
//  SolarEngineMeditationSample
//
//  Created by zhanghulk on 2025/8/27.
//

#import "TakuAdWrapper.h"
#import "TakuLogUtils.h"
#import "TakuSolarEngineTracker.h"

@implementation TakuAdWrapper

#pragma mark - Rewarded Ad

+ (void)trackRewardedAdRevenue:(NSString *)placementID extra:(NSDictionary *)extra {
    [TakuLogUtils i:@"TakuAdWrapper.trackRewardedAdRevenue() called"];

    [TakuSolarEngineTracker trackAdImpressionWithAdType:TakuAdTypeRewardVideo extra:extra];
}

#pragma mark - Interstitial Ad

+ (void)trackInterstitialAdRevenue:(NSString *)placementID extra:(NSDictionary *)extra {
    [TakuLogUtils i:@"TakuAdWrapper.trackInterstitialAdRevenue() called"];
    
    [TakuSolarEngineTracker trackAdImpressionWithAdType:TakuAdTypeInterstitial extra:extra];
}

#pragma mark - Banner Ad

+ (void)trackBannerAdRevenue:(NSString *)placementID extra:(NSDictionary *)extra {
    [TakuLogUtils i:@"TakuAdWrapper.trackBannerAdRevenue() called"];
    
    [TakuSolarEngineTracker trackAdImpressionWithAdType:TakuAdTypeBanner extra:extra];
}

#pragma mark - Native Ad

+ (void)trackNativeAdRevenue:(NSString *)placementID extra:(NSDictionary *)extra {
    [TakuLogUtils i:@"TakuAdWrapper.trackNativeAdRevenue() called"];
    
    [TakuSolarEngineTracker trackAdImpressionWithAdType:TakuAdTypeNative extra:extra];
}

#pragma mark - Splash Ad

+ (void)trackSplashAdRevenue:(NSString *)placementID extra:(NSDictionary *)extra {
    [TakuLogUtils i:@"TakuAdWrapper.trackSplashAdRevenue() called"];
    
    [TakuSolarEngineTracker trackAdImpressionWithAdType:TakuAdTypeSplash extra:extra];
}

@end
