//
//  SolarEngineTracker.h
//  SolarEngineMeditationSample
//
//  Created by zhanghulk on 2025/8/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SolarEngineTracker : NSObject

+ (instancetype)shared;
- (void)trackAdImpressionWithAdType:(NSString *)adType adData:(NSDictionary *)adData;

@end

NS_ASSUME_NONNULL_END
