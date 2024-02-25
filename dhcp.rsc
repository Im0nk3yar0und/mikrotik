# Set DHCP network settings
/ip dhcp-server network
add address=192.168.1.0/24 comment="LAN Network" dns-server=192.168.1.1 gateway=192.168.1.1 netmask=24


# Set DHCP server settings
/ip dhcp-server
add address-pool=dhcp_pool1 authoritative=yes disabled=no interface=ether2 name=dhcp1

# Define DHCP address pool
/ip pool
add name=dhcp_pool1 ranges=192.168.1.10-192.168.1.254

/ip dns
set servers=8.8.8.8,8.8.4.4

# Enable DHCP server on the interface
/interface ethernet
set ether2 dhcp-server=dhcp1
