/system scheduler
add name=power_on on-event=":delay 20s;\r\
    \n/system script run power_on" policy=read,test start-time=startup
