# Blocks TikTok traffic by matching the URL pattern using Layer 7 protocol matching
/ip firewall layer7-protocol
add name=Tiktok regexp="^.+(tiktok.com|musical.ly).*\$"

/ip firewall filter
add action=drop chain=input comment=\
    "# Block TikTok With \"Layer-7\"" disabled=no dst-port=443 \
    layer7-protocol=Tiktok out-interface=ether1 protocol=tcp
   
# Blocks traffic containing "tiktok" in the HTTP content
/ip firewall filter
 add action=drop chain=input comment=\
    "# Block TikTok With \"Content\"" content=tiktok.com disabled=no \
    dst-port=443 out-interface=ether1 protocol=tcp
    
add action=drop chain=input content=.tiktok. disabled=no \
    dst-port=443 out-interface=ether1 protocol=tcp



# Blocks traffic to "*.tiktok.com" based on the TLS host header
/ip firewall filter
add action=drop chain=input comment=\
    "# Block TikTok with tls-header" disabled=no dst-port=443 \
    out-interface=ether1 protocol=tcp tls-host=*.tiktok.com
