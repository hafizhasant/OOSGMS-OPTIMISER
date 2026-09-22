# OxygenOS & GMS Optimiser (`OOSGMS-OPTIMISER`)

A lightweight Magisk / KernelSU / APatch module designed for **OxygenOS 16 / Android 16** to aggressively optimize Google Play Services (`com.google.android.gms`) background overhead, kill unwanted OnePlus/OPLUS system telemetry, and maintain instant FCM push notifications via a smart 3-minute background sync loop.

---

## 🚀 Key Features

* **GMS Hardening via AppOps & Netpolicy:**
  * Blocks background execution by enforcing `RUN_IN_BACKGROUND` and `RUN_ANY_IN_BACKGROUND` to `ignore`.
  * Restricts background cellular and Wi-Fi data usage targeting GMS's precise system `UID`.
  * Strips GMS from system Doze/DeviceIdle exemptions.
* **Component & Telemetry Stripping:**
  * Disables 5 core GMS analytics, stats, and measurement receivers (`AnalyticsReceiver`, `AnalyticsService`, `GmsCoreStatsService`, `DropBoxEntryAddedReceiver`, `AppMeasurementReceiver`).
  * Revokes location (`ACCESS_FINE_LOCATION`, `ACCESS_COARSE_LOCATION`), sensor (`BODY_SENSORS`), and `ACTIVITY_RECOGNITION` permissions from GMS.
  * Disables proprietary OxygenOS telemetry packages (`com.oneplus.healthcheck`, `com.oplus.analytics`, `com.oplus.qualityprotect`, `com.oplus.crashbox`, `com.oplus.logkit`, `com.oplus.stdid`).
* **Smart 3-Minute Notification Sync Loop:**
  * Cycles between a 3-minute restricted state and a 25-second active window.
  * Triggers broadcast intent heartbeats (`MCS_HEARTBEAT`, `GCM_HEARTBEAT`) during active windows to pull queued FCM push notifications (WhatsApp, Telegram, banking apps) without running background daemons continuously.
* **On-Demand Manual Sync:**
  * Includes `action.sh` support to trigger an immediate FCM notification pull manually from KernelSU / APatch / MMRL action buttons or via Termux (`sh /data/adb/modules/OOSGMS-OPTIMISER/action.sh`).

---

## 📋 Compatibility

* **OS:** OxygenOS 16 / ColorOS 16 / Android 16 (Compatible down to Android 14)
* **Root Managers:** KernelSU, APatch, Magisk, MMRL

---

## 🛠 Manual Execution & Auditing

To manually run a system audit or trigger a sync via Termux:

```bash
# 1. Trigger Manual Notification Sync
su -c "sh /data/adb/modules/OOSGMS-OPTIMISER/action.sh"

# 2. Audit GMS AppOps State
su -c "cmd appops get com.google.android.gms RUN_IN_BACKGROUND"

Changelog Summary (v2.1.1)
​Fixed Component Targets: Removed obsolete/relocated Chimera receivers (CheckinService, SystemUpdateService) to eliminate pm Java exceptions on Android 16.
​Fixed Netpolicy Resolution: Updated netpolicy to target the exact numeric GMS package UID instead of string package names.
​Improved DeviceIdle Un-whitelisting: Explicitly strips com.google.android.gms from system Doze exemptions before applying AppOps and Standby Bucket locks.
​🙏 Acknowledgments & Credits
​Special thanks to the Android root community and the maintainers of Magisk, KernelSU, APatch, and MMRL for module framework specifications.
​Inspired by core Android background optimization research and low-overhead FCM notification routing techniques.
​📝 License
​Released under the MIT License.
