//
//  MaxRewardedAdWrapper.m
//  SolarEngineMeditationSample
//
//  Created by zhanghulk on 2025/8/27.
//

#import "MaxRewardedAdWrapper.h"
#import "LogUtils.h"
#import "MaxSolarEngineTracker.h"

// Delegate class implementing MAAdRevenueDelegateprotocol
@interface MaxRewardedAdRevenueProxy : NSObject <MAAdRevenueDelegate>

@property (nonatomic, weak) id<MAAdRevenueDelegate> originalDelegate;

- (instancetype)initWithOriginalDelegate:(id<MAAdRevenueDelegate>)delegate;

@end

@implementation MaxRewardedAdRevenueProxy

- (instancetype)initWithOriginalDelegate:(id<MAAdRevenueDelegate>)delegate {
    self = [super init];
    if (self) {
        _originalDelegate = delegate;
    }
    return self;
}

#pragma mark - MAAdRevenueDelegate

- (void)didPayRevenueForAd:(MAAd *)ad {
    [LogUtils i:@"MaxRewardedAdWrapper: Revenue paid for rewarded ad"];
    
    // SolarEngine tracking
    [MaxSolarEngineTracker trackAdImpressionWithAdType:MaxAdTypeRewardVideo ad:ad];
    
    // Forward to original delegate
    if (self.originalDelegate && [self.originalDelegate respondsToSelector:@selector(didPayRevenueForAd:)]) {
        [self.originalDelegate didPayRevenueForAd:ad];
    }
}

@end

@implementation MaxRewardedAdWrapper

+ (id<MAAdRevenueDelegate>)adRevenueDelegate:(id<MAAdRevenueDelegate>)adRevenueDelegate {
    [LogUtils i:@"MaxRewardedAdWrapper.adRevenueDelegate() called"];
    
    // Create delegate wrapper
    MaxRewardedAdRevenueProxy *proxy = [[MaxRewardedAdRevenueProxy alloc] initWithOriginalDelegate:adRevenueDelegate];
    
    return proxy;
}

@end
