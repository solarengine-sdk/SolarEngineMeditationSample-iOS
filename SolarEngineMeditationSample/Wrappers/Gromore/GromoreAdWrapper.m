//
//  GromoreAdWrapper.m
//  SolarEngineMeditationSample
//
//  Created by zhanghulk on 2025/8/27.
//

#import "GromoreAdWrapper.h"
#import "GromoreLogUtils.h"
#import "GromoreSolarEngineTracker.h"
#import <BUAdSDK/BUAdSDK.h>

@implementation GromoreAdWrapper

#pragma mark - Rewarded Ad

+ (void)trackRewardedAdImpression:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd {
    [GromoreLogUtils i:@"GromoreAdWrapper.trackRewardedAdImpression() called"];
    
    // Get RIT info from the rewarded video ad for tracking
    BUMRitInfo *ritInfo = nil;
    if (rewardedVideoAd && rewardedVideoAd.mediation) {
        ritInfo = rewardedVideoAd.mediation.getShowEcpmInfo;
    }
    
    [GromoreSolarEngineTracker trackAdImpressionWithAdType:GromoreAdTypeRewardVideo ritInfo:ritInfo];
}

#pragma mark - Interstitial Ad (Fullscreen Video)

+ (void)trackInterstitialAdImpression:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd {
    [GromoreLogUtils i:@"GromoreAdWrapper.trackInterstitialAdImpression() called"];
    
    // Get RIT info from the fullscreen video ad for tracking
    BUMRitInfo *ritInfo = nil;
    if (fullscreenVideoAd && fullscreenVideoAd.mediation) {
        ritInfo = fullscreenVideoAd.mediation.getShowEcpmInfo;
    }
    
    [GromoreSolarEngineTracker trackAdImpressionWithAdType:GromoreAdTypeFullScreenVideo ritInfo:ritInfo];
}

#pragma mark - Banner Ad

+ (void)trackBannerAdImpression:(BUNativeExpressBannerView *)bannerView {
    [GromoreLogUtils i:@"GromoreAdWrapper.trackBannerAdImpression() called"];
    
    // Get RIT info from the banner view for tracking
    BUMRitInfo *ritInfo = nil;
    if (bannerView && bannerView.mediation) {
        ritInfo = bannerView.mediation.getShowEcpmInfo;
    }
    
    [GromoreSolarEngineTracker trackAdImpressionWithAdType:GromoreAdTypeBanner ritInfo:ritInfo];
}

#pragma mark - Native Ad

+ (void)trackNativeAdImpression:(BUNativeExpressAdView *)nativeAdView {
    [GromoreLogUtils i:@"GromoreAdWrapper.trackNativeAdImpression() called"];
    
    // Get RIT info from the native ad view for tracking
    BUMRitInfo *ritInfo = nil;
    if (nativeAdView && nativeAdView.mediation) {
        ritInfo = nativeAdView.mediation.getShowEcpmInfo;
    }
    
    [GromoreSolarEngineTracker trackAdImpressionWithAdType:GromoreAdTypeNative ritInfo:ritInfo];
}

#pragma mark - Splash Ad

+ (void)trackSplashAdImpression:(BUSplashAd *)splashAd {
    [GromoreLogUtils i:@"GromoreAdWrapper.trackSplashAdImpression() called"];
    
    // Get RIT info from the splash ad for tracking
    BUMRitInfo *ritInfo = nil;
    if (splashAd && splashAd.mediation) {
        ritInfo = splashAd.mediation.getShowEcpmInfo;
    }
    
    [GromoreSolarEngineTracker trackAdImpressionWithAdType:GromoreAdTypeSplash ritInfo:ritInfo];
}

@end
