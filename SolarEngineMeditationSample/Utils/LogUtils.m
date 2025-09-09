//
//  LogUtils.m
//  SolarEngineMeditationSample
//
//  Created by zhanghulk on 2025/8/27.
//

#import "LogUtils.h"

@implementation LogUtils

static NSString *const kTag = @"SolarEngine";

+ (void)i:(NSString *)message {
    NSLog(@"[%@] [INFO] %@", kTag, message);
}

+ (void)w:(NSString *)message {
    NSLog(@"[%@] [WARN] %@", kTag, message);
}

+ (void)e:(NSString *)message {
    NSLog(@"[%@] [ERROR] %@", kTag, message);
}

+ (void)d:(NSString *)message {
    NSLog(@"[%@] [DEBUG] %@", kTag, message);
}

@end
