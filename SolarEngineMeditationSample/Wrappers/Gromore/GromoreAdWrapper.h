//
//  GromoreAdWrapper.h
//  SolarEngineMeditationSample
//
//  Created by zhanghulk on 2025/8/27.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <BUAdSDK/BUAdSDK.h>

NS_ASSUME_NONNULL_BEGIN

@interface GromoreAdWrapper : NSObject

// Rewarded Ad
+ (void)trackRewardedAdImpression:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd;

// Interstitial Ad (Fullscreen Video)
+ (void)trackInterstitialAdImpression:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd;

// Banner Ad
+ (void)trackBannerAdImpression:(BUNativeExpressBannerView *)bannerView;

// Native Ad
+ (void)trackNativeAdImpression:(BUNativeExpressAdView *)nativeAdView;

// Splash Ad
+ (void)trackSplashAdImpression:(BUSplashAd *)splashAd;

@end

NS_ASSUME_NONNULL_END
