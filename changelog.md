# Changelog - OOS & GMS Optimiser

## v2.0.0-OOS16 (OxygenOS 16 / Android 16)
- **Target OS Update:** Initial fork and full compatibility update for OxygenOS 16 / Android 16 (SDK 36).
- **OxygenOS Telemetry Removal:** Disables proprietary OOS/ColorOS analytics packages using `--user 0` execution state.
- **Smart Notification Sync Loop:** Implemented a continuous 3-minute / 25-second background daemon loop:
  - Keeps GMS restricted for 180s to maximize battery life.
  - Temporarily unrestricts GMS for 25s while triggering FCM heartbeats to sync push notifications without delay.
- **GMS Tracker Neutralization:** Permanently disables analytics and core stats receivers (`AnalyticsReceiver`, `AnalyticsService`, `GmsCoreStatsService`).
- **Permissions & Package Manager Fixes:** Appends `--user 0` flag across all `pm disable` routines for reliable multi-user and OOS 16 component blocking.
- **Author Update:** Updated module metadata author tag to `hafizhasant (forked from epicmann24)`.

---

## v1.0.0 (Original)
- Initial release by epicmann24 for legacy OxygenOS versions.
