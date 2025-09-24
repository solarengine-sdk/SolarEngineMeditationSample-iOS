//
//  AdMobSampleAdManager.m
//  SolarEngineMeditationSample
//
//  Created by zhanghulk on 2025/8/27.
//

#import "AdMobSampleAdManager.h"
#import "AdMobConfig.h"
#import "AdMobAdWrapper.h"
#import "LogUtils.h"
#import <GoogleMobileAds/GoogleMobileAds.h>

@interface AdMobSampleAdManager () <GADFullScreenContentDelegate, GADBannerViewDelegate, GADNativeAdLoaderDelegate, GADNativeAdDelegate>

@property (nonatomic, strong) GADInterstitialAd *interstitialAd;
@property (nonatomic, strong) GADRewardedAd *rewardedAd;
@property (nonatomic, strong) GADBannerView *bannerView;
@property (nonatomic, strong) GADNativeAd *nativeAd;
@property (nonatomic, strong) GADAppOpenAd *appOpenAd;
@property (nonatomic, strong) GADAdLoader *adLoader;

@end

@implementation AdMobSampleAdManager

+ (instancetype)shared {
    static AdMobSampleAdManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[AdMobSampleAdManager alloc] init];
    });
    return instance;
}

- (void)initializeSDK {
    [LogUtils i:@"AdMobSampleAdManager.initializeSDK() called"];
    [[GADMobileAds sharedInstance] startWithCompletionHandler:^(GADInitializationStatus *status) {
        [LogUtils i:@"AdMob SDK initialized successfully"];
    }];
}

- (void)loadInterstitialAd {
    NSString *adUnitID = [[AdMobConfig shared] getAdUnitIdForAdType:AdTypeInterstitial];
    [LogUtils i:[NSString stringWithFormat:@"Loading AdMob Interstitial ad with unit ID: %@", adUnitID]];
    
    GADRequest *request = [GADRequest request];
    [GADInterstitialAd loadWithAdUnitID:adUnitID
                                request:request
                      completionHandler:^(GADInterstitialAd *ad, NSError *error) {
        if (error) {
            [LogUtils e:[NSString stringWithFormat:@"Failed to load AdMob Interstitial ad: %@", error.localizedDescription]];
            return;
        }
        
        self.interstitialAd = ad;
        self.interstitialAd.fullScreenContentDelegate = self;
        
        GADResponseInfo *info = self.interstitialAd.responseInfo;
        // Set paid event listener
        self.interstitialAd.paidEventHandler = [AdMobAdWrapper interstitialAdOnPaidEventBlock:^(GADAdValue *adValue) {
            [LogUtils i:@"AdMob Interstitial onAdRevenuePaid"];
        } adUnitId:adUnitID responseInfo:info];
        
        [LogUtils i:@"AdMob Interstitial ad loaded successfully"];
    }];
}

- (void)showInterstitialAdFromViewController:(UIViewController *)viewController {
    if (self.interstitialAd) {
        [self.interstitialAd presentFromRootViewController:viewController];
    } else {
        [LogUtils w:@"AdMob Interstitial ad not ready yet"];
    }
}

- (void)loadRewardedAd {
    NSString *adUnitID = [[AdMobConfig shared] getAdUnitIdForAdType:AdTypeRewarded];
    [LogUtils i:[NSString stringWithFormat:@"Loading AdMob Rewarded ad with unit ID: %@", adUnitID]];
    
    GADRequest *request = [GADRequest request];
    [GADRewardedAd loadWithAdUnitID:adUnitID
                            request:request
                  completionHandler:^(GADRewardedAd *ad, NSError *error) {
        if (error) {
            [LogUtils e:[NSString stringWithFormat:@"Failed to load AdMob Rewarded ad: %@", error.localizedDescription]];
            return;
        }
        
        self.rewardedAd = ad;
        self.rewardedAd.fullScreenContentDelegate = self;
        

        GADResponseInfo *info = self.rewardedAd.responseInfo;

        // Set paid event listener
        self.rewardedAd.paidEventHandler = [AdMobAdWrapper rewardedAdOnPaidEventBlock:^(GADAdValue *adValue) {
            [LogUtils i:@"AdMob Rewarded onAdRevenuePaid"];
          
        } adUnitId:ad.adUnitID responseInfo:info];
        
        [LogUtils i:@"AdMob Rewarded ad loaded successfully"];
    }];
}

