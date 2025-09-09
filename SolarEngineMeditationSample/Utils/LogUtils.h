//
//  LogUtils.h
//  SolarEngineMeditationSample
//
//  Created by zhanghulk on 2025/8/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LogUtils : NSObject

+ (void)i:(NSString *)message;
+ (void)w:(NSString *)message;
+ (void)e:(NSString *)message;
+ (void)d:(NSString *)message;

@end

NS_ASSUME_NONNULL_END
