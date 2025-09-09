//
//  AdMobConfig.m
//  SolarEngineMeditationSample
//
//  Created by zhanghulk on 2025/8/27.
//

#import "AdMobConfig.h"
#import "AdType.h"

@implementation AdMobConfig

+ (instancetype)shared {
    static AdMobConfig *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (NSString *)getAdUnitIdForAdType:(AdType)adType {
    NSDictionary *adUnitIds = @{
        @(AdTypeInterstitial): @"ca-app-pub-3940256099942544/4411468910", // Test ID
        @(AdTypeRewarded): @"ca-app-pub-3940256099942544/1712485313", // Test ID
        @(AdTypeBanner): @"ca-app-pub-3940256099942544/2934735716", // Test ID
        @(AdTypeNative): @"ca-app-pub-3940256099942544/3985214057", // Test ID
        @(AdTypeAppOpen): @"ca-app-pub-3940256099942544/5572853021" // Test ID
    };
    
    return adUnitIds[@(adType)] ?: @"";
}

@end
