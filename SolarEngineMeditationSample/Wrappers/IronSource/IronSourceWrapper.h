//
//  IronSourceWrapper.h
//  SolarEngineMeditationSample
//
//  Created by zhanghulk on 2025/8/28.
//

#import <Foundation/Foundation.h>
#import <IronSource/IronSource.h>

NS_ASSUME_NONNULL_BEGIN

@interface IronSourceWrapper : NSObject


+ (void)addImpressionDataDelegate:(id<LPMImpressionDataDelegate>)delegate;
+ (void)removeImpressionDataDelegate:(id<LPMImpressionDataDelegate>)delegate;

@end

NS_ASSUME_NONNULL_END
