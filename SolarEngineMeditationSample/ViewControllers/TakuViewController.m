//
//  TakuViewController.m
//  SolarEngineMeditationSample
//
//  Created by zhanghulk on 2025/8/27.
//

#import "TakuViewController.h"
#import "TakuSampleAdManager.h"
#import "LogUtils.h"
#import <AnyThinkSDK/AnyThinkSDK.h>

@interface TakuViewController ()

@property (nonatomic, strong) TakuSampleAdManager *takuManager;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIStackView *stackView;
@property (nonatomic, strong) UIView *bannerContainer;

@end

@implementation TakuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self setupTakuManager];
}

- (void)setupUI {
    self.title = @"Taku Ads";
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

- (void)setupTakuManager {
    self.takuManager = [[TakuSampleAdManager alloc] init];
    [self.takuManager initializeSDK];
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
    [LogUtils i:@"Loading Taku Interstitial ad"];
    [self.takuManager loadInterstitialAd];
}

- (void)showInterstitial {
    [LogUtils i:@"Showing Taku Interstitial ad"];
    [self.takuManager showInterstitialAdFromViewController:self];
}

- (void)loadRewarded {
    [LogUtils i:@"Loading Taku Rewarded ad"];
    [self.takuManager loadRewardedAd];
}

- (void)showRewarded {
    [LogUtils i:@"Showing Taku Rewarded ad"];
    [self.takuManager showRewardedAdFromViewController:self];
}

- (void)loadBanner {
    [LogUtils i:@"Loading Taku Banner ad"];
    [self.takuManager loadBannerAd];
    UIView *bannerView = [self.takuManager getBannerView];
    // Clear previous banner
    for (UIView *subview in self.bannerContainer.subviews) {
        [subview removeFromSuperview];
    }
    
    // Add new banner
    if (bannerView) {
        [self.bannerContainer addSubview:bannerView];
    }

    bannerView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [bannerView.centerXAnchor constraintEqualToAnchor:self.bannerContainer.centerXAnchor],
        [bannerView.centerYAnchor constraintEqualToAnchor:self.bannerContainer.centerYAnchor]
    ]];
}



@end
