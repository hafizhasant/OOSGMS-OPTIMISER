# OOS & GMS Optimiser (OxygenOS 16 / Android 16)

An optimized Magisk / KernelSU / APatch module designed to remove background telemetry, tune system properties, and optimize Google Play Services (GMS) performance on **OxygenOS 16** without sacrificing real-time notifications.

---

## 🚀 Key Improvements in OOS 16 Edition

* **OxygenOS 16 / Android 16 Support:** Fully updated target detection (SDK 36) and package definitions for the latest OOS updates.
* **OOS Telemetry & Tracker Disabler:** Automatically disables proprietary OnePlus / Oplus telemetry packages including `com.oneplus.healthcheck`, `com.oplus.analytics`, `com.oplus.qualityprotect`, `com.oplus.crashbox`, `com.oplus.logkit`, and `com.oplus.stdid`.
* **GMS Tracker Neutralization:** Disables embedded GMS analytics and background stats receivers (`AnalyticsReceiver`, `AnalyticsService`, `GmsCoreStatsService`).
* **Smart Notification Sync Loop (Battery & Push Fix):**
  * Solves delayed push notifications (FCM/GCM for WhatsApp, Telegram, Gmail, etc.) while maintaining battery efficiency.
  * **Phase 1 (180s / 3 mins):** Keeps GMS in restricted Standby Bucket and blocks background execution.
  * **Phase 2 (25s):** Temporarily unrestricts GMS, moves it to Active Standby, and broadcasts FCM heartbeat signals to pull pending push notifications instantly.

---

## ⚡ Installation

1. Download the latest `OOSGMS-OPTIMISER-OOS16.zip` from the [Releases](https://github.com/hafizhasant/OOSGMS-OPTIMISER/releases) section.
2. Open **Magisk**, **KernelSU**, or **APatch**.
3. Select **Modules** ➔ **Install from storage**.
4. Choose `OOSGMS-OPTIMISER-OOS16.zip` and flash it.
5. Reboot your device.

---

## 🗑️ Uninstallation

* To uninstall, simply remove the module from your root manager app (Magisk / KernelSU / APatch) and reboot.

---

## 🙏 Credits & Acknowledgments

Special thanks to **[epicmann24](https://github.com/epicmann24)** for creating the original **[OOSGMS-OPTIMISER](https://github.com/epicmann24/OOSGMS-OPTIMISER)** project and XDA optimization guide which laid the foundation for this OxygenOS 16 fork.
