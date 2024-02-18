/system scheduler
add interval=1w name=system_reboot on-event="system reboot" policy=\
    reboot,test start-date=1970-01-01 start-time=00:00:00
