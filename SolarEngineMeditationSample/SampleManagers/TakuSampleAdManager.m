//
//  TakuSampleAdManager.m
//  SolarEngineMeditationSample
//
//  Created by zhanghulk on 2025/8/27.
//

#import "TakuSampleAdManager.h"
#import "TakuConfig.h"

#import "TakuAdWrapper.h"

#import "LogUtils.h"
#import <AnyThinkSDK/AnyThinkSDK.h>
#import <AnyThinkInterstitial/AnyThinkInterstitial.h>
#import <AnyThinkRewardedVideo/AnyThinkRewardedVideo.h>
#import <AnyThinkBanner/AnyThinkBanner.h>

@interface TakuSampleAdManager () <ATAdLoadingDelegate, ATInterstitialDelegate, ATRewardedVideoDelegate, ATBannerDelegate>

@property (nonatomic, strong) ATInterstitial *interstitialAd;
@property (nonatomic, strong) ATRewardedVideo *rewardedAd;
@property (nonatomic, strong) ATBannerView *bannerView;

@end

@implementation TakuSampleAdManager

+ (instancetype)shared {
    static TakuSampleAdManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[TakuSampleAdManager alloc] init];
    });
    return instance;
}

- (void)initializeSDK {
    [LogUtils i:@"TakuSampleAdManager.initializeSDK() called"];
    //Enable logging
    [ATAPI setLogEnabled:YES];//Turn on debug logs
    //Enable logging后，调用Check integration method
    [ATAPI integrationChecking];
    // Initialize SDK directly
    [[ATAPI sharedInstance] startWithAppID:@"Your AppID" appKey:@"Your appKey" error:nil];

    [LogUtils i:@"Taku SDK initialized successfully"];
}

- (void)loadInterstitialAd {
    NSString *adUnitID = [[TakuConfig shared] getAdUnitIdForAdType:AdTypeInterstitial];
    [LogUtils i:[NSString stringWithFormat:@"Loading Taku Interstitial ad with unit ID: %@", adUnitID]];

    NSMutableDictionary * loadConfigDict = [NSMutableDictionary dictionary];
    [loadConfigDict setValue:@"media_val_InterstitialVC" forKey:kATAdLoadingExtraMediaExtraKey];

    [[ATAdManager sharedManager] loadADWithPlacementID:adUnitID extra:loadConfigDict delegate:self];

}

- (void)showInterstitialAdFromViewController:(UIViewController *)viewController {
    
    NSString *adUnitID = [[TakuConfig shared] getAdUnitIdForAdType:AdTypeInterstitial];
    if ([[ATAdManager sharedManager] interstitialReadyForPlacementID:adUnitID]) {

        //Show configuration，Scene传入后台的场景ID，没有可传入空字符串，showCustomExt参数可传入自定义参数字符串
        ATShowConfig *config = [[ATShowConfig alloc] initWithScene:adUnitID showCustomExt:@"testShowCustomExt"];
     
        //Show ad
        //若是全屏Interstitial，inViewController可传入根控制器，如tabbarController或navigationController，让广告遮挡住tabbar或navigationBar
        [[ATAdManager sharedManager] showInterstitialWithPlacementID:adUnitID
                                                          showConfig:config
                                                    inViewController:viewController
                                                            delegate:self
                                                  nativeMixViewBlock:nil];
    } else {
        [LogUtils w:@"Taku Interstitial ad not ready yet"];
    }
}

- (void)loadRewardedAd {
    NSString *adUnitID = [[TakuConfig shared] getAdUnitIdForAdType:AdTypeRewarded];
    [LogUtils i:[NSString stringWithFormat:@"Loading Taku Rewarded ad with unit ID: %@", adUnitID]];
    NSMutableDictionary * loadConfigDict = [NSMutableDictionary dictionary];
    // Optional integration，以下几个key参数适用于广告平台的服务端激励验证，将被透传
    [loadConfigDict setValue:@"media_val_RewardedVC" forKey:kATAdLoadingExtraMediaExtraKey];
    [loadConfigDict setValue:@"rv_test_user_id" forKey:kATAdLoadingExtraUserIDKey];
    [loadConfigDict setValue:@"reward_Name" forKey:kATAdLoadingExtraRewardNameKey];
    [loadConfigDict setValue:@3 forKey:kATAdLoadingExtraRewardAmountKey];
     
    // Start ad load
    [[ATAdManager sharedManager] loadADWithPlacementID:adUnitID extra:loadConfigDict delegate:self];
}

