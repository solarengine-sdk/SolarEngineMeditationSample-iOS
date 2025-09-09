//
//  MaxBannerAdWrapper.m
//  SolarEngineMeditationSample
//
//  Created by zhanghulk on 2025/8/27.
//

#import "MaxBannerAdWrapper.h"
#import "LogUtils.h"
#import "MaxSolarEngineTracker.h"
#import <AppLovinSDK/AppLovinSDK.h>

// Delegate class implementing MAAdRevenueDelegateprotocol
@interface MaxBannerAdRevenueProxy : NSObject <MAAdRevenueDelegate>

@property (nonatomic, weak) id<MAAdRevenueDelegate> originalDelegate;

- (instancetype)initWithOriginalDelegate:(id<MAAdRevenueDelegate>)delegate;

@end

@implementation MaxBannerAdRevenueProxy

- (instancetype)initWithOriginalDelegate:(id<MAAdRevenueDelegate>)delegate {
    self = [super init];
    if (self) {
        _originalDelegate = delegate;
    }
    return self;
}

#pragma mark - MAAdRevenueDelegate

- (void)didPayRevenueForAd:(MAAd *)ad {
    [LogUtils i:@"MaxBannerAdWrapper: Revenue paid for banner ad"];
    
    // SolarEngine tracking
    [MaxSolarEngineTracker trackAdImpressionWithAdType:MaxAdTypeBanner ad:ad];
    
    // Forward to original delegate
    if (self.originalDelegate && [self.originalDelegate respondsToSelector:@selector(didPayRevenueForAd:)]) {
        [self.originalDelegate didPayRevenueForAd:ad];
    }
}

@end

@implementation MaxBannerAdWrapper

+ (id<MAAdRevenueDelegate>)adRevenueDelegate:(id<MAAdRevenueDelegate>)adRevenueDelegate {
    [LogUtils i:@"MaxBannerAdWrapper.adRevenueDelegate() called"];
    
    // Create delegate wrapper
    MaxBannerAdRevenueProxy *proxy = [[MaxBannerAdRevenueProxy alloc] initWithOriginalDelegate:adRevenueDelegate];
    
    return proxy;
}

@end
