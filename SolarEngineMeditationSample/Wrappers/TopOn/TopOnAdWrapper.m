//
//  TopOnAdWrapper.m
//  SolarEngineMeditationSample
//
//  Created by zhanghulk on 2025/8/27.
//

#import "TopOnAdWrapper.h"
#import "TopOnLogUtils.h"
#import "TopOnSolarEngineTracker.h"

@implementation TopOnAdWrapper

#pragma mark - Rewarded Ad

+ (void)trackRewardedAdRevenue:(NSString *)placementID extra:(NSDictionary *)extra {
    [TopOnLogUtils i:@"TopOnAdWrapper.trackRewardedAdRevenue() called"];

    [TopOnSolarEngineTracker trackAdImpressionWithAdType:TopOnAdTypeRewardVideo extra:extra];
}

#pragma mark - Interstitial Ad

+ (void)trackInterstitialAdRevenue:(NSString *)placementID extra:(NSDictionary *)extra {
    [TopOnLogUtils i:@"TopOnAdWrapper.trackInterstitialAdRevenue() called"];

    [TopOnSolarEngineTracker trackAdImpressionWithAdType:TopOnAdTypeInterstitial extra:extra];
}

#pragma mark - Banner Ad

+ (void)trackBannerAdRevenue:(NSString *)placementID extra:(NSDictionary *)extra {
    [TopOnLogUtils i:@"TopOnAdWrapper.trackBannerAdRevenue() called"];
    
    [TopOnSolarEngineTracker trackAdImpressionWithAdType:TopOnAdTypeBanner extra:extra];
}

#pragma mark - Native Ad

+ (void)trackNativeAdRevenue:(NSString *)placementID extra:(NSDictionary *)extra {
    [TopOnLogUtils i:@"TopOnAdWrapper.trackNativeAdRevenue() called"];
    
    [TopOnSolarEngineTracker trackAdImpressionWithAdType:TopOnAdTypeNative extra:extra];
}

#pragma mark - Splash Ad

+ (void)trackSplashAdRevenue:(NSString *)placementID extra:(NSDictionary *)extra {
    [TopOnLogUtils i:@"TopOnAdWrapper.trackSplashAdRevenue() called"];
    
    [TopOnSolarEngineTracker trackAdImpressionWithAdType:TopOnAdTypeSplash extra:extra];
}

@end
