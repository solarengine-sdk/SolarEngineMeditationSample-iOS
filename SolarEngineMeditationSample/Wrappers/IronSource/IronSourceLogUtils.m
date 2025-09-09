//
//  IronSourceLogUtils.m
//  SolarEngineMeditationSample
//
//  Created by Assistant on 2024/01/01.
//

#import "IronSourceLogUtils.h"

@implementation IronSourceLogUtils

+ (void)d:(NSString *)message {
    NSLog(@"[IronSource][DEBUG] %@", message);
}

+ (void)i:(NSString *)message {
    NSLog(@"[IronSource][INFO] %@", message);
}

+ (void)w:(NSString *)message {
    NSLog(@"[IronSource][WARN] %@", message);
}

+ (void)e:(NSString *)message {
    NSLog(@"[IronSource][ERROR] %@", message);
}

@end
