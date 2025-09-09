//
//  AdType.m
//  SolarEngineMeditationSample
//
//  Created by zhanghulk on 2025/8/27.
//

#import "AdType.h"

@implementation AdTypeHelper

+ (NSString *)stringFromAdType:(AdType)adType {
    switch (adType) {
        case AdTypeInterstitial:
            return @"interstitial";
        case AdTypeRewarded:
            return @"rewarded";
        case AdTypeBanner:
            return @"banner";
        case AdTypeNative:
            return @"native";
        case AdTypeAppOpen:
            return @"app_open";
        case AdTypeSplash:
            return @"splash";
        default:
            return @"unknown";
    }
}

+ (AdType)adTypeFromString:(NSString *)string {
    if ([string isEqualToString:@"interstitial"]) {
        return AdTypeInterstitial;
    } else if ([string isEqualToString:@"rewarded"]) {
        return AdTypeRewarded;
    } else if ([string isEqualToString:@"banner"]) {
        return AdTypeBanner;
    } else if ([string isEqualToString:@"native"]) {
        return AdTypeNative;
    } else if ([string isEqualToString:@"app_open"]) {
        return AdTypeAppOpen;
    } else if ([string isEqualToString:@"splash"]) {
        return AdTypeSplash;
    } else {
        return AdTypeInterstitial; // Default
    }
}

@end
