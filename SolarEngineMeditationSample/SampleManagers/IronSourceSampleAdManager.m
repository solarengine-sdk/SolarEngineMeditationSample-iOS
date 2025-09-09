//
//  IronSourceSampleAdManager.m
//  SolarEngineMeditationSample
//
//  Created by zhanghulk on 2025/8/27.
//

#import "IronSourceSampleAdManager.h"
#import "IronSourceConfig.h"

#import "LogUtils.h"
#import <IronSource/IronSource.h>
#import "IronSourceWrapper.h"


@interface IronSourceSampleAdManager () <LPMInterstitialAdDelegate, LPMRewardedAdDelegate, LPMBannerAdViewDelegate,LPMImpressionDataDelegate>

@property (nonatomic, strong) LPMBannerAdView *bannerView;
@property (nonatomic, strong) LPMInterstitialAd *interstitialAd;
@property (nonatomic, strong) LPMRewardedAd *rewardedAd;

@end

@implementation IronSourceSampleAdManager

+ (instancetype)shared {
    static IronSourceSampleAdManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[IronSourceSampleAdManager alloc] init];
    });
    return instance;
}

- (void)initializeSDK {
    [LogUtils i:@"IronSourceSampleAdManager.initializeSDK() called"];

    // Create a request builder with app key and ad formats. Add User ID if available
    LPMInitRequestBuilder *requestBuilder = [[LPMInitRequestBuilder alloc] initWithAppKey:@"appKey"];
    [requestBuilder withUserId:@"UserId"];

    [IronSourceWrapper addImpressionDataDelegate:self];

    // Build the initial request
    LPMInitRequest *initRequest = [requestBuilder build];
    // Initialize LevelPlay with the prepared request
    [LevelPlay initWithRequest:initRequest completion:^(LPMConfiguration *_Nullable config, NSError *_Nullable error){
    
        if(error) {
            // There was an error on initialization. Take necessary actions or retry
        } else {
           // Initialization was successful. You can now create ad objects and load ads or perform other tasks
            [LogUtils i:@"IronSource SDK initialized successfully"];
        }
    }];
}

- (void)dealloc {
    // 在对象销毁时移除代理
    [LevelPlay removeImpressionDataDelegate:[IronSourceWrapper LPMImpressionDataDelegate:self]];
    [IronSourceWrapper removeImpressionDataDelegate:self];
}

- (void)loadInterstitialAd {
    NSString *adUnitID = [[IronSourceConfig shared] getAdUnitIdForAdType:AdTypeInterstitial];
    [LogUtils i:[NSString stringWithFormat:@"Loading IronSource Interstitial ad with unit ID: %@", adUnitID]];
    [self.interstitialAd loadAd];
}

- (LPMInterstitialAd *)interstitialAd{
    if (_interstitialAd) {
        return _interstitialAd;
    }
    NSString *adUnitID = [[IronSourceConfig shared] getAdUnitIdForAdType:AdTypeInterstitial];
    self.interstitialAd = [[LPMInterstitialAd alloc] initWithAdUnitId:adUnitID];
    self.interstitialAd.delegate = self;
    return self.interstitialAd;
}

- (void)showInterstitialAdFromViewController:(UIViewController *)viewController {
    NSString *adUnitID = [[IronSourceConfig shared] getAdUnitIdForAdType:AdTypeInterstitial];
    if ([self.interstitialAd isAdReady]) {
        [self.interstitialAd showAdWithViewController:viewController placementName:@""];
    } else {
        [LogUtils w:@"IronSource Interstitial ad not ready yet"];
    }
}

- (void)loadRewardedAd {
    NSString *adUnitID = [[IronSourceConfig shared] getAdUnitIdForAdType:AdTypeRewarded];
    [LogUtils i:[NSString stringWithFormat:@"Loading IronSource Rewarded ad with unit ID: %@", adUnitID]];
    [self.rewardedAd loadAd];
}

-(LPMRewardedAd *)rewardedAd{
    if (_rewardedAd) {
        return _rewardedAd;
    }
    
    NSString *adUnitID = [[IronSourceConfig shared] getAdUnitIdForAdType:AdTypeRewarded];
    _rewardedAd = [[LPMRewardedAd alloc] initWithAdUnitId:adUnitID];
    _rewardedAd.delegate = self;
    return _rewardedAd;
}

- (void)showRewardedAdFromViewController:(UIViewController *)viewController {
    NSString *adUnitID = [[IronSourceConfig shared] getAdUnitIdForAdType:AdTypeRewarded];
    if ([self.rewardedAd isAdReady]) {
        [self.rewardedAd showAdWithViewController:viewController placementName:@""];
    } else {
        [LogUtils w:@"IronSource Rewarded ad not ready yet"];
    }
}

- (void)loadBannerAdFromViewController:(UIViewController *)viewController {
    NSString *adUnitID = [[IronSourceConfig shared] getAdUnitIdForAdType:AdTypeBanner];
    [LogUtils i:[NSString stringWithFormat:@"Loading IronSource Banner ad with unit ID: %@", adUnitID]];

    [self.bannerView loadAdWithViewController:viewController];
}

-(LPMBannerAdView *)getBannerView{
    if (_bannerView) {
        return _bannerView;
    }

    LPMBannerAdViewConfigBuilder *adConfigBuilder = [LPMBannerAdViewConfigBuilder new];
    
    LPMAdSize *bannerSize = [LPMAdSize createAdaptiveAdSize];
    [adConfigBuilder setWithAdSize:bannerSize];
    [adConfigBuilder setWithPlacementName:@"placementName"];
    LPMBannerAdViewConfig *adConfig = [adConfigBuilder build];
    // Create the banner view and set the ad unit id
    NSString *adUnitID = [[IronSourceConfig shared] getAdUnitIdForAdType:AdTypeBanner];
    _bannerView = [[LPMBannerAdView alloc] initWithAdUnitId:adUnitID config: adConfig];
    [self.bannerView setDelegate:self];
    return _bannerView;
}

#pragma mark - LPMInterstitialAdDelegate Methods
- (void)didLoadAdWithAdInfo:(LPMAdInfo *)adInfo {}
- (void)didFailToLoadAdWithAdUnitId:(NSString *)adUnitId error:(NSError *)error {}
- (void)didChangeAdInfo:(LPMAdInfo *)adInfo {}
- (void)didDisplayAdWithAdInfo:(LPMAdInfo *)adInfo {}
- (void)didFailToDisplayAdWithAdInfo:(LPMAdInfo *)adInfo error:(NSError *)error {}
- (void)didClickAdWithAdInfo:(LPMAdInfo *)adInfo {}
- (void)didCloseAdWithAdInfo:(LPMAdInfo *)adInfo {}

#pragma mark - LPMRewardedAdDelegate
- (void)didRewardAdWithAdInfo:(LPMAdInfo *)adInfo reward:(LPMReward *)reward {}

#pragma mark - LPMBannerAdViewDelegate
- (void)didLeaveAppWithAdInfo:(LPMAdInfo *)adInfo {
   // Optional. User pressed on the ad and was navigated out of the app
}
- (void)didExpandAdWithAdInfo:(LPMAdInfo *)adInfo {
   // Optional. Ad is opened on full screen
}
- (void)didCollapseAdWithAdInfo:(LPMAdInfo *)adInfo {
   // Optional. Ad is restored to its original size
}


#pragma mark - LPMImpressionDataDelegate
- (void)impressionDataDidSucceed:(LPMImpressionData *)impressionData {
    ;
}

@end
