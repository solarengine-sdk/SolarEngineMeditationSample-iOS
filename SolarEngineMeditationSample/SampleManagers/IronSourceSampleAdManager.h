//
//  IronSourceSampleAdManager.h
//  SolarEngineMeditationSample
//
//  Created by zhanghulk on 2025/8/27.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <IronSource/IronSource.h>

NS_ASSUME_NONNULL_BEGIN

// 前向声明
@class ISAdInfo;

@interface IronSourceSampleAdManager : NSObject

- (void)initializeSDK;
- (void)loadInterstitialAd;
- (void)showInterstitialAdFromViewController:(UIViewController *)viewController;
- (void)loadRewardedAd;
- (void)showRewardedAdFromViewController:(UIViewController *)viewController;
- (void)loadBannerAdFromViewController:(UIViewController *)viewController;

-(LPMBannerAdView *)getBannerView;
@end

NS_ASSUME_NONNULL_END
