//
//  IronSourceSolarEngineTracker.h
//  SolarEngineMeditationSample
//
//  Created by Assistant on 2024/01/01.
//

#import <Foundation/Foundation.h>
#import <SolarEngineSDK/SolarEngineSDK.h>
#import <IronSource/IronSource.h>

NS_ASSUME_NONNULL_BEGIN



@interface IronSourceSolarEngineTracker : NSObject

+ (void)trackAdImpression:(LPMImpressionData *)impressionData;

@end

NS_ASSUME_NONNULL_END
