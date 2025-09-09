//
//  AdMobSolarEngineTracker.m
//  SolarEngineMeditationSample
//
//  Created by Assistant on 2024/01/01.
//

#import "AdMobSolarEngineTracker.h"
#import "AdMobLogUtils.h"

@implementation AdMobSolarEngineTracker

+ (void)trackAdImpressionWithAdType:(AdMobAdType)adType adValue:(GADAdValue *)adValue responseInfo:(GADResponseInfo*)responseInfo{
    [AdMobLogUtils i:[NSString stringWithFormat:@"AdMobSolarEngineTracker.trackAdImpressionWithAdType: %ld, adValue: %@", (long)adType, adValue]];

    // Extract the impression-level ad revenue data.
    NSDecimalNumber *value = adValue.value;
    NSString *currencyCode = adValue.currencyCode;

    GADAdNetworkResponseInfo *adNetworkResponseInfo = responseInfo.loadedAdNetworkResponseInfo;
    NSString *adSourceName = adNetworkResponseInfo.adSourceName;
    NSString *adSourceInstanceID = adNetworkResponseInfo.adSourceInstanceID;

    
    SEAdImpressionEventAttribute *attribute = [[SEAdImpressionEventAttribute alloc] init];
    attribute.adNetworkPlatform = adSourceName;
    attribute.adType = (int)adType;
    attribute.adNetworkAppID = @"";
    attribute.adNetworkPlacementID = adSourceInstanceID;
    attribute.mediationPlatform = @"Admob";
    attribute.currency = currencyCode;
    attribute.ecpm = value.doubleValue / 1000.0;
    attribute.rendered = YES;

    [[SolarEngineSDK sharedInstance] trackAdImpressionWithAttributes:attribute];
}

@end
