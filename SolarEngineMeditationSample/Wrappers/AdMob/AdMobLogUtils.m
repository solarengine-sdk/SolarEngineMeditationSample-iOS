//
//  AdMobLogUtils.m
//  SolarEngineMeditationSample
//
//  Created by Assistant on 2024/01/01.
//

#import "AdMobLogUtils.h"

@implementation AdMobLogUtils

+ (void)d:(NSString *)message {
    NSLog(@"[AdMob][DEBUG] %@", message);
}

+ (void)i:(NSString *)message {
    NSLog(@"[AdMob][INFO] %@", message);
}

+ (void)w:(NSString *)message {
    NSLog(@"[AdMob][WARN] %@", message);
}

+ (void)e:(NSString *)message {
    NSLog(@"[AdMob][ERROR] %@", message);
}

@end