- (void)showRewardedAdFromViewController:(UIViewController *)viewController {
    if (self.rewardedAd) {
        [self.rewardedAd presentFromRootViewController:viewController
                                userDidEarnRewardHandler:^{
            [LogUtils i:@"AdMob Rewarded ad user earned reward"];
        }];
    } else {
        [LogUtils w:@"AdMob Rewarded ad not ready yet"];
    }
}

- (void)loadBannerAd {
    NSString *adUnitID = [[AdMobConfig shared] getAdUnitIdForAdType:AdTypeBanner];
    [LogUtils i:[NSString stringWithFormat:@"Loading AdMob Banner ad with unit ID: %@", adUnitID]];
    
    self.bannerView = [[GADBannerView alloc] initWithAdSize:GADAdSizeBanner];
    self.bannerView.adUnitID = adUnitID;
    self.bannerView.rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    self.bannerView.delegate = self;
    
    GADResponseInfo *info = self.bannerView.responseInfo;
    // Set paid event listener

    self.bannerView.paidEventHandler = [AdMobAdWrapper bannerAdOnPaidEventBlock:^(GADAdValue *adValue) {
        [LogUtils i:@"AdMob Banner onAdRevenuePaid"];
    } adUnitId:adUnitID responseInfo:info];
    
    GADRequest *request = [GADRequest request];
    [self.bannerView loadRequest:request];
}

- (GADBannerView *)getBannerView {
    return self.bannerView;
}

#pragma mark - GADFullScreenContentDelegate

- (void)adDidRecordImpression:(id<GADFullScreenPresentingAd>)ad {
    [LogUtils i:@"AdMob full screen ad did record impression"];
}

- (void)ad:(id<GADFullScreenPresentingAd>)ad didFailToPresentFullScreenContentWithError:(NSError *)error {
    [LogUtils e:[NSString stringWithFormat:@"AdMob full screen ad failed to present: %@", error.localizedDescription]];
}

- (void)adDidDismissFullScreenContent:(id<GADFullScreenPresentingAd>)ad {
    [LogUtils i:@"AdMob full screen ad did dismiss"];
}

#pragma mark - GADBannerViewDelegate

- (void)bannerViewDidReceiveAd:(GADBannerView *)bannerView {
    [LogUtils i:@"AdMob Banner ad loaded successfully"];
}

- (void)bannerView:(GADBannerView *)bannerView didFailToReceiveAdWithError:(NSError *)error {
    [LogUtils e:[NSString stringWithFormat:@"AdMob Banner ad failed to load: %@", error.localizedDescription]];
}

#pragma mark - GADNativeAdLoaderDelegate

- (void)adLoader:(GADAdLoader *)adLoader didReceiveNativeAd:(GADNativeAd *)nativeAd {
    [LogUtils i:@"AdMob Native ad loaded successfully"];
    self.nativeAd = nativeAd;
    self.nativeAd.delegate = self;
    
    
    NSString *adUnitID = [[AdMobConfig shared] getAdUnitIdForAdType:AdTypeNative];

    GADResponseInfo *info = self.nativeAd.responseInfo;
    // Set paid event listener
    self.nativeAd.paidEventHandler = [AdMobAdWrapper nativeAdOnPaidEventBlock:^(GADAdValue *adValue) {
        [LogUtils i:@"AdMob Native onAdRevenuePaid"];
    } adUnitId:adUnitID responseInfo:info];
}

- (void)adLoader:(GADAdLoader *)adLoader didFailToReceiveAdWithError:(NSError *)error {
    [LogUtils e:[NSString stringWithFormat:@"AdMob Native ad failed to load: %@", error.localizedDescription]];
}

#pragma mark - GADNativeAdDelegate

- (void)nativeAdDidRecordImpression:(GADNativeAd *)nativeAd {
    [LogUtils i:@"AdMob Native ad did record impression"];
}

@end
