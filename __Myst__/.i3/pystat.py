#!/home/boring/bin/python3
import copy
import os

import yaml

from i3pystatus import Status

status = Status(standalone=True)

with open(os.path.expanduser("~/Documents/colors.yaml")) as colors_file:
    colors = yaml.safe_load(colors_file)

green = colors["base0B"]
red = colors["base08"]
yellow = colors["base0A"]

default_hints = {
    "separator": False, }


def merge_dicts(a, b):
    merged = copy.deepcopy(a)
    merged.update(b)
    return merged

# Displays clock like this:
# Tue 30 Jul 11:59:46 PM KW31
#                          ^-- calendar week
status.register("clock",
    format="%d-%m-%Y %H:%M:%S",
    hints=default_hints,
)

# Shows the average load of the last minute and the last 5 minutes
# (the default value for format is used)
status.register("load",
                hints=default_hints)
#status.register("cpu_usage_bar",
#    start_color=green,
#    end_color=red,
#    hints=default_hints,
#)
#
# Shows your CPU temperature, if you have a Intel CPU
status.register("temp",
    format="{temp:.0f}°C",
    hints=default_hints,
)

# The battery monitor has many formatting options, see README for details

# This would look like this, when discharging (or charging)
# ↓14.22W 56.15% [77.81%] 2h:41m
# And like this if full:
# =14.22W 100.0% [91.21%]
#
# This would also display a desktop notification (via D-Bus) if the percentage
# goes below 5 percent while discharging. The block will also color RED.
# If you don't have a desktop notification demon yet, take a look at dunst:
#   http://www.knopwob.org/dunst/
status.register("battery",
    #format="{status}/{consumption:.2f}W {percentage:.2f}% [{percentage_design:.2f}%] {remaining:%E%hh:%Mm}",
    format="{status} {percentage:.2f}%",
    alert=True,
    alert_percentage=5,
    full_color=green,
    charging_color=yellow,
    critical_color=red,
    status={
        "DIS": "↓",
        "CHR": "↑",
        # "FULL": "=",
        "FULL": "\N{BATTERY}",
    },
    hints=default_hints,
)

# This would look like this:
# Discharging 6h:51m
#status.register("battery",
#    format="{status} {remaining:%E%hh:%Mm}",
#    alert=True,
#    alert_percentage=5,
#    status={
#        "DIS":  "Discharging",
#        "CHR":  "Charging",
#        "FULL": "Bat full",
#    },)

# Displays whether a DHCP client is running
#status.register("runwatch",
#    name="DHCP",
#    path="/var/run/dhclient*.pid",)

# Shows the address and up/down state of eth0. If it is up the address is shown in
# green (the default value of color_up) and the CIDR-address is shown
# (i.e. 10.10.10.42/24).
# If it's down just the interface name (eth0) will be displayed in red
# (defaults of format_down and color_down)
#
# Note: the network module requires PyPI package netifaces
status.register("network",
    interface="eth0",
    format_up="{v4cidr}",
    format_down="",  # Don't display anything if eth0 is down
    color_up=green,
    color_down=red,
    hints=default_hints,
)

# Note: requires both netifaces and basiciw (for essid and quality)
status.register("network",
    interface="wlan0",
    format_up="{essid} {quality:03.0f}%",
    format_down="",
    color_up=green,
    color_down=red,
    hints=default_hints,
)

# Shows disk usage of /
# Format:
# 42/128G [86G]
status.register("disk",
    path="/",
    #format="{used}/{total}G [{avail}G]",)
    format="{avail}G avail.",
    hints=default_hints,
)

# Shows pulseaudio default sink volume
#
# Note: requires libpulseaudio from PyPI
status.register("pulseaudio",
    format="♪{volume}",
    hints=default_hints,
)

status.register("cmus",
    hints = merge_dicts(default_hints, {
        "markup": "none",
        "separator": False,
    }),
    format="{status}[ - {title}]",
    format_not_running = "" and "Not running",
)

# Shows mpd status
# Format:
# Cloud connected▶Reroute to Remain
#status.register("mpd",
#    format="{title}{status}{album}",
#    status={
#        "pause": "▷",
#        "play": "▶",
#        "stop": "◾",
#    },)

status.run()
