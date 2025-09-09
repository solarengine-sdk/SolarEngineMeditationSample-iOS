//
//  MaxAppOpenAdWrapper.h
//  SolarEngineMeditationSample
//
//  Created by zhanghulk on 2025/8/29.
//

#import <Foundation/Foundation.h>
#import <AppLovinSDK/AppLovinSDK.h>

NS_ASSUME_NONNULL_BEGIN

@interface MaxAppOpenAdWrapper : NSObject

+ (id<MAAdRevenueDelegate>)adRevenueDelegate:(id<MAAdRevenueDelegate>)adRevenueDelegate;

@end

NS_ASSUME_NONNULL_END
