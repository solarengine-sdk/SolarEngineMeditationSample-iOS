//
//  MaxNativeAdWrapper.m
//  SolarEngineMeditationSample
//
//  Created by zhanghulk on 2025/8/27.
//

#import "MaxNativeAdWrapper.h"
#import "LogUtils.h"
#import "MaxSolarEngineTracker.h"
#import <AppLovinSDK/AppLovinSDK.h>

// Delegate class implementing MAAdRevenueDelegateprotocol
@interface MaxNativeAdRevenueProxy : NSObject <MAAdRevenueDelegate>

@property (nonatomic, weak) id<MAAdRevenueDelegate> originalDelegate;

- (instancetype)initWithOriginalDelegate:(id<MAAdRevenueDelegate>)delegate;

@end

@implementation MaxNativeAdRevenueProxy

- (instancetype)initWithOriginalDelegate:(id<MAAdRevenueDelegate>)delegate {
    self = [super init];
    if (self) {
        _originalDelegate = delegate;
    }
    return self;
}

#pragma mark - MAAdRevenueDelegate

- (void)didPayRevenueForAd:(MAAd *)ad {
    [LogUtils i:@"MaxNativeAdWrapper: Revenue paid for native ad"];
    
    // SolarEngine tracking
    [MaxSolarEngineTracker trackAdImpressionWithAdType:MaxAdTypeNative ad:ad];
    
    // Forward to original delegate
    if (self.originalDelegate && [self.originalDelegate respondsToSelector:@selector(didPayRevenueForAd:)]) {
        [self.originalDelegate didPayRevenueForAd:ad];
    }
}

@end

@implementation MaxNativeAdWrapper

+ (id<MAAdRevenueDelegate>)adRevenueDelegate:(id<MAAdRevenueDelegate>)adRevenueDelegate {
    [LogUtils i:@"MaxNativeAdWrapper.adRevenueDelegate() called"];
    
    // Create delegate wrapper
    MaxNativeAdRevenueProxy *proxy = [[MaxNativeAdRevenueProxy alloc] initWithOriginalDelegate:adRevenueDelegate];
    
    return proxy;
}

@end
