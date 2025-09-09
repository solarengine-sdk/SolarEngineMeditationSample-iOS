//
//  TakuConfig.h
//  SolarEngineMeditationSample
//
//  Created by zhanghulk on 2025/8/27.
//

#import <Foundation/Foundation.h>
#import "AdType.h"

NS_ASSUME_NONNULL_BEGIN

@interface TakuConfig : NSObject

+ (instancetype)shared;
- (NSString *)getAdUnitIdForAdType:(AdType)adType;

@end

NS_ASSUME_NONNULL_END
