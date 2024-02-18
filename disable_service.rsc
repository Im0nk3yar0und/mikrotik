/ip firewall service-port
set ftp disabled=yes
set tftp disabled=yes
set h323 disabled=yes
set sip disabled=yes
set pptp disabled=yes


/ip service
set telnet disabled=yes
set ftp disabled=yes
set www disabled=yes
set ssh disabled=yes
set api disabled=yes
set winbox address=10.0.0.0/24
set api-ssl disabled=yes

/ip neighbor discovery-settings
set discover-interface-list=none

/tool bandwidth-server
set enabled=no


/tool mac-server
set allowed-interface-list=none

/tool mac-server mac-winbox
set allowed-interface-list=none

/tool mac-server ping
set enabled=no
