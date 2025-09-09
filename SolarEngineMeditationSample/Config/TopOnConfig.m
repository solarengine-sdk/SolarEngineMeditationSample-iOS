//
//  TopOnConfig.m
//  SolarEngineMeditationSample
//
//  Created by zhanghulk on 2025/8/27.
//

#import "TopOnConfig.h"
#import "AdType.h"

@implementation TopOnConfig

+ (instancetype)shared {
    static TopOnConfig *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (NSString *)getAdUnitIdForAdType:(AdType)adType {
    NSDictionary *adUnitIds = @{
        @(AdTypeInterstitial): @"YOUR_TOPON_INTERSTITIAL_AD_UNIT_ID", // Replace with actual ID
        @(AdTypeRewarded): @"YOUR_TOPON_REWARDED_AD_UNIT_ID", // Replace with actual ID
        @(AdTypeBanner): @"YOUR_TOPON_BANNER_AD_UNIT_ID", // Replace with actual ID
        @(AdTypeNative): @"YOUR_TOPON_NATIVE_AD_UNIT_ID" // Replace with actual ID
    };
    
    return adUnitIds[@(adType)] ?: @"";
}

@end
