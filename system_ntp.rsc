/system ntp client
set enabled=yes

/system ntp client servers
add address=0.pool.ntp.org
add address=1.pool.ntp.org
add address=2.pool.ntp.org
add address=3.pool.ntp.org

/system clock
set time-zone-name=Europe/Belgrade