- (void)showRewardedAdFromViewController:(UIViewController *)viewController {
    
    NSString *adUnitID = [[TakuConfig shared] getAdUnitIdForAdType:AdTypeRewarded];

    //Scene analytics，呈现在后台的 数据报表 -> 漏斗分析报表 -> 到达广告场景 ，在Show ad前调用。Optional integration
    [[ATAdManager sharedManager] entryRewardedVideoScenarioWithPlacementID:adUnitID scene:@""];

    //Check if ready
    if (![[ATAdManager sharedManager] rewardedVideoReadyForPlacementID:adUnitID]) {

        [[ATAdManager sharedManager] showRewardedVideoWithPlacementID:adUnitID inViewController:viewController delegate:self];
        return;
    } else {
        [LogUtils w:@"Taku Rewarded ad not ready yet"];
    }
}

- (void)loadBannerAd {
    NSString *adUnitID = [[TakuConfig shared] getAdUnitIdForAdType:AdTypeBanner];
    [LogUtils i:[NSString stringWithFormat:@"Loading Taku Banner ad with unit ID: %@", adUnitID]];

    NSMutableDictionary * loadConfigDict = [NSMutableDictionary dictionary];
    
    /*
     注意不同平台的横幅广告有一定限制，例如配置的横幅广告640*100，为了能填充完屏幕宽，计算高度H = (屏幕宽 *100)/640；那么在load的extra的size为（屏幕宽：H）。
     
     Note that banner ads on different platforms have certain restrictions. For example, the configured banner AD is 640*100. In order to fill the screen width, the height H = (screen width *100)/640 is calculated. Then the extra size of the load is (screen width: H).
     */
//    [loadConfigDict setValue:[NSValue valueWithCGSize:BannerSize] forKey:kATAdLoadingExtraBannerAdSizeKey];
    
    //Set custom parameters
    [loadConfigDict setValue:@"media_val_BannerVC" forKey:kATAdLoadingExtraMediaExtraKey];
 
    //开始加载
    [[ATAdManager sharedManager] loadADWithPlacementID:adUnitID extra:loadConfigDict delegate:self];
}

#pragma mark - 广告位代理回调
/// 广告位加载完成
/// - Parameter placementID: 广告位ID
- (void)didFinishLoadingADWithPlacementID:(NSString *)placementID {

}
 
/// 广告位加载失败
/// - Parameters:
///   - placementID: 广告位ID
///   - error: 错误信息
- (void)didFailToLoadADWithPlacementID:(NSString *)placementID error:(NSError *)error {
    
}

- (ATBannerView *)getBannerView {
    
    NSString *adUnitID = [[TakuConfig shared] getAdUnitIdForAdType:AdTypeBanner];
    ATShowConfig *config = [[ATShowConfig alloc] initWithScene:adUnitID showCustomExt:@"testShowCustomExt"];

    ATBannerView *bannerView = [[ATAdManager sharedManager] retrieveBannerViewForPlacementID:adUnitID config:config];
    bannerView.delegate = self;
    return bannerView;
}

- (void)loadNativeAd {
    NSString *adUnitID = [[TakuConfig shared] getAdUnitIdForAdType:AdTypeNative];
    [LogUtils i:[NSString stringWithFormat:@"Loading Taku Native ad with unit ID: %@", adUnitID]];
    
    NSMutableDictionary * loadConfigDict = [NSMutableDictionary dictionary];
    [loadConfigDict setValue:@"media_val_NativeVC" forKey:kATAdLoadingExtraMediaExtraKey];
    
    [[ATAdManager sharedManager] loadADWithPlacementID:adUnitID extra:loadConfigDict delegate:self];
}


#pragma mark - ATInterstitialDelegate

- (void)interstitialDidShowForPlacementID:(NSString *)placementID extra:(NSDictionary *)extra {
    [LogUtils i:@"Taku Interstitial ad showed"];
}

- (void)interstitialDidFailToShowForPlacementID:(NSString *)placementID error:(NSError *)error extra:(NSDictionary *)extra {
    [LogUtils e:[NSString stringWithFormat:@"Taku Interstitial ad failed to show: %@", error.localizedDescription]];
}

