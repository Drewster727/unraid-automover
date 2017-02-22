#!/bin/bash

# This unRAID bash script will run the mover if the cache drive is over a certain percentage full

# Modify the value to set what percentage is the threshold to start the mover
SETPOINT=70

# Only run script if cache disk enabled and in use (script chunk taken from stock mover script at /usr/local/sbin/mov$
if [ ! -d /mnt/cache -o ! -d /mnt/user0 ]; then
  exit 0
fi

# If the mover is already running then exit (script chunk taken from stock mover script at /usr/local/sbin/mover - ju$
if [ -f /var/run/mover.pid ]; then
  if ps h `cat /var/run/mover.pid` | grep mover ; then
      echo "mover already running" | /usr/bin/logger -s -tpercent_mover.sh[$$]
      exit 0
  fi
fi

# Check how full the cache drive is
AMOUNTFULL=$(df | grep /mnt/cache | awk '{ printf "%d", $5 }')

# Simple logic - if setpoint has been met or exceeded, run the mover. If not, don't run.
if [ "$AMOUNTFULL" -ge "$SETPOINT" ]
    then
        echo "Cache is $AMOUNTFULL% full, which is greater than or equal to the set point of $SETPOINT%. Running move$
        /usr/local/sbin/mover
    else
        echo "Cache is $AMOUNTFULL% full, which is less than the set point of $SETPOINT%. Not running mover." | /usr/$
fi
