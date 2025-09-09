//
//  MaxSolarEngineTracker.m
//  SolarEngineMeditationSample
//
//  Created by Assistant on 2024/01/01.
//

#import "MaxSolarEngineTracker.h"
#import "MaxLogUtils.h"

@implementation MaxSolarEngineTracker

+ (void)trackAdImpressionWithAdType:(MaxAdType)adType ad:(MAAd *)ad{
    [MaxLogUtils i:[NSString stringWithFormat:@"MaxSolarEngineTracker.trackAdImpressionWithAdType: %ld, adData: %@", (long)adType, ad]];

      double revenue = ad.revenue; // In USD

      // Miscellaneous data
      NSString *networkName = ad.networkName; // Display name of the network that showed the ad
      NSString *networkPlacement = ad.networkPlacement; // The placement ID from the network that showed the ad
    
    SEAdImpressionEventAttribute *attribute = [[SEAdImpressionEventAttribute alloc] init];
    attribute.adNetworkPlatform = networkName;
    attribute.adType = (int)adType;
    attribute.adNetworkAppID = @"";
    attribute.adNetworkPlacementID = networkPlacement;
    attribute.mediationPlatform = @"Max";
    attribute.currency = @"USD";
    attribute.ecpm = revenue * 0.01;
    attribute.rendered = YES;

    [[SolarEngineSDK sharedInstance] trackAdImpressionWithAttributes:attribute];
}

@end
