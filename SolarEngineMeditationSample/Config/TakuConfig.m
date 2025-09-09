//
//  TakuConfig.m
//  SolarEngineMeditationSample
//
//  Created by zhanghulk on 2025/8/27.
//

#import "TakuConfig.h"
#import "AdType.h"

@implementation TakuConfig

+ (instancetype)shared {
    static TakuConfig *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (NSString *)getAdUnitIdForAdType:(AdType)adType {
    NSDictionary *adUnitIds = @{
        @(AdTypeInterstitial): @"YOUR_TAKU_INTERSTITIAL_AD_UNIT_ID", // Replace with actual ID
        @(AdTypeRewarded): @"YOUR_TAKU_REWARDED_AD_UNIT_ID", // Replace with actual ID
        @(AdTypeBanner): @"YOUR_TAKU_BANNER_AD_UNIT_ID", // Replace with actual ID
        @(AdTypeNative): @"YOUR_TAKU_NATIVE_AD_UNIT_ID" // Replace with actual ID
    };
    
    return adUnitIds[@(adType)] ?: @"";
}

@end
