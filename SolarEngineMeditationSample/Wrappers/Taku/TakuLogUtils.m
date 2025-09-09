//
//  TakuLogUtils.m
//  SolarEngineMeditationSample
//
//  Created by Assistant on 2024/01/01.
//

#import "TakuLogUtils.h"

@implementation TakuLogUtils

+ (void)d:(NSString *)message {
    NSLog(@"[Taku][DEBUG] %@", message);
}

+ (void)i:(NSString *)message {
    NSLog(@"[Taku][INFO] %@", message);
}

+ (void)w:(NSString *)message {
    NSLog(@"[Taku][WARN] %@", message);
}

+ (void)e:(NSString *)message {
    NSLog(@"[Taku][ERROR] %@", message);
}

@end
