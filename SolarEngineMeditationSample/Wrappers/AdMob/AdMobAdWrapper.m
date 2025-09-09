//
//  AdMobAdWrapper.m
//  SolarEngineMeditationSample
//
//  Created by zhanghulk on 2025/8/27.
//

#import "AdMobAdWrapper.h"
#import "AdMobLogUtils.h"
#import "AdMobSolarEngineTracker.h"
#import <GoogleMobileAds/GoogleMobileAds.h>

@implementation AdMobAdWrapper

#pragma mark - Rewarded Ad

+ (AdMobOnPaidEventBlock)rewardedAdOnPaidEventBlock:(AdMobOnPaidEventBlock)userListener responseInfo:(GADResponseInfo*)responseInfo {
    [AdMobLogUtils i:@"AdMobAdWrapper.rewardedAdOnPaidEventBlock() called"];
    
    return ^(GADAdValue *adValue) {
        // SolarEngine tracking
        [AdMobSolarEngineTracker trackAdImpressionWithAdType:AdMobAdTypeRewardVideo adValue:adValue responseInfo:responseInfo];
        
        // 调用用户回调
        if (userListener) {
            userListener(adValue);
        }
    };
}

#pragma mark - Interstitial Ad

+ (AdMobOnPaidEventBlock)interstitialAdOnPaidEventBlock:(AdMobOnPaidEventBlock)userListener responseInfo:(GADResponseInfo*)responseInfo {
    [AdMobLogUtils i:@"AdMobAdWrapper.interstitialAdOnPaidEventBlock() called"];
    
    return ^(GADAdValue *adValue) {
        // SolarEngine tracking
        [AdMobSolarEngineTracker trackAdImpressionWithAdType:AdMobAdTypeInterstitial adValue:adValue responseInfo:responseInfo];
        
        // 调用用户回调
        if (userListener) {
            userListener(adValue);
        }
    };
}

#pragma mark - Banner Ad

+ (AdMobOnPaidEventBlock)bannerAdOnPaidEventBlock:(AdMobOnPaidEventBlock)userListener responseInfo:(GADResponseInfo*)responseInfo {
    [AdMobLogUtils i:@"AdMobAdWrapper.bannerAdOnPaidEventBlock() called"];
    
    return ^(GADAdValue *adValue) {
        // SolarEngine tracking
        [AdMobSolarEngineTracker trackAdImpressionWithAdType:AdMobAdTypeBanner adValue:adValue responseInfo:responseInfo];
        
        // 调用用户回调
        if (userListener) {
            userListener(adValue);
        }
    };
}

#pragma mark - Native Ad

+ (AdMobOnPaidEventBlock)nativeAdOnPaidEventBlock:(AdMobOnPaidEventBlock)userListener responseInfo:(GADResponseInfo*)responseInfo {
    [AdMobLogUtils i:@"AdMobAdWrapper.nativeAdOnPaidEventBlock() called"];
    
    return ^(GADAdValue *adValue) {
        // SolarEngine tracking
        [AdMobSolarEngineTracker trackAdImpressionWithAdType:AdMobAdTypeNative adValue:adValue responseInfo:responseInfo];
        
        // 调用用户回调
        if (userListener) {
            userListener(adValue);
        }
    };
}

#pragma mark - App Open Ad

+ (AdMobOnPaidEventBlock)appOpenAdOnPaidEventBlock:(AdMobOnPaidEventBlock)userListener responseInfo:(GADResponseInfo*)responseInfo {
    [AdMobLogUtils i:@"AdMobAdWrapper.appOpenAdOnPaidEventBlock() called"];
    
    return ^(GADAdValue *adValue) {
        // SolarEngine tracking
        [AdMobSolarEngineTracker trackAdImpressionWithAdType:AdMobAdTypeSplash adValue:adValue responseInfo:responseInfo];
        
        // 调用用户回调
        if (userListener) {
            userListener(adValue);
        }
    };
}

@end
