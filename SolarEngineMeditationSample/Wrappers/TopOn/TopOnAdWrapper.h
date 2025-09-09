//
//  TopOnAdWrapper.h
//  SolarEngineMeditationSample
//
//  Created by zhanghulk on 2025/8/27.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TopOnAdWrapper : NSObject

// Rewarded Ad
+ (void)trackRewardedAdRevenue:(NSString *)placementID extra:(NSDictionary *)extra;

// Interstitial Ad
+ (void)trackInterstitialAdRevenue:(NSString *)placementID extra:(NSDictionary *)extra;

// Banner Ad
+ (void)trackBannerAdRevenue:(NSString *)placementID extra:(NSDictionary *)extra;

// Native Ad
+ (void)trackNativeAdRevenue:(NSString *)placementID extra:(NSDictionary *)extra;

// Splash Ad
+ (void)trackSplashAdRevenue:(NSString *)placementID extra:(NSDictionary *)extra;

@end

NS_ASSUME_NONNULL_END
