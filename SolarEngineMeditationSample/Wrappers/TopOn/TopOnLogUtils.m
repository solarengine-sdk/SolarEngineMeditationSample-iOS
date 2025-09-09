//
//  TopOnLogUtils.m
//  SolarEngineMeditationSample
//
//  Created by Assistant on 2024/01/01.
//

#import "TopOnLogUtils.h"

@implementation TopOnLogUtils

+ (void)d:(NSString *)message {
    NSLog(@"[TopOn][DEBUG] %@", message);
}

+ (void)i:(NSString *)message {
    NSLog(@"[TopOn][INFO] %@", message);
}

+ (void)w:(NSString *)message {
    NSLog(@"[TopOn][WARN] %@", message);
}

+ (void)e:(NSString *)message {
    NSLog(@"[TopOn][ERROR] %@", message);
}

@end
