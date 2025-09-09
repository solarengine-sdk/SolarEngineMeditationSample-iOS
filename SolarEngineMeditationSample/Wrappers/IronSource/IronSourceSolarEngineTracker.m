//
//  IronSourceSolarEngineTracker.m
//  SolarEngineMeditationSample
//
//  Created by Assistant on 2024/01/01.
//

#import "IronSourceSolarEngineTracker.h"
#import "IronSourceLogUtils.h"

// IronSourceAd type enum
typedef NS_ENUM(NSInteger, IronSourceAdType) {
    IronSourceAdTypeOther = 0,           // Other
    IronSourceAdTypeRewardVideo = 1,     // Rewarded Video
    IronSourceAdTypeSplash = 2,          // Splash
    IronSourceAdTypeInterstitial = 3,    // Interstitial
    IronSourceAdTypeFullScreenVideo = 4, // Full Screen Video
    IronSourceAdTypeBanner = 5,          // Banner
    IronSourceAdTypeNative = 6,          // Native Feed
    IronSourceAdTypeShortVideoFeed = 7,  // 短视频Native Feed
    IronSourceAdTypeLargeBanner = 8,     // Large Banner
    IronSourceAdTypeVideoPatch = 9,      // Video Patch
    IronSourceAdTypeMediumBanner = 10    // Medium Banner
};

@implementation IronSourceSolarEngineTracker

+ (void)trackAdImpression:(LPMImpressionData *)impressionData{

    [IronSourceLogUtils i:[NSString stringWithFormat:@"IronSourceSolarEngineTracker.trackAdImpression"]];
    
    // SolarEngine tracking

    // 根据广告类型进行埋点
    IronSourceAdType adType = IronSourceAdTypeOther;
    
    if (impressionData.adFormat) {
        NSString *format = [impressionData.adFormat lowercaseString];
        if ([format containsString:@"interstitial"]) {
            adType = IronSourceAdTypeInterstitial;
        } else if ([format containsString:@"rewarded"] || [format containsString:@"reward"]) {
            adType = IronSourceAdTypeRewardVideo;
        } else if ([format containsString:@"banner"]) {
            adType = IronSourceAdTypeBanner;
        } else if ([format containsString:@"native"]) {
            adType = IronSourceAdTypeNative;
        } else if ([format containsString:@"splash"] || ([format containsString:@"appopen"])){
            adType = IronSourceAdTypeSplash;
        }
    }


    SEAdImpressionEventAttribute *attribute = [[SEAdImpressionEventAttribute alloc] init];
    attribute.adNetworkPlatform = impressionData.adNetwork;
    attribute.adType = (int)adType; 
    attribute.adNetworkAppID = @"";
    attribute.adNetworkPlacementID = impressionData.instanceId;
    attribute.mediationPlatform = @"IronSource";
    attribute.currency = @"USD";
    attribute.ecpm = [impressionData.revenue doubleValue] * 1000;
    attribute.rendered = YES;

    [[SolarEngineSDK sharedInstance] trackAdImpressionWithAttributes:attribute];
}

@end
