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

- AdMob: use paid event (GADAdValue + GADResponseInfo) and forward via `AdMobAdWrapper` which calls `AdMobSolarEngineTracker`.
- MAX: implement `MAAdRevenueDelegate` per ad type; wrappers (e.g., `MaxRewardedAdWrapper`) call `MaxSolarEngineTracker` with a `MaxAdType` enum.
- Gromore: extract `BUMRitInfo` via `getShowEcpmInfo`; wrappers call `GromoreSolarEngineTracker` with `GromoreAdType`.
- IronSource: implement the LevelPlay impression data callback and forward to `IronSourceSolarEngineTracker.trackAdImpression`.
- Taku/TopOn: use their callback info objects; wrappers call their respective trackers with enums.

### Project layout (high‑level)

- `SolarEngineMeditationSample/`
  - `Wrappers/` Wrapper classes per mediation (and trackers where applicable)
  - `SampleManagers/` Simple demo managers per mediation
  - `Config/` Mediation configuration helpers

### How to use in your app

1) Integrate the mediation SDK you choose (MAX, AdMob, Gromore, IronSource, Taku, or TopOn) following that SDK’s official iOS guide (e.g., CocoaPods).
2) Use this sample as a reference for wiring each SDK’s delegates/blocks.
3) When revenue/impression callbacks fire, call the corresponding wrapper/trackers to forward data to SolarEngine:
   - AdMob: paid event ➜ `AdMobAdWrapper.*` which calls `AdMobSolarEngineTracker`
   - MAX: `MAAdRevenueDelegate` ➜ `Max*AdWrapper` which calls `MaxSolarEngineTracker`
   - Gromore: `getShowEcpmInfo` ➜ `GromoreAdWrapper` which calls `GromoreSolarEngineTracker`
   - IronSource: LevelPlay impression data ➜ call `IronSourceSolarEngineTracker.trackAdImpression`
   - Taku/TopOn: callback info ➜ `TakuAdWrapper` / `TopOnAdWrapper` which call their trackers
4) Keep your app code focused on load/show logic; let wrappers normalize and report to SolarEngine.

### Out of scope

- Production error handling, consent/ATT/UMP flows, and complete monetization strategy. This sample focuses on wiring and tracking.

### Notes

- appID/appKey and unit IDs are placeholders.
- Replace test IDs with your real IDs before release.


