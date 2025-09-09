//
//  MaxInterstitialAdWrapper.h
//  SolarEngineMeditationSample
//
//  Created by zhanghulk on 2025/8/27.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AppLovinSDK/AppLovinSDK.h>

NS_ASSUME_NONNULL_BEGIN


@interface MaxInterstitialAdWrapper : NSObject

+ (id<MAAdRevenueDelegate>)adRevenueDelegate:(id<MAAdRevenueDelegate>)adRevenueDelegate;

@end

NS_ASSUME_NONNULL_END
