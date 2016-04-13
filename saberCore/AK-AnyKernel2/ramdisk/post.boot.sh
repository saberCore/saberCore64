#!/system/bin/sh

# Custom Kernel Settings for fuckery!!


PATH=/sbin:/system/sbin:/system/bin:/system/xbin
export PATH

BBX=/system/xbin/busybox

# Inicio
mount -o remount,rw -t auto /
mount -o remount,rw -t auto /system
mount -t rootfs -o remount,rw rootfs

if [ -f $BBX ]; then
	chown 0:2000 $BBX
	chmod 0755 $BBX
	$BBX --install -s /system/xbin
	ln -s $BBX /sbin/busybox
	ln -s $BBX /system/bin/busybox
	sync
fi

# Google Services battery drain fixer
# stop google service and restart it on boot. this remove high cpu load and ram leak!
	if [ "$($BBX pidof com.google.android.gms | wc -l)" -eq "1" ]; then
		$BBX kill "$($BBX pidof com.google.android.gms)";
	fi;
	if [ "$($BBX pidof com.google.android.gms.unstable | wc -l)" -eq "1" ]; then
		$BBX kill "$($BBX pidof com.google.android.gms.unstable)";
	fi;
	if [ "$($BBX pidof com.google.android.gms.persistent | wc -l)" -eq "1" ]; then
		$BBX kill "$($BBX pidof com.google.android.gms.persistent)";
	fi;
	if [ "$($BBX pidof com.google.android.gms.wearable | wc -l)" -eq "1" ]; then
		$BBX kill "$($BBX pidof com.google.android.gms.wearable)";
	fi;

# Google Services battery drain fixer by Alcolawl@xda
# http://forum.xda-developers.com/google-nexus-5/general/script-google-play-services-battery-t3059585/post59563859
pm enable com.google.android.gms/.update.SystemUpdateActivity
pm enable com.google.android.gms/.update.SystemUpdateService
pm enable com.google.android.gms/.update.SystemUpdateService$ActiveReceiver
pm enable com.google.android.gms/.update.SystemUpdateService$Receiver
pm enable com.google.android.gms/.update.SystemUpdateService$SecretCodeReceiver
pm enable com.google.android.gsf/.update.SystemUpdateActivity
pm enable com.google.android.gsf/.update.SystemUpdatePanoActivity
pm enable com.google.android.gsf/.update.SystemUpdateService
pm enable com.google.android.gsf/.update.SystemUpdateService$Receiver
pm enable com.google.android.gsf/.update.SystemUpdateService$SecretCodeReceiver


# Power Effecient Workqueues (Enable for battery)

echo "1" > /sys/module/workqueue/parameters/power_efficient
echo "0" > /sys/module/subsystem_restart/parameters/enable_ramdumps
