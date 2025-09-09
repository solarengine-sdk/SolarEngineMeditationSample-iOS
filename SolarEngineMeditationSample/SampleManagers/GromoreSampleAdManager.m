//
//  GromoreSampleAdManager.m
//  SolarEngineMeditationSample
//
//  Created by zhanghulk on 2025/8/27.
//

#import "GromoreSampleAdManager.h"
#import "GromoreConfig.h"
#import "GromoreAdWrapper.h"
#import "LogUtils.h"
#import <BUAdSDK/BUAdSDK.h>

@interface GromoreSampleAdManager ()

@property (nonatomic, strong) BUNativeExpressFullscreenVideoAd *fullscreenAd;
@property (nonatomic, strong) BUNativeExpressRewardedVideoAd *rewardedVideoAd;
@property (nonatomic, strong) BUNativeExpressBannerView *bannerView;
@property (nonatomic, strong) ABUNativeAdView *nativeAdView;

@end

@implementation GromoreSampleAdManager

+ (instancetype)shared {
    static GromoreSampleAdManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[GromoreSampleAdManager alloc] init];
    });
    return instance;
}

- (void)initializeSDK {
    [LogUtils i:@"GromoreSampleAdManager.initializeSDK() called"];
    BUAdSDKConfiguration *configuration = [BUAdSDKConfiguration configuration];
    // Replace with the appid obtained from the platform
    configuration.appID = @"xxxxxx";
    // 如果使用聚合维度功能，则务必将以下字段设置为YES，并检查工程有引用CSJMediation.framework，这样SDK初始化时将启动聚合相关必要组件
    configuration.useMediation = YES;
    // SDK异步初始化
    [BUAdSDKManager startWithAsyncCompletionHandler:^(BOOL success, NSError *error) {
      if (success) {
        dispatch_async(dispatch_get_main_queue(), ^{
          //请求广告逻辑处理

            [self p_buildRVAd];
            [self p_buildIVAd];
            
        });
      }
    }];
    [LogUtils i:@"Gromore SDK initialized successfully"];
}

// 创建广告对象
- (void)p_buildRVAd {
    
    NSString *adUnitID = [[GromoreConfig shared] getAdUnitIdForAdType:AdTypeRewarded];

    BUAdSlot *adslot = [[BUAdSlot alloc]init];
    adslot.ID = adUnitID; // 聚合维度通过广告位ID发起请求，仅接入CSJ广告通过代码位ID发起请求
  
  // 聚合维度相关设置
      adslot.mediation.mutedIfCan = NO; // 是否静音
    adslot.mediation.bidNotify = NO; // 是否开启竞价结果回传
    adslot.mediation.scenarioID = @"123321"; // 场景ID
  
  
    BURewardedVideoModel *model = [[BURewardedVideoModel alloc] init];
    model.userId = @"123"; // 用户唯一标识
    model.rewardName = @"rewardName"; // 奖励名称
    model.rewardAmount = 100;  // 奖励数量

    self.rewardedVideoAd = [[BUNativeExpressRewardedVideoAd alloc] initWithSlot:adslot rewardedVideoModel:model];
    // 使用wrapper的delegate
    self.rewardedVideoAd.delegate = self;

}

// 创建广告对象
- (void)p_buildIVAd {
    
    NSString *adUnitID = [[GromoreConfig shared] getAdUnitIdForAdType:AdTypeInterstitial];
    self.fullscreenAd = [[BUNativeExpressFullscreenVideoAd alloc] initWithSlotID:adUnitID]; // 聚合维度通过广告位ID发起请求；仅接入CSJ广告通过代码位ID发起请求
    // 使用wrapper的delegate
    self.fullscreenAd.delegate = self;
}


- (void)loadInterstitialAd {
    NSString *adUnitID = [[GromoreConfig shared] getAdUnitIdForAdType:AdTypeInterstitial];
    [LogUtils i:[NSString stringWithFormat:@"Loading Gromore Interstitial ad with unit ID: %@", adUnitID]];
    [self.fullscreenAd loadAdData];
}

- (void)showInterstitialAdFromViewController:(UIViewController *)viewController {
    [self.fullscreenAd showAdFromRootViewController:viewController];

}

- (void)loadRewardedAd {
    NSString *adUnitID = [[GromoreConfig shared] getAdUnitIdForAdType:AdTypeRewarded];
    [LogUtils i:[NSString stringWithFormat:@"Loading Gromore Rewarded ad with unit ID: %@", adUnitID]];
    [self.rewardedVideoAd loadAdData];
}

