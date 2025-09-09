//
//  GromoreLogUtils.m
//  SolarEngineMeditationSample
//
//  Created by Assistant on 2024/01/01.
//

#import "GromoreLogUtils.h"

@implementation GromoreLogUtils

+ (void)d:(NSString *)message {
    NSLog(@"[Gromore][DEBUG] %@", message);
}

+ (void)i:(NSString *)message {
    NSLog(@"[Gromore][INFO] %@", message);
}

+ (void)w:(NSString *)message {
    NSLog(@"[Gromore][WARN] %@", message);
}

+ (void)e:(NSString *)message {
    NSLog(@"[Gromore][ERROR] %@", message);
}

@end
