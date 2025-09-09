## SolarEngine 冥想示例 – iOS

### 为什么有这个示例

- 在一个 iOS 应用中演示多种聚合平台（MAX、AdMob、Gromore、IronSource、Taku、TopOn）的端到端集成。
- 展示统一的 Wrapper 模式，用一个 API 将各平台的广告收益/曝光数据上报到 SolarEngine。
- 提供常见广告类型（激励、插屏、横幅、原生、开屏/App Open）的最小可运行示例，并标注 iOS 侧收益回调接入点。

### Wrapper 的作用

- 封装各平台 SDK 的调用与回调，将其收益/曝光回调映射为 SolarEngine 的 `trackAdImpression` 上报。
- 统一参数（广告类型、广告位/单元、货币、eCPM）后再上报。
- 使控制器/管理类更干净：控制器只负责加载/展示；Wrapper 负责 delegate/block 与上报。

### 各平台要点

- AdMob：使用 paid event（GADAdValue + GADResponseInfo）→ `AdMobAdWrapper` → `AdMobSolarEngineTracker`。
- MAX：实现 `MAAdRevenueDelegate`（按广告类型）；如 `Max*AdWrapper` → `MaxSolarEngineTracker`（含 `MaxAdType`）。
- Gromore：通过 `getShowEcpmInfo` 获取 `BUMRitInfo`；`GromoreAdWrapper` → `GromoreSolarEngineTracker`（含 `GromoreAdType`）。
- IronSource：使用 LevelPlay 曝光回调，转发到 `IronSourceSolarEngineTracker.trackAdImpression`。
- Taku/TopOn：使用回调信息对象；`TakuAdWrapper` / `TopOnAdWrapper` → 各自 Tracker。

### 目录结构（概览）

- `SolarEngineMeditationSample/`
  - `Wrappers/` 各聚合平台 Wrapper/Tracker
  - `SampleManagers/` 各聚合平台演示管理类
  - `Config/` 配置

### 如何在你的应用中使用

1) 按官方文档集成所选聚合 SDK（如 CocoaPods）。
2) 参考本示例接入各 SDK 的 delegates/blocks。
3) 当触发收益/曝光回调时，调用相应 Wrapper/Tracker 将数据上报到 SolarEngine：
   - AdMob：paid event → `AdMobAdWrapper.*` → `AdMobSolarEngineTracker`
   - MAX：`MAAdRevenueDelegate` → `Max*AdWrapper` → `MaxSolarEngineTracker`
   - Gromore：`getShowEcpmInfo` → `GromoreAdWrapper` → `GromoreSolarEngineTracker`
   - IronSource：LevelPlay 曝光数据 → `IronSourceSolarEngineTracker.trackAdImpression`
   - Taku/TopOn：回调信息 → `TakuAdWrapper` / `TopOnAdWrapper` → 各自 Tracker
4) 业务层只关注加载/展示，Wrapper 负责归一化与上报。

### 范围之外

- 生产级错误处理、ATT/UMP 合规流程与完整变现策略不在此示例范围内。

### 说明

- appID/appKey 与广告单元 ID 仅为占位符。
- 发布前请替换为你的真实 ID。


