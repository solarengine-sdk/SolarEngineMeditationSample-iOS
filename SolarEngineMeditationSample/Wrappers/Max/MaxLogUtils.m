//
//  MaxLogUtils.m
//  SolarEngineMeditationSample
//
//  Created by Assistant on 2024/01/01.
//

#import "MaxLogUtils.h"

@implementation MaxLogUtils

+ (void)d:(NSString *)message {
    NSLog(@"[MAX][DEBUG] %@", message);
}

+ (void)i:(NSString *)message {
    NSLog(@"[MAX][INFO] %@", message);
}

+ (void)w:(NSString *)message {
    NSLog(@"[MAX][WARN] %@", message);
}

+ (void)e:(NSString *)message {
    NSLog(@"[MAX][ERROR] %@", message);
}

@end
