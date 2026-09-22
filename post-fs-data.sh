#!/system/bin/sh
# Early boot tweaks for OxygenOS 16 / Android 16

# Disable kernel debugging and telemetry loggers early
resetprop -n persist.sys.assert.enable false
resetprop -n persist.sys.oplus.crash.catch false
resetprop -n persist.sys.log.output false

# Aggressive Doze and Deep Sleep parameters
resetprop -n device_idle_constants "inactive_to=30000,sensing_to=0,locating_to=0,location_accuracy=20.0,motion_inactive_to=0,idle_after_inactive_to=0,idle_to=3600000,max_idle_to=21600000"
