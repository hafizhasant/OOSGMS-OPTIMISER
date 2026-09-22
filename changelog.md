# Changelog - OOS & GMS Optimiser

## v2.1.0 (OxygenOS 16 / Android 16)
- **GMS Network & Receiver Hardening:** Added netpolicy background blacklist and revoked unused sensor/location permissions for `com.google.android.gms`.
- **Expanded Receiver Disables:** Added boot, checkin, analytics, and update receivers (`DropBoxEntryAddedReceiver`, `CheckinService`, `SystemUpdateService`, `AppMeasurementReceiver`).
- **OxygenOS Telemetry Removal:** Disables proprietary OOS/ColorOS analytics packages via `--user 0`.
- **Smart Notification Sync Loop:** 3-minute restricted state / 25-second active FCM pull loop.
- **On-Demand Manual Sync:** Triggerable via `action.sh` in KernelSU / APatch / MMRL.
- **Boot Optimization:** Added early Doze tuning via `post-fs-data.sh`.
