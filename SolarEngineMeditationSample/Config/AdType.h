//
//  AdType.h
//  SolarEngineMeditationSample
//
//  Created by zhanghulk on 2025/8/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, AdType) {
    AdTypeInterstitial = 0,
    AdTypeRewarded,
    AdTypeBanner,
    AdTypeNative,
    AdTypeAppOpen,
    AdTypeSplash
};

@interface AdTypeHelper : NSObject

+ (NSString *)stringFromAdType:(AdType)adType;
+ (AdType)adTypeFromString:(NSString *)string;

@end

NS_ASSUME_NONNULL_END
