//
//  TopOnSolarEngineTracker.m
//  SolarEngineMeditationSample
//
//  Created by Assistant on 2024/01/01.
//

#import "TopOnSolarEngineTracker.h"
#import "TopOnLogUtils.h"
typedef NS_ENUM(NSInteger, TopOnNetworkID) {
    Meta = 1,
    Admob = 2,
    Inmobi = 3,
    Applovin = 5,
    Mintegral = 6,
    Tencent = 8,
    Chartboost = 9,
    IronSource = 11,
    Liftoff = 13,
    CSJ = 15,
    Baidu = 22,
    Nend = 23,
    Maio = 24,
    StartIO = 25,
    KuaiShou = 28,
    Sigmob = 29,
    MyTarget = 32,
    GoogleAdManager = 33,
    Yandex = 34,
    Ogury = 36,
    Fyber = 37,
    Huawei = 39,
    Helium = 40,
    Kidoz = 45,
    A4G_Admob = 48,
    MiUion = 49,
    Pangle = 50,
    ReklamUp = 57,
    VerveGroup = 58,
    BigoAds = 59,
    Bidmachine = 65,
    TapTap = 69
    //
};


@implementation TopOnSolarEngineTracker

+ (NSString *)networkNameWithFirmID:(NSString *)network_firm_id{
    
    int network_firm_id_int = [network_firm_id intValue];
    NSString *adNetworkPlatform = @"";
    if (network_firm_id_int == Meta) {
        adNetworkPlatform = @"Meta";
    } else if (network_firm_id_int == Admob) {
        adNetworkPlatform = @"Admob";
    } else if (network_firm_id_int == Inmobi) {
        adNetworkPlatform = @"Inmobi";
    } else if (network_firm_id_int == Applovin) {
        adNetworkPlatform = @"Applovin";
    } else if (network_firm_id_int == Mintegral) {
        adNetworkPlatform = @"Mintegral";
    } else if (network_firm_id_int == Tencent) {
        adNetworkPlatform = @"Tencent";
    } else if (network_firm_id_int == Chartboost) {
        adNetworkPlatform = @"Chartboost";
    } else if (network_firm_id_int == IronSource) {
        adNetworkPlatform = @"IronSource";
    } else if (network_firm_id_int == Liftoff) {
        adNetworkPlatform = @"Liftoff";
    } else if (network_firm_id_int == CSJ) {
        adNetworkPlatform = @"CSJ";
    } else if (network_firm_id_int == Baidu) {
        adNetworkPlatform = @"Baidu";
    } else if (network_firm_id_int == Nend) {
        adNetworkPlatform = @"Nend";
    } else if (network_firm_id_int == Maio) {
        adNetworkPlatform = @"Maio";
    } else if (network_firm_id_int == StartIO) {
        adNetworkPlatform = @"StartIO";
    } else if (network_firm_id_int == KuaiShou) {
        adNetworkPlatform = @"KuaiShou";
    } else if (network_firm_id_int == Sigmob) {
        adNetworkPlatform = @"Sigmob";
    } else if (network_firm_id_int == MyTarget) {
        adNetworkPlatform = @"MyTarget";
    } else if (network_firm_id_int == GoogleAdManager) {
        adNetworkPlatform = @"GoogleAdManager";
    } else if (network_firm_id_int == Yandex) {
        adNetworkPlatform = @"Yandex";
    } else if (network_firm_id_int == Ogury) {
        adNetworkPlatform = @"Ogury";
    } else if (network_firm_id_int == Fyber) {
        adNetworkPlatform = @"Fyber";
    } else if (network_firm_id_int == Huawei) {
        adNetworkPlatform = @"Huawei";
    } else if (network_firm_id_int == Helium) {
        adNetworkPlatform = @"Helium";
    } else if (network_firm_id_int == Kidoz) {
        adNetworkPlatform = @"Kidoz";
    } else if (network_firm_id_int == A4G_Admob) {
        adNetworkPlatform = @"A4G_Admob";
    } else if (network_firm_id_int == MiUion) {
        adNetworkPlatform = @"MiUion";
    } else if (network_firm_id_int == Pangle) {
        adNetworkPlatform = @"Pangle";
    } else if (network_firm_id_int == ReklamUp) {
        adNetworkPlatform = @"ReklamUp";
    } else if (network_firm_id_int == VerveGroup) {
        adNetworkPlatform = @"VerveGroup";
    } else if (network_firm_id_int == BigoAds) {
        adNetworkPlatform = @"BigoAds";
    } else if (network_firm_id_int == Bidmachine) {
        adNetworkPlatform = @"Bidmachine";
    } else if (network_firm_id_int == TapTap) {
        adNetworkPlatform = @"TapTap";
    }else{
        NSAssert(false, @"unknow network_id, you should check it here");
    }
    return adNetworkPlatform;
}
+ (void)trackAdImpressionWithAdType:(TopOnAdType)adType extra:(NSDictionary *)extra {
    [TopOnLogUtils i:[NSString stringWithFormat:@"TopOnSolarEngineTracker.trackAdImpressionWithAdType: %ld, adData: %@", (long)adType, extra]];
    
    double price = [extra[@"publisher_revenue"] doubleValue];
    
    //network_firm_idDetailed docs: https://help.takuad.com/docs/2KR6QU#TopOn_%E6%94%AF%E6%8C%81%E8%81%9A%E5%90%88%E4%BB%A5%E4%B8%8B%E5%B9%BF%E5%91%8A%E5%B9%B3%E5%8F%B0
    
    NSString *network_firm_id = extra[@"network_firm_id"];
    SEAdImpressionEventAttribute *attribute = [[SEAdImpressionEventAttribute alloc] init];
    attribute.adNetworkPlatform = [self networkNameWithFirmID:network_firm_id];
    attribute.adType = (int)adType;
    attribute.adNetworkAppID = @"";
    attribute.adNetworkPlacementID = extra[@"network_placement_id"] ;
    attribute.mediationPlatform = @"Topon";
    attribute.currency = extra[@"currency"];
    attribute.ecpm = price;
    attribute.rendered = YES;


    [[SolarEngineSDK sharedInstance] trackAdImpressionWithAttributes:attribute];
}

@end