- (void)interstitialDidClickForPlacementID:(NSString *)placementID extra:(NSDictionary *)extra {
    [LogUtils i:@"Taku Interstitial ad clicked"];
}

- (void)interstitialDidCloseForPlacementID:(NSString *)placementID extra:(NSDictionary *)extra {
    [LogUtils i:@"Taku Interstitial ad closed"];
}

- (void)interstitialDidStartPlayingVideoForPlacementID:(NSString *)placementID extra:(NSDictionary *)extra {
    [LogUtils i:@"Taku Interstitial video started"];
}

- (void)interstitialDidEndPlayingVideoForPlacementID:(NSString *)placementID extra:(NSDictionary *)extra {
    [LogUtils i:@"Taku Interstitial video ended"];
}

- (void)interstitialDidFailToPlayVideoForPlacementID:(NSString *)placementID error:(NSError *)error extra:(NSDictionary *)extra {
    [LogUtils e:[NSString stringWithFormat:@"Taku Interstitial video failed to play: %@", error.localizedDescription]];
}

- (void)didRevenueForPlacementID:(NSString *)placementID
                           extra:(NSDictionary *)extra{
    // get the adtype from placementID if you realize all the adtype in a file
    if (@"Interstitial"/*Just for example*/) {
        [TakuAdWrapper trackInterstitialAdRevenue:placementID extra:extra];
    }else if (@"RewardedVideo"/*Just for example*/){
        [TakuAdWrapper trackRewardedAdRevenue:placementID extra:extra];
    }
}

#pragma mark - ATRewardedVideoDelegate

- (void)rewardedVideoDidShowForPlacementID:(NSString *)placementID extra:(NSDictionary *)extra {
    [LogUtils i:@"Taku Rewarded ad showed"];
}

- (void)rewardedVideoDidFailToShowForPlacementID:(NSString *)placementID error:(NSError *)error extra:(NSDictionary *)extra {
    [LogUtils e:[NSString stringWithFormat:@"Taku Rewarded ad failed to show: %@", error.localizedDescription]];
}

- (void)rewardedVideoDidClickForPlacementID:(NSString *)placementID extra:(NSDictionary *)extra {
    [LogUtils i:@"Taku Rewarded ad clicked"];
}

- (void)rewardedVideoDidCloseForPlacementID:(NSString *)placementID extra:(NSDictionary *)extra {
    [LogUtils i:@"Taku Rewarded ad closed"];
}

- (void)rewardedVideoDidStartPlayingForPlacementID:(NSString *)placementID extra:(NSDictionary *)extra {
    [LogUtils i:@"Taku Rewarded video started"];
}

- (void)rewardedVideoDidEndPlayingForPlacementID:(NSString *)placementID extra:(NSDictionary *)extra {
    [LogUtils i:@"Taku Rewarded video ended"];
}

- (void)rewardedVideoDidCloseForPlacementID:(nonnull NSString *)placementID rewarded:(BOOL)rewarded extra:(nonnull NSDictionary *)extra { 
    <#code#>
}


- (void)rewardedVideoDidRewardSuccessForPlacemenID:(nonnull NSString *)placementID extra:(nonnull NSDictionary *)extra { 
    <#code#>
}


- (void)rewardedVideoDidRewardSuccessForPlacementID:(NSString *)placementID extra:(NSDictionary *)extra {
    [LogUtils i:@"Taku Rewarded user earned reward"];
}

#pragma mark - ATBannerDelegate

- (void)bannerView:(ATBannerView *)bannerView didShowAdWithPlacementID:(NSString *)placementID extra:(NSDictionary *)extra {
    [LogUtils i:@"Taku Banner ad showed"];
}

- (void)bannerView:(ATBannerView *)bannerView didClickWithPlacementID:(NSString *)placementID extra:(NSDictionary *)extra {
    [LogUtils i:@"Taku Banner ad clicked"];
}

- (void)bannerView:(ATBannerView *)bannerView didAutoRefreshWithPlacementID:(NSString *)placementID extra:(NSDictionary *)extra {
    [LogUtils i:@"Taku Banner ad auto refreshed"];
}

- (void)bannerView:(ATBannerView *)bannerView didFailToShowAdWithPlacementID:(NSString *)placementID error:(NSError *)error extra:(NSDictionary *)extra {
    [LogUtils e:[NSString stringWithFormat:@"Taku Banner ad failed to show: %@", error.localizedDescription]];
}

@end
