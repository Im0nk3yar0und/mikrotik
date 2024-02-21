# Securing Your MikroTik

This guide provides step-by-step instructions for enhancing the security of your router by implementing various configuration settings in RouterOS.
By following these recommendations, you can better protect your network infrastructure from unauthorized access and potential security threats.

\
&nbsp;

## Change Default Username and Password
It's crucial to change the default username and password to prevent unauthorized access to your router. 
```bash
/user add name=myname password=mypassword group=full 
/user remove admin
```
\
&nbsp;

## Change Password
Create strong passwords.Password security starts with creating a strong password.
- Use at least 16 characters long
- Use a combination of uppercase letters, lowercase letters, numbers, and symbols.
- Do not use a words that can be found in dictionary or the name of a person, character, product, or organization.
- Use password that is easy for you to remember but difficult for others to guess.
```
/password
```
\
&nbsp;

## Access Control by IP Address
Restricting access to your router based on IP addresses helps mitigate potential security risks.
```bash
/user set 0 address=192.168.10.0/24
```
\
&nbsp;

## Disable Unnecessary Services

Disabling unused services reduces the attack surface of your router.
```bash
/ip service disable [find name=telnet]
/ip service disable [find name=ftp]
/ip service disable [find name=www]
/ip service disable [find name=www-ssl]
/ip service disable [find name=api]
/ip service disable [find name=api-ssl]
```
\
&nbsp;

## Change Default SSH Port
Changing the default SSH port adds another level of security by making it harder for attackers to target.
```
/ip service set ssh port=2200
```
\
&nbsp;

## More Secure SSH Access
Enhance SSH security by enabling strong cryptography and regenerating SSH host keys.
```bash
/ip ssh set strong-crypto=yes
/ip ssh set allow-none-crypto=no
/ip ssh regenerate-host-key
```
\
&nbsp;

## RouterOS MAC Access Control
Restricting MAC-based access adds an extra layer of security to your network.
```bash
/tool mac-server set allowed-interface-list=none 
/tool mac-server mac-winbox set allowed-interface-list=none 
/tool mac-server ping set enabled=no
```

Verify that MAC-based access services have been disabled
```bash
/tool mac-server print
/tool mac-server mac-winbox print
/tool mac-server ping print
```
\
&nbsp;

## Bandwidth Test
Disabling bandwidth testing prevents potential abuse and unauthorized usage.
```
/tool bandwidth-server set enabled=no
```
\
&nbsp;

## RoMON
We should also disable the new RoMON feature, assuming that you aren't using it. <br>
If you're using RoMON for device management then leave it on, but if you aren't using it then disable it to reduce the attack surface.
```bash
/tool romon set enabled=no
```
\
&nbsp;

## Neighbor Discovery
Another best practice is to disable neighbor discovery, which will stop the router from being discovered by other devices running Mikrotik Neighbor Discovery Protocol (NDP) or Cisco Discovery Protocol (CDP).
```bash
/ip neighbor discovery-settings set discover-interface-list=none
/ipv6/nd set 0 disabled=yes
```
\
&nbsp;

## DNS Cache
Disabling remote DNS requests helps prevent DNS cache poisoning attacks.
```
/ip dns set allow-remote-requests=no
```
\
&nbsp;

## Block all IPv6 traffic
Disabling IPv6 when it's not actively used can enhance network security by reducing the attack surface.<br>
Unused IPv6 increases the risk of vulnerabilities and compatibility issues without providing tangible benefits. <br>
By disabling it, organizations can streamline operations, minimize potential risks, and ensure smoother network functionality
```bash
/ipv6/firewall/filter
add chain=input action=drop protocol=icmpv6 comment="Drop all IPv6 ICMP traffic"
add chain=input action=drop comment="Drop all other IPv6 traffic"

add chain=forward action=drop comment="Drop all IPv6 forward traffic"

add chain=output action=drop comment="Drop all IPv6 output traffic"
```
\
&nbsp;

## Other Client Services
Disabling various client services further secures your router.
```bash
/ip proxy set enabled=no 
/ip socks set enabled=no 
/ip upnp set enabled=no 
/ip cloud set ddns-enabled=no update-time=no
```
\
&nbsp;

#### STP - Guard
When deploying a spanning tree protocol on a Layer 2 network, you are advised to configure BPDU protection on edge ports to prevent network topology changes and service traffic interruptions caused by BPDU attacks on the edge ports.
```bash
/interface bridge port add bpdu-guard=yes bridge=bridge_lan comment=defconf edge=yes interface=ether2
```

|   |   |
|---|---|
|**bpdu-guard** (_yes \| no_; Default: **no**)|Enables or disables BPDU Guard feature on a port. This feature disables a port if it receives a BPDU and requires the port to be manually re-enabled if a BPDU was received. Should be used to prevent a bridge from BPDU related attacks. This property has no effect when protocol-mode is set to `none`.|

\
&nbsp;

## Reverse Path Filtering
Reverse Path Filtering (RPF) is a technique used in networking to prevent the forwarding of packets that have invalid source IP addresses.
It's primarily employed in preventing IP address spoofing, a technique often used in various types of network attacks.<br>
**Source IP Address Validation**: When a router receives a packet, it checks the source IP address against its routing table to ensure that the packet came from a legitimate path.
```bash
/ip settings set rp-filter=strict
```
\
&nbsp;

## SYN cookiews
SYN cookies are a technique used in networking and network security to mitigate the effects of SYN flood attacks, a type of Denial-of-Service (DoS) attack.
SYN flood attacks target the three-way handshake process of the TCP protocol to overwhelm a server with a large number of connection requests, ultimately causing it to become unresponsive to legitimate requests.<br>

```bash
/ip settings set tcp-syncookies=yes
```

**SYN Cookies**: Instead of maintaining a state for each incomplete connection in memory, which can be quickly depleted during a SYN flood attack, servers that support SYN cookies can use a cryptographic technique to encode information about the connection in the initial SYN-ACK packet sent to the client. This encoded information includes a timestamp, a sequence number, and other data necessary to reconstruct the connection if the client responds with the expected ACK packet.

\
&nbsp;

## Banner
 Set a login banner that is displayed when someone logs into the router. This is required by a number of compliance standards.

```bash
/system note set show-at-login=yes
/system note set note="Authorized administrators only. Access to this device is monitored."
```
\
&nbsp;

## Set router name
While not a primary security measure on its own, having a unique router name can be part of a defense-in-depth strategy.
It adds another layer of identification and helps detect unauthorized devices or changes to the network.
```bash
/system identity set name="mtk_Home"
```
\
&nbsp;

## NTP Clock Synchronization
When a router's clock isn't correct any log analysis or log correlation becomes very difficult because the timestamps can't be trusted.
```bash
/system ntp client
set enabled=yes

/system ntp client servers
add address=0.pool.ntp.org
add address=1.pool.ntp.org
add address=2.pool.ntp.org
add address=3.pool.ntp.org

/system clock
set time-zone-name=Europe/Belgrade

/ip firewall filter 
add chain=output protocol=udp src-port=123 action=accept comment="Allow NTP outgoing traffic"
```
\
&nbsp;

## Reboot
After making these changes, it's advisable to reboot your system to apply them effectively.
```bash
/system reboot
```
