//
//  SolarEngineTracker.m
//  SolarEngineMeditationSample
//
//  Created by zhanghulk on 2025/8/27.
//

#import "SolarEngineTracker.h"
#import "LogUtils.h"

@implementation SolarEngineTracker

+ (instancetype)shared {
    static SolarEngineTracker *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (void)trackAdImpressionWithAdType:(NSString *)adType adData:(NSDictionary *)adData {
    [LogUtils i:[NSString stringWithFormat:@"SolarEngine tracking ad impression - Type: %@, Data: %@", adType, adData]];
    // 这里实现实际的SolarEngine tracking逻辑
}

@end
