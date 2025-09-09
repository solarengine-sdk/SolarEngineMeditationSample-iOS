//
//  IronSourceWrapper.m
//  SolarEngineMeditationSample
//
//  Created by zhanghulk on 2025/8/28.
//

#import "IronSourceWrapper.h"
#import "LogUtils.h"
#import "IronSourceSolarEngineTracker.h"



@interface IronSourceWrapper ()<LPMImpressionDataDelegate>
@end

@implementation IronSourceWrapper

static id<LPMImpressionDataDelegate> originalDelegate = NULL;
static BOOL delegateHeld = false;

+ (instancetype)shared {
    static IronSourceWrapper *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}


+ (void)addImpressionDataDelegate:(id<LPMImpressionDataDelegate>)delegate{
    
    if (delegateHeld == false) {
        [LevelPlay addImpressionDataDelegate:[IronSourceWrapper shared]];
        delegateHeld = true;
    }
    originalDelegate = delegate;
}

+ (void)removeImpressionDataDelegate:(id<LPMImpressionDataDelegate>)delegate {
    [LogUtils i:@"IronSourceWrapper.removeImpressionDataDelegate() called"];
    
    [LevelPlay removeImpressionDataDelegate:[IronSourceWrapper shared]];
    originalDelegate = NULL;
}

- (void)impressionDataDidSucceed:(LPMImpressionData *)impressionData {
    
    [LogUtils i:@"IronSourceWrapper impressionDataDidSucceed()"];
    [IronSourceSolarEngineTracker trackAdImpression:impressionData];
    
    if (originalDelegate && [originalDelegate respondsToSelector:@selector(impressionDataDidSucceed:)]) {
        [originalDelegate impressionDataDidSucceed:impressionData];
    }
}

@end
