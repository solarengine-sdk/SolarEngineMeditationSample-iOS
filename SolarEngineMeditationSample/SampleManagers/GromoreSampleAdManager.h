//
//  GromoreSampleAdManager.h
//  SolarEngineMeditationSample
//
//  Created by zhanghulk on 2025/8/27.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

// 前向声明
@class BUNativeExpressFullscreenVideoAd;
@class BUNativeExpressRewardedVideoAd;
@class BUNativeExpressBannerView;
@class ABUNativeAdView;

@interface GromoreSampleAdManager : NSObject

- (void)initializeSDK;
- (void)loadInterstitialAd;
- (void)showInterstitialAdFromViewController:(UIViewController *)viewController;
- (void)loadRewardedAd;
- (void)showRewardedAdFromViewController:(UIViewController *)viewController;
- (void)loadBannerAd:(UIViewController *)viewController;
- (BUNativeExpressBannerView *)getBannerView;

@end

NS_ASSUME_NONNULL_END