- (void)showRewardedAdFromViewController:(UIViewController *)viewController {
    [self.rewardedVideoAd showAdFromRootViewController:viewController];
}


- (void)loadBannerAd:(UIViewController *)viewController {
    NSString *adUnitID = [[GromoreConfig shared] getAdUnitIdForAdType:AdTypeBanner];
    [LogUtils i:[NSString stringWithFormat:@"Loading Gromore Banner ad with unit ID: %@", adUnitID]];
    
    if (self.bannerView) {
        [self.bannerView loadAdData];
        return;
    }
    
    CGSize size = CGSizeMake(320, 80);
    self.bannerView = [[BUNativeExpressBannerView alloc] initWithSlotID:adUnitID rootViewController:viewController adSize:size]; // 聚合维度通过广告位ID发起请求；仅接入CSJ广告通过代码位ID发起请求
    self.bannerView.frame = CGRectMake((viewController.view.frame.size.width - size.width) / 2.0, viewController.view.frame.size.height - size.height - 30, size.width, size.height);
    // 使用wrapper的delegate
    self.bannerView.delegate = self;
    
    [self.bannerView loadAdData];
}

- (BUNativeExpressBannerView *)getBannerView {
    return self.bannerView;
}

#pragma mark - BUMNativeExpressFullscreenVideoAdDelegate

- (void)nativeExpressFullscreenVideoAdDidLoad:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd {
    [LogUtils i:@"Gromore Interstitial ad loaded successfully"];
}

- (void)nativeExpressFullscreenVideoAd:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd didFailWithError:(NSError *)error {
    [LogUtils e:[NSString stringWithFormat:@"Gromore Interstitial ad failed to load: %@", error.localizedDescription]];
}

- (void)nativeExpressFullscreenVideoAdDidShow:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd {
    [LogUtils i:@"Gromore Interstitial ad showed"];
    
    // Track ad impression using the new wrapper
    [GromoreAdWrapper trackInterstitialAdImpression:fullscreenVideoAd];
}

- (void)nativeExpressFullscreenVideoAdDidClick:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd {
    [LogUtils i:@"Gromore Interstitial ad clicked"];
}

- (void)nativeExpressFullscreenVideoAdDidClose:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd {
    [LogUtils i:@"Gromore Interstitial ad closed"];
}

#pragma mark - BUMNativeExpressRewardedVideoAdDelegate

- (void)nativeExpressRewardedVideoAdDidLoad:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd {
    [LogUtils i:@"Gromore Rewarded ad loaded successfully"];
}

- (void)nativeExpressRewardedVideoAd:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd didFailWithError:(NSError *)error {
    [LogUtils e:[NSString stringWithFormat:@"Gromore Rewarded ad failed to load: %@", error.localizedDescription]];
}

- (void)nativeExpressRewardedVideoAdDidShow:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd {
    [LogUtils i:@"Gromore Rewarded ad showed"];
    
    // Track ad impression using the new wrapper
    [GromoreAdWrapper trackRewardedAdImpression:rewardedVideoAd];
}

- (void)nativeExpressRewardedVideoAdDidClick:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd {
    [LogUtils i:@"Gromore Rewarded ad clicked"];
}

- (void)nativeExpressRewardedVideoAdDidClose:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd {
    [LogUtils i:@"Gromore Rewarded ad closed"];
}

- (void)nativeExpressRewardedVideoAdDidRewardSuccess:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd {
    [LogUtils i:@"Gromore Rewarded user earned reward"];
}

#pragma mark - BUMNativeExpressBannerView Delegate

- (void)bannerAdViewDidLoad:(BUNativeExpressBannerView *)bannerAdView {
    [LogUtils i:@"Gromore Banner ad loaded successfully"];
}

- (void)bannerAdView:(BUNativeExpressBannerView *)bannerAdView didFailWithError:(NSError *)error {
    [LogUtils e:[NSString stringWithFormat:@"Gromore Banner ad failed to load: %@", error.localizedDescription]];
}

- (void)bannerAdViewDidShow:(BUNativeExpressBannerView *)bannerAdView {
    [LogUtils i:@"Gromore Banner ad showed"];
    
    // Track ad impression using the new wrapper
    [GromoreAdWrapper trackBannerAdImpression:bannerAdView];
}

- (void)bannerAdViewDidClick:(BUNativeExpressBannerView *)bannerAdView {
    [LogUtils i:@"Gromore Banner ad clicked"];
}

@end
