//
//  ViewController.m
//  SolarEngineMeditationSample
//
//  Created by zhanghulk on 2025/8/27.
//

#import "ViewController.h"
#import "AdMobViewController.h"
#import "MaxViewController.h"
#import "TakuViewController.h"
#import "TopOnViewController.h"
#import "GromoreViewController.h"
#import "IronSourceViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIStackView *stackView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI {
    self.title = @"SolarEngine Meditation Sample";
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
    [self addButtonWithTitle:@"AdMob Ads" action:@selector(showAdMobAds)];
    [self addButtonWithTitle:@"MAX Ads" action:@selector(showMaxAds)];
    [self addButtonWithTitle:@"Taku Ads" action:@selector(showTakuAds)];
    [self addButtonWithTitle:@"TopOn Ads" action:@selector(showTopOnAds)];
    [self addButtonWithTitle:@"Gromore Ads" action:@selector(showGromoreAds)];
    [self addButtonWithTitle:@"IronSource Ads" action:@selector(showIronSourceAds)];
}

- (void)addButtonWithTitle:(NSString *)title action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:18 weight:UIFontWeightMedium];
    button.backgroundColor = [UIColor systemBlueColor];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.layer.cornerRadius = 10;
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    
    button.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [button.heightAnchor constraintEqualToConstant:60]
    ]];
    
    [self.stackView addArrangedSubview:button];
}

#pragma mark - Navigation Actions

- (void)showAdMobAds {
    AdMobViewController *adMobVC = [[AdMobViewController alloc] init];
    [self.navigationController pushViewController:adMobVC animated:YES];
}

- (void)showMaxAds {
    MaxViewController *maxVC = [[MaxViewController alloc] init];
    [self.navigationController pushViewController:maxVC animated:YES];
}

- (void)showTakuAds {
    TakuViewController *takuVC = [[TakuViewController alloc] init];
    [self.navigationController pushViewController:takuVC animated:YES];
}

- (void)showTopOnAds {
    TopOnViewController *topOnVC = [[TopOnViewController alloc] init];
    [self.navigationController pushViewController:topOnVC animated:YES];
}

- (void)showGromoreAds {
    GromoreViewController *gromoreVC = [[GromoreViewController alloc] init];
    [self.navigationController pushViewController:gromoreVC animated:YES];
}

- (void)showIronSourceAds {
    IronSourceViewController *ironSourceVC = [[IronSourceViewController alloc] init];
    [self.navigationController pushViewController:ironSourceVC animated:YES];
}

@end
