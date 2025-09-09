//
//  AdMobAdWrapper.h
//  SolarEngineMeditationSample
//
//  Created by zhanghulk on 2025/8/27.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <GoogleMobileAds/GoogleMobileAds.h>

NS_ASSUME_NONNULL_BEGIN

// Forward declaration to avoid circular reference
@class GADAdValue;

typedef void(^AdMobOnPaidEventBlock)(GADAdValue *adValue);

@interface AdMobAdWrapper : NSObject

// Rewarded Ad
+ (AdMobOnPaidEventBlock)rewardedAdOnPaidEventBlock:(AdMobOnPaidEventBlock)userListener responseInfo:(GADResponseInfo*)responseInfo;

// Interstitial Ad
+ (AdMobOnPaidEventBlock)interstitialAdOnPaidEventBlock:(AdMobOnPaidEventBlock)userListener responseInfo:(GADResponseInfo*)responseInfo;

// Banner Ad
+ (AdMobOnPaidEventBlock)bannerAdOnPaidEventBlock:(AdMobOnPaidEventBlock)userListener responseInfo:(GADResponseInfo*)responseInfo;

// Native Ad
+ (AdMobOnPaidEventBlock)nativeAdOnPaidEventBlock:(AdMobOnPaidEventBlock)userListener responseInfo:(GADResponseInfo*)responseInfo;

// App Open Ad
+ (AdMobOnPaidEventBlock)appOpenAdOnPaidEventBlock:(AdMobOnPaidEventBlock)userListener responseInfo:(GADResponseInfo*)responseInfo;

@end

NS_ASSUME_NONNULL_END
