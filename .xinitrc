#!/bin/sh
xsetroot -solid "#008080"
xset s off -dpms
for c in "VBoxClient-all" "vmware-user-suid-wrapper" "spice-vdagent"; do
  command -v ${c%% *} >/dev/null 2>&1 && $c &
done
command -v nm-applet >/dev/null 2>&1 && nm-applet &
exec icewm-session
