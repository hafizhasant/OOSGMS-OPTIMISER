#!/system/bin/sh
# Wait until system boot completes
while [ "$(getprop sys.boot_completed)" != "1" ]; do
    sleep 3
done

# Disable OxygenOS 16 / ColorOS telemetry and tracking packages
pm disable com.oneplus.healthcheck 2>/dev/null
pm disable com.oplus.analytics 2>/dev/null
pm disable com.oplus.qualityprotect 2>/dev/null
pm disable com.oplus.crashbox 2>/dev/null
pm disable com.oplus.logkit 2>/dev/null
pm disable com.oplus.stdid 2>/dev/null

# Disable Google Play Services tracking receivers permanently
pm disable com.google.android.gms/com.google.android.gms.analytics.AnalyticsReceiver 2>/dev/null
pm disable com.google.android.gms/com.google.android.gms.analytics.AnalyticsService 2>/dev/null
pm disable com.google.android.gms/com.google.android.gms.common.stats.GmsCoreStatsService 2>/dev/null

# Continuous 3-minute sync loop for FCM push notifications
while true; do
    # --- PHASE 1: RESTRICT GMS (3 Minutes / 180s) ---
    cmd deviceidle whitelist -com.google.android.gms 2>/dev/null
    cmd appops set com.google.android.gms RUN_IN_BACKGROUND ignore
    cmd appops set com.google.android.gms RUN_ANY_IN_BACKGROUND ignore
    am set-standby-bucket com.google.android.gms restricted 2>/dev/null
    
    sleep 180

    # --- PHASE 2: UNRESTRICT & SYNC NOTIFICATIONS (25 Seconds) ---
    cmd deviceidle whitelist +com.google.android.gms 2>/dev/null
    cmd appops set com.google.android.gms RUN_IN_BACKGROUND allow
    cmd appops set com.google.android.gms RUN_ANY_IN_BACKGROUND allow
    am set-standby-bucket com.google.android.gms active 2>/dev/null
    
    # Trigger GMS FCM Heartbeat check to pull queued messages immediately
    am broadcast -a com.google.android.intent.action.MCS_HEARTBEAT 2>/dev/null
    am broadcast -a com.google.android.gms.gcm.HEARTBEAT 2>/dev/null

    sleep 25
done &
