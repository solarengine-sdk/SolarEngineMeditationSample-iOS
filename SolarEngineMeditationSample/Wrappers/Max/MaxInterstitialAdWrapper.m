//
//  MaxInterstitialAdWrapper.m
//  SolarEngineMeditationSample
//
//  Created by zhanghulk on 2025/8/27.
//

#import "MaxInterstitialAdWrapper.h"
#import "LogUtils.h"
#import "MaxSolarEngineTracker.h"
#import <AppLovinSDK/AppLovinSDK.h>

// Delegate class implementing MAAdRevenueDelegateprotocol
@interface MaxInterstitialAdRevenueProxy : NSObject <MAAdRevenueDelegate>

@property (nonatomic, weak) id<MAAdRevenueDelegate> originalDelegate;

- (instancetype)initWithOriginalDelegate:(id<MAAdRevenueDelegate>)delegate;

@end

@implementation MaxInterstitialAdRevenueProxy

- (instancetype)initWithOriginalDelegate:(id<MAAdRevenueDelegate>)delegate {
    self = [super init];
    if (self) {
        _originalDelegate = delegate;
    }
    return self;
}

#pragma mark - MAAdRevenueDelegate

- (void)didPayRevenueForAd:(MAAd *)ad {
    [LogUtils i:@"MaxInterstitialAdWrapper: Revenue paid for interstitial ad"];
    
    // SolarEngine tracking    
    [MaxSolarEngineTracker trackAdImpressionWithAdType:MaxAdTypeInterstitial ad:ad];
    
    // Forward to original delegate
    if (self.originalDelegate && [self.originalDelegate respondsToSelector:@selector(didPayRevenueForAd:)]) {
        [self.originalDelegate didPayRevenueForAd:ad];
    }
}

@end

@implementation MaxInterstitialAdWrapper

+ (id<MAAdRevenueDelegate>)adRevenueDelegate:(id<MAAdRevenueDelegate>)adRevenueDelegate {
    [LogUtils i:@"MaxInterstitialAdWrapper.adRevenueDelegate() called"];
    
    // Create delegate wrapper
    MaxInterstitialAdRevenueProxy *proxy = [[MaxInterstitialAdRevenueProxy alloc] initWithOriginalDelegate:adRevenueDelegate];
    
    return proxy;
}

@end
