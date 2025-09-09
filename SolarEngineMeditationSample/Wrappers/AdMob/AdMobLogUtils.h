//
//  AdMobLogUtils.h
//  SolarEngineMeditationSample
//
//  Created by Assistant on 2024/01/01.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AdMobLogUtils : NSObject

+ (void)d:(NSString *)message;
+ (void)i:(NSString *)message;
+ (void)w:(NSString *)message;
+ (void)e:(NSString *)message;

@end

NS_ASSUME_NONNULL_END
