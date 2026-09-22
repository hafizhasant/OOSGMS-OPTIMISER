#!/system/bin/sh
# Wait until system boot completes
while [ "$(getprop sys.boot_completed)" != "1" ]; do
    sleep 3
done

# Package & System Details
PKG="com.google.android.gms"
GMS_UID=$(pm list packages -U | grep "package:$PKG " | awk -F'uid:' '{print $2}')

# --- PHASE 1: DISABLE OXYGENOS TELEMETRY ---
pm disable --user 0 com.oneplus.healthcheck 2>/dev/null
pm disable --user 0 com.oplus.analytics 2>/dev/null
pm disable --user 0 com.oplus.qualityprotect 2>/dev/null
pm disable --user 0 com.oplus.crashbox 2>/dev/null
pm disable --user 0 com.oplus.logkit 2>/dev/null
pm disable --user 0 com.oplus.stdid 2>/dev/null

# --- PHASE 2: PERMANENT GMS RECEIVER DISABLES ---
RECEIVERS=(
    "com.google.android.gms.analytics.AnalyticsReceiver"
    "com.google.android.gms.analytics.AnalyticsService"
    "com.google.android.gms.common.stats.GmsCoreStatsService"
    "com.google.android.gms.stats.service.DropBoxEntryAddedReceiver"
    "com.google.android.gms.measurement.AppMeasurementReceiver"
)

for rcvr in "${RECEIVERS[@]}"; do
    pm disable "$PKG/$rcvr" 2>/dev/null
done

# --- PHASE 3: NETWORK & PERMISSION RESTRICTIONS ---
if [ -n "$GMS_UID" ]; then
    cmd netpolicy add restrict-background-blacklist "$GMS_UID" 2>/dev/null
fi

pm revoke $PKG android.permission.ACCESS_FINE_LOCATION 2>/dev/null
pm revoke $PKG android.permission.ACCESS_COARSE_LOCATION 2>/dev/null
pm revoke $PKG android.permission.BODY_SENSORS 2>/dev/null
pm revoke $PKG android.permission.ACTIVITY_RECOGNITION 2>/dev/null

# --- PHASE 4: CONTINUOUS 3-MINUTE FCM SYNC LOOP ---
while true; do
    # RESTRICT STATE (3 Minutes / 180s)
    cmd deviceidle whitelist -$PKG 2>/dev/null
    cmd appops set $PKG RUN_IN_BACKGROUND ignore
    cmd appops set $PKG RUN_ANY_IN_BACKGROUND ignore
    am set-standby-bucket $PKG restricted 2>/dev/null
    cmd jobscheduler cancel -u 0 $PKG 2>/dev/null
    
    sleep 180

    # UNRESTRICT STATE (25 Seconds - Push Notification Pull)
    cmd deviceidle whitelist +$PKG 2>/dev/null
    cmd appops set $PKG RUN_IN_BACKGROUND allow
    cmd appops set $PKG RUN_ANY_IN_BACKGROUND allow
    am set-standby-bucket $PKG active 2>/dev/null
    
    am broadcast -a com.google.android.intent.action.MCS_HEARTBEAT 2>/dev/null
    am broadcast -a com.google.android.gms.gcm.HEARTBEAT 2>/dev/null

    sleep 25
done &
