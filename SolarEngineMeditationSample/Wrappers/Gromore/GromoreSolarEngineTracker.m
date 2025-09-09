//
//  GromoreSolarEngineTracker.m
//  SolarEngineMeditationSample
//
//  Created by Assistant on 2024/01/01.
//

#import "GromoreSolarEngineTracker.h"
#import "GromoreLogUtils.h"


@implementation GromoreSolarEngineTracker

+ (void)trackAdImpressionWithAdType:(GromoreAdType)adType ritInfo:(BUMRitInfo *)info {
    [GromoreLogUtils i:[NSString stringWithFormat:@"GromoreSolarEngineTracker.trackAdImpressionWithAdType: %ld, info: %@", (long)adType, info]];
    
    SEAdImpressionEventAttribute *attribute = [[SEAdImpressionEventAttribute alloc] init];
    attribute.adNetworkPlatform = info.adnName;
    attribute.adType = (int)adType;
    attribute.adNetworkAppID = @"";
    attribute.adNetworkPlacementID = info.slotID;
    attribute.mediationPlatform = @"Gromore";
    attribute.currency = @"USD";
    if (info.ecpm) {
        double ecpm = [info.ecpm doubleValue];
        attribute.ecpm = ecpm > 0 ? ecpm:0;
    }

    attribute.rendered = YES;

    [[SolarEngineSDK sharedInstance] trackAdImpressionWithAttributes:attribute];
}

@end
