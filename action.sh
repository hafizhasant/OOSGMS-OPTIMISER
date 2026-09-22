#!/system/bin/sh
# On-Demand Manual Notification Sync Trigger

echo "========================================"
echo "    OOSGMS OPTIMISER: MANUAL SYNC      "
echo "========================================"

echo "[+] Unrestricting Google Play Services..."
cmd deviceidle whitelist +com.google.android.gms 2>/dev/null
cmd appops set com.google.android.gms RUN_IN_BACKGROUND allow
cmd appops set com.google.android.gms RUN_ANY_IN_BACKGROUND allow
am set-standby-bucket com.google.android.gms active 2>/dev/null

echo "[+] Sending FCM Heartbeat signal..."
am broadcast -a com.google.android.intent.action.MCS_HEARTBEAT 2>/dev/null
am broadcast -a com.google.android.gms.gcm.HEARTBEAT 2>/dev/null

echo "[+] FCM Heartbeat triggered! Syncing notifications..."
sleep 5

echo "[+] Re-applying background restrictions..."
cmd deviceidle whitelist -com.google.android.gms 2>/dev/null
cmd appops set com.google.android.gms RUN_IN_BACKGROUND ignore
cmd appops set com.google.android.gms RUN_ANY_IN_BACKGROUND ignore
am set-standby-bucket com.google.android.gms restricted 2>/dev/null

echo "========================================"
echo "          Sync Completed!               "
echo "========================================"
