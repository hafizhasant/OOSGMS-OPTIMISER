SKIPUNZIP=0

ui_print "--------------------------------------"
ui_print "       OOS & GMS OPTIMISER v2.1.0     "
ui_print "--------------------------------------"
ui_print "- Target: OxygenOS 16 / Android 16"

# Verify SDK/Android Version
SDK_VER=$(getprop ro.build.version.sdk)
if [ "$SDK_VER" -lt 36 ]; then
    ui_print "! Warning: Device is below Android 16 (SDK $SDK_VER)."
fi

ui_print "- Applying executable permissions..."
set_perm_recursive $MODPATH 0 0 0755 0644
set_perm $MODPATH/service.sh 0 0 0755
set_perm $MODPATH/post-fs-data.sh 0 0 0755
set_perm $MODPATH/action.sh 0 0 0755
