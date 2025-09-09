//
//  MaxConfig.m
//  SolarEngineMeditationSample
//
//  Created by zhanghulk on 2025/8/27.
//

#import "MaxConfig.h"
#import "AdType.h"

@implementation MaxConfig

+ (instancetype)shared {
    static MaxConfig *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (NSString *)getAdUnitIdForAdType:(AdType)adType {
    NSDictionary *adUnitIds = @{
        @(AdTypeInterstitial): @"YOUR_MAX_INTERSTITIAL_AD_UNIT_ID", // Replace with actual ID
        @(AdTypeRewarded): @"YOUR_MAX_REWARDED_AD_UNIT_ID", // Replace with actual ID
        @(AdTypeBanner): @"YOUR_MAX_BANNER_AD_UNIT_ID", // Replace with actual ID
        @(AdTypeNative): @"YOUR_MAX_NATIVE_AD_UNIT_ID" // Replace with actual ID
    };
    
    return adUnitIds[@(adType)] ?: @"";
}

@end
