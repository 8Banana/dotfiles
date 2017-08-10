#!/usr/bin/env bash

scrot /tmp/screen_locked.png
convert /tmp/screen_locked.png -scale 1% -scale 10000% /tmp/screen_locked2.png
i3lock -i /tmp/screen_locked2.png
