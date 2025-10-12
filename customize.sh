#!/system/bin/sh

# Compatability
su -c pm enable "com.google.android.gms/com.google.android.gms.semanticlocation.service.SemanticLocationService" # Fix timeline
cmd package install-existing com.oplus.powermonitor # Enable powermonitor, as we now bind mount it instead

ui_print "Please consider checking out my kernel on xda: https://xdaforums.com/t/kernel-open-beta-epicmann24s-sm8750-kernel-sukisu-ksun-susfs.4719831/"

ui_print "Logs will be saved to /data/adb/modules/OOSGMS-OPTIMISER/logs"
ui_print "Please Restart :)"

