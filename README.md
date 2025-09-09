## SolarEngine Meditation Sample – iOS

### Why this sample exists

- Demonstrate end‑to‑end integration of multiple ad mediation SDKs (MAX, AdMob, Gromore, IronSource, Taku, TopOn) in a single iOS app.
- Show a consistent “wrapper” pattern to isolate SDK specifics and report ad revenue/impressions to SolarEngine through one API.
- Provide minimal, runnable examples for common ad types (Rewarded, Interstitial, Banner, Native, Splash/App Open) and where to hook revenue callbacks on iOS.

### What the wrappers are for

- Encapsulate each network’s SDK calls and map their revenue/impression callbacks to SolarEngine’s `trackAdImpression`.
- Normalize parameters (ad type, ad unit/placement info, currency, eCPM) across networks before sending to SolarEngine.
- Keep controllers/managers clean: controllers trigger load/show; wrappers handle SDK delegates/blocks and tracking.

### Key points by network

- AdMob: set `paidEventHandler` using `AdMobAdWrapper` helper blocks (e.g., `interstitialAdOnPaidEventBlock:`).
- MAX: implement `MAAdRevenueDelegate` per ad type and call the matching `Max*AdWrapper` in `didPayRevenueForAd:`.
- Gromore: on ad show, call `GromoreAdWrapper track*AdImpression` (wrapper extracts `BUMRitInfo` internally).
- IronSource: use LevelPlay impression data and forward to `IronSourceSolarEngineTracker trackAdImpression`.
- Taku/TopOn: in show callbacks, call `TakuAdWrapper track*AdRevenue` / `TopOnAdWrapper track*AdRevenue`.

### Project layout (high‑level)

- `SolarEngineMeditationSample/`
  - `Wrappers/` Wrapper classes per mediation (and trackers where applicable)
  - `SampleManagers/` Simple demo managers per mediation
  - `Config/` Mediation configuration helpers

### How to use in your app

1) Integrate the mediation SDK you choose (MAX, AdMob, Gromore, IronSource, Taku, or TopOn) following that SDK’s official iOS guide (e.g., CocoaPods).
2) Use this sample as a reference for wiring each SDK’s delegates/blocks.(You can download the wrapper file from [here](https://github.com/solarengine-sdk/SolarEngineMeditationSample-iOS/blob/main/Wrappers.zip), delete the mediation wrapper file you don`t need). 
3) When revenue/impression callbacks fire, call the corresponding wrapper/trackers to forward data to SolarEngine:
   - AdMob: set paidEventHandler on ads ➜ use `AdMobAdWrapper` helper blocks to forward to `AdMobSolarEngineTracker`
     
      Example (Interstitial):
      ```objc
      GADResponseInfo *info = self.interstitialAd.responseInfo;
      // Set paid event listener via wrapper block
      self.interstitialAd.paidEventHandler = [AdMobAdWrapper interstitialAdOnPaidEventBlock:^(GADAdValue *adValue) {
          [LogUtils i:@"AdMob Interstitial onAdRevenuePaid"];
      } responseInfo:info];
      ```     
   - MAX: implement `MAAdRevenueDelegate` per ad type and call the respective `Max*AdWrapper`
     
     Example (Interstitial):
     ```objc
        NSString *adUnitID = [[MaxConfig shared] getAdUnitIdForAdType:AdTypeInterstitial];
        self.interstitialAd = [[MAInterstitialAd alloc] initWithAdUnitIdentifier: adUnitID];
        self.interstitialAd.delegate = self;
        self.interstitialAd.revenueDelegate = [MaxInterstitialAdWrapper adRevenueDelegate:self];             
     ```
   - Gromore: obtain `BUMRitInfo` via show eCPM ➜ `GromoreAdWrapper` forwards to `GromoreSolarEngineTracker`
     
     Example (Interstitial):
     ```objc
      #pragma mark - BUMNativeExpressFullscreenVideoAdDelegate

      - (void)nativeExpressFullscreenVideoAdDidShow:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd {
          [LogUtils i:@"Gromore Interstitial ad showed"];
          
          // Track ad impression using the new wrapper
          [GromoreAdWrapper trackInterstitialAdImpression:fullscreenVideoAd];
      }
     ```
   - IronSource: LevelPlay impression data ➜ `IronSourceSolarEngineTracker trackAdImpressionWithData:`
   - Taku/TopOn: callback info ➜ `TakuAdWrapper` / `TopOnAdWrapper` which call their trackers
   Example (Interstitial):
    ```objc
    - (void)didRevenueForPlacementID:(NSString *)placementID
                           extra:(NSDictionary *)extra{
      if (/*Just for example*/){
          [TakuAdWrapper trackInterstitialAdRevenue:placementID extra:extra];
      }

      if (/*Just for example*/){
          [TakuAdWrapper trackRewardedAdRevenue:placementID extra:extra];
      }
    }
    ```


4) Keep your app code focused on load/show logic; let wrappers normalize and report to SolarEngine.

### Out of scope

- Production error handling, consent/ATT/UMP flows, and complete monetization strategy. This sample focuses on wiring and tracking.

### Notes

- appID/appKey and unit IDs are placeholders.
- Replace test IDs with your real IDs before release.


