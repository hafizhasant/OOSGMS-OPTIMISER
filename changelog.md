# Changelog - OOS & GMS Optimiser

## v2.1.1 (Revision Patch)
- **Fixed Component Mismatches:** Removed obsolete/relocated Chimera receivers (`CheckinService`, `SystemUpdateService`) to eliminate `pm` Java exceptions on Android 16.
- **Fixed Netpolicy Resolution:** Updated `netpolicy` to target exact numeric GMS package `UID` instead of string package names.
- **Improved DeviceIdle Un-whitelisting:** Explicitly strips `com.google.android.gms` from system Doze exemptions before applying `AppOps` and `Standby Bucket` locks.

## v2.1.0
- **GMS Network & Receiver Hardening:** Added netpolicy background blacklist and revoked unused sensor/location permissions.
- **OxygenOS Telemetry Removal:** Disables proprietary OOS/ColorOS analytics packages via `--user 0`.
- **Smart Notification Sync Loop:** 3-minute restricted state / 25-second active FCM pull loop.
