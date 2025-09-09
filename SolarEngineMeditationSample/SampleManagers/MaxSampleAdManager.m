//
//  MaxSampleAdManager.m
//  SolarEngineMeditationSample
//
//  Created by zhanghulk on 2025/8/27.
//

#import "MaxSampleAdManager.h"
#import "MaxConfig.h"
#import "MaxInterstitialAdWrapper.h"
#import "MaxRewardedAdWrapper.h"
#import "MaxBannerAdWrapper.h"
#import "MaxNativeAdWrapper.h"
#import "LogUtils.h"
#import <AppLovinSDK/AppLovinSDK.h>

@interface MaxSampleAdManager () <MAAdDelegate, MARewardedAdDelegate, MAAdViewAdDelegate, MANativeAdDelegate,MAAdRevenueDelegate>

@property (nonatomic, strong) MAInterstitialAd *interstitialAd;
@property (nonatomic, strong) MARewardedAd *rewardedAd;
@property (nonatomic, strong) MAAdView *bannerView;

@end

@implementation MaxSampleAdManager

+ (instancetype)shared {
    static MaxSampleAdManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[MaxSampleAdManager alloc] init];
    });
    return instance;
}

- (void)initializeSDK {
    [LogUtils i:@"MaxSampleAdManager.initializeSDK() called"];

    // Create the initialization configuration
    ALSdkInitializationConfiguration *initConfig = [ALSdkInitializationConfiguration configurationWithSdkKey: @"«SDK-key»" builderBlock:^(ALSdkInitializationConfigurationBuilder *builder) {

      builder.mediationProvider = ALMediationProviderMAX;

      // Perform any additional configuration/setting changes
    }];
    
    // Initialize the SDK with the configuration
    [[ALSdk shared] initializeWithConfiguration: initConfig completionHandler:^(ALSdkConfiguration *sdkConfig) {
        [LogUtils i:@"MAX SDK initialized successfully"];

      // Start loading ads
        NSString *adUnitIDIV = [[MaxConfig shared] getAdUnitIdForAdType:AdTypeInterstitial];
        self.interstitialAd = [[MAInterstitialAd alloc] initWithAdUnitIdentifier: adUnitIDIV];
        self.interstitialAd.delegate = self;
        
        
        NSString *adUnitIDRV = [[MaxConfig shared] getAdUnitIdForAdType:AdTypeRewarded];
        self.rewardedAd = [MARewardedAd sharedWithAdUnitIdentifier:adUnitIDRV];
        self.rewardedAd.delegate = self;
        
        NSString *adUnitIDBanner = [[MaxConfig shared] getAdUnitIdForAdType:AdTypeBanner];
        self.bannerView = [[MAAdView alloc] initWithAdUnitIdentifier:adUnitIDBanner];
        self.bannerView.delegate = self;
    }];
    
}

- (void)loadInterstitialAd {
    NSString *adUnitID = [[MaxConfig shared] getAdUnitIdForAdType:AdTypeInterstitial];
    [LogUtils i:[NSString stringWithFormat:@"Loading MAX Interstitial ad with unit ID: %@", adUnitID]];

    [self.interstitialAd loadAd];
}

- (void)showInterstitialAdFromViewController:(UIViewController *)viewController {
    if ([self.interstitialAd isReady]) {
        [self.interstitialAd showAd];
    } else {
        [LogUtils w:@"MAX Interstitial ad not ready yet"];
    }
}

- (void)loadRewardedAd {
    NSString *adUnitID = [[MaxConfig shared] getAdUnitIdForAdType:AdTypeRewarded];
    [LogUtils i:[NSString stringWithFormat:@"Loading MAX Rewarded ad with unit ID: %@", adUnitID]];
    
    [self.rewardedAd loadAd];
}

- (void)showRewardedAdFromViewController:(UIViewController *)viewController {
    if ([self.rewardedAd isReady]) {
        [self.rewardedAd showAd];
    } else {
        [LogUtils w:@"MAX Rewarded ad not ready yet"];
    }
}

- (void)loadBannerAd {
    NSString *adUnitID = [[MaxConfig shared] getAdUnitIdForAdType:AdTypeBanner];
    [LogUtils i:[NSString stringWithFormat:@"Loading MAX Banner ad with unit ID: %@", adUnitID]];

    [self.bannerView loadAd];
}

- (MAAdView *)getBannerView {
    return self.bannerView;
}

#pragma mark - MAAdDelegate

- (void)didLoadAd:(MAAd *)ad {
    [LogUtils i:@"MAX ad loaded successfully"];
}

- (void)didFailToLoadAdForAdUnitIdentifier:(NSString *)adUnitIdentifier withError:(MAError *)error {
    [LogUtils e:[NSString stringWithFormat:@"MAX ad failed to load: %@", error.message]];
}

- (void)didDisplayAd:(MAAd *)ad {
    [LogUtils i:@"MAX ad displayed"];
}

- (void)didHideAd:(MAAd *)ad {
    [LogUtils i:@"MAX ad hidden"];
}

- (void)didClickAd:(MAAd *)ad {
    [LogUtils i:@"MAX ad clicked"];
}

- (void)didFailToDisplayAd:(nonnull MAAd *)ad withError:(nonnull MAError *)error { 
    [LogUtils i:@"MAX ad didFailToDisplayAd"];
}


#pragma mark - MARewardedAdDelegate

- (void)didStartRewardedVideoForAd:(MAAd *)ad {
    [LogUtils i:@"MAX Rewarded video started"];
}

- (void)didCompleteRewardedVideoForAd:(MAAd *)ad {
    [LogUtils i:@"MAX Rewarded video completed"];
}

- (void)didRewardUserForAd:(MAAd *)ad withReward:(MAReward *)reward {
    [LogUtils i:[NSString stringWithFormat:@"MAX User earned reward: %@", reward.label]];
}

#pragma mark - MAAdViewAdDelegate

- (void)didExpandAd:(MAAd *)ad {
    [LogUtils i:@"MAX Banner ad expanded"];
}

- (void)didCollapseAd:(MAAd *)ad {
    [LogUtils i:@"MAX Banner ad collapsed"];
}

#pragma mark - MANativeAdDelegate

- (void)didLoadNativeAd:(MANativeAd *)nativeAd {
    [LogUtils i:@"MAX Native ad loaded successfully"];
}

- (void)didClickNativeAd:(nonnull MAAd *)ad { 
    ;
}

- (void)didFailToLoadNativeAdForAdUnitIdentifier:(nonnull NSString *)adUnitIdentifier withError:(nonnull MAError *)error { 
    ;
}

- (void)didLoadNativeAd:(nullable MANativeAdView *)nativeAdView forAd:(nonnull MAAd *)ad { 
    ;
}

#pragma mark - MAAdRevenueDelegate
- (void)didPayRevenueForAd:(nonnull MAAd *)ad {
    ;
}

@end
