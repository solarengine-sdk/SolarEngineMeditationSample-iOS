//
//  GromoreConfig.m
//  SolarEngineMeditationSample
//
//  Created by zhanghulk on 2025/8/27.
//

#import "GromoreConfig.h"
#import "AdType.h"

@implementation GromoreConfig

+ (instancetype)shared {
    static GromoreConfig *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (NSString *)getAdUnitIdForAdType:(AdType)adType {
    NSDictionary *adUnitIds = @{
        @(AdTypeInterstitial): @"YOUR_GROMORE_INTERSTITIAL_AD_UNIT_ID", // Replace with actual ID
        @(AdTypeRewarded): @"YOUR_GROMORE_REWARDED_AD_UNIT_ID", // Replace with actual ID
        @(AdTypeBanner): @"YOUR_GROMORE_BANNER_AD_UNIT_ID", // Replace with actual ID
        @(AdTypeNative): @"YOUR_GROMORE_NATIVE_AD_UNIT_ID" // Replace with actual ID
    };
    
    return adUnitIds[@(adType)] ?: @"";
}

@end
