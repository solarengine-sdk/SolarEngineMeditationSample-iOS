//
//  AdMobViewController.m
//  SolarEngineMeditationSample
//
//  Created by zhanghulk on 2025/8/27.
//

#import "AdMobViewController.h"
#import "AdMobSampleAdManager.h"
#import "LogUtils.h"
#import <GoogleMobileAds/GoogleMobileAds.h>

@interface AdMobViewController ()

@property (nonatomic, strong) AdMobSampleAdManager *adMobManager;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIStackView *stackView;
@property (nonatomic, strong) UIView *bannerContainer;

@end

@implementation AdMobViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self setupAdMobManager];
}

- (void)setupUI {
    self.title = @"AdMob Ads";
    self.view.backgroundColor = [UIColor systemBackgroundColor];
    
    // Setup scroll view
    self.scrollView = [[UIScrollView alloc] init];
    [self.view addSubview:self.scrollView];
    self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [NSLayoutConstraint activateConstraints:@[
        [self.scrollView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
        [self.scrollView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [self.scrollView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [self.scrollView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor]
    ]];
    
    // Setup stack view
    self.stackView = [[UIStackView alloc] init];
    [self.scrollView addSubview:self.stackView];
    self.stackView.translatesAutoresizingMaskIntoConstraints = NO;
    self.stackView.axis = UILayoutConstraintAxisVertical;
    self.stackView.spacing = 16;
    self.stackView.distribution = UIStackViewDistributionFillEqually;
    
    [NSLayoutConstraint activateConstraints:@[
        [self.stackView.topAnchor constraintEqualToAnchor:self.scrollView.topAnchor constant:20],
        [self.stackView.leadingAnchor constraintEqualToAnchor:self.scrollView.leadingAnchor constant:20],
        [self.stackView.trailingAnchor constraintEqualToAnchor:self.scrollView.trailingAnchor constant:-20],
        [self.stackView.bottomAnchor constraintEqualToAnchor:self.scrollView.bottomAnchor constant:-20],
        [self.stackView.widthAnchor constraintEqualToAnchor:self.scrollView.widthAnchor constant:-40]
    ]];
    
    // Add buttons
    [self addButtonWithTitle:@"Load Interstitial" action:@selector(loadInterstitial)];
    [self addButtonWithTitle:@"Show Interstitial" action:@selector(showInterstitial)];
    [self addButtonWithTitle:@"Load Rewarded" action:@selector(loadRewarded)];
    [self addButtonWithTitle:@"Show Rewarded" action:@selector(showRewarded)];
    [self addButtonWithTitle:@"Load Banner" action:@selector(loadBanner)];

    // Add banner container
    self.bannerContainer = [[UIView alloc] init];
    [self.stackView addArrangedSubview:self.bannerContainer];
    self.bannerContainer.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.bannerContainer.heightAnchor constraintEqualToConstant:100]
    ]];
}

- (void)setupAdMobManager {
    self.adMobManager = [[AdMobSampleAdManager alloc] init];
    [self.adMobManager initializeSDK];
}

- (void)addButtonWithTitle:(NSString *)title action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
    button.backgroundColor = [UIColor systemBlueColor];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.layer.cornerRadius = 8;
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    
    button.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [button.heightAnchor constraintEqualToConstant:50]
    ]];
    
    [self.stackView addArrangedSubview:button];
}

#pragma mark - Ad Actions

- (void)loadInterstitial {
    [LogUtils i:@"Loading AdMob Interstitial ad"];
    [self.adMobManager loadInterstitialAd];
}

- (void)showInterstitial {
    [LogUtils i:@"Showing AdMob Interstitial ad"];
    [self.adMobManager showInterstitialAdFromViewController:self];
}

- (void)loadRewarded {
    [LogUtils i:@"Loading AdMob Rewarded ad"];
    [self.adMobManager loadRewardedAd];
}

- (void)showRewarded {
    [LogUtils i:@"Showing AdMob Rewarded ad"];
    [self.adMobManager showRewardedAdFromViewController:self];
}

- (void)loadBanner {
    [LogUtils i:@"Loading AdMob Banner ad"];
    [self.adMobManager loadBannerAd];
    GADBannerView *bannerView = [self.adMobManager getBannerView];
    
    // Clear previous banner
    for (UIView *subview in self.bannerContainer.subviews) {
        [subview removeFromSuperview];
    }
    
    // Add new banner
    [self.bannerContainer addSubview:bannerView];
    bannerView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [bannerView.centerXAnchor constraintEqualToAnchor:self.bannerContainer.centerXAnchor],
        [bannerView.centerYAnchor constraintEqualToAnchor:self.bannerContainer.centerYAnchor]
    ]];
}

@end
