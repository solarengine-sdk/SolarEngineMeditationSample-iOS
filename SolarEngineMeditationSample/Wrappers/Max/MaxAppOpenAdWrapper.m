//
//  MaxAppOpenAdWrapper.m
//  SolarEngineMeditationSample
//
//  Created by zhanghulk on 2025/8/29.
//

#import "MaxAppOpenAdWrapper.h"
#import "LogUtils.h"
#import "MaxSolarEngineTracker.h"
#import <AppLovinSDK/AppLovinSDK.h>

// Delegate class implementing MAAdRevenueDelegateprotocol
@interface MaxAppOpenAdRevenueProxy : NSObject <MAAdRevenueDelegate>

@property (nonatomic, weak) id<MAAdRevenueDelegate> originalDelegate;

- (instancetype)initWithOriginalDelegate:(id<MAAdRevenueDelegate>)delegate;

@end

@implementation MaxAppOpenAdRevenueProxy

- (instancetype)initWithOriginalDelegate:(id<MAAdRevenueDelegate>)delegate {
    self = [super init];
    if (self) {
        _originalDelegate = delegate;
    }
    return self;
}

#pragma mark - MAAdRevenueDelegate

- (void)didPayRevenueForAd:(MAAd *)ad {
    [LogUtils i:@"MaxAppOpenAdWrapper: Revenue paid for app open ad"];
    
    // SolarEngine tracking
    [MaxSolarEngineTracker trackAdImpressionWithAdType:MaxAdTypeSplash ad:ad];
    
    // Forward to original delegate
    if (self.originalDelegate && [self.originalDelegate respondsToSelector:@selector(didPayRevenueForAd:)]) {
        [self.originalDelegate didPayRevenueForAd:ad];
    }
}

@end

@implementation MaxAppOpenAdWrapper

+ (id<MAAdRevenueDelegate>)adRevenueDelegate:(id<MAAdRevenueDelegate>)adRevenueDelegate {
    [LogUtils i:@"MaxAppOpenAdWrapper.adRevenueDelegate() called"];
    
    // Create delegate wrapper
    MaxAppOpenAdRevenueProxy *proxy = [[MaxAppOpenAdRevenueProxy alloc] initWithOriginalDelegate:adRevenueDelegate];
    
    return proxy;
}

@end
