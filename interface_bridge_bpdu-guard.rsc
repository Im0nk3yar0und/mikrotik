# BPDU Guard is a security feature found in multiple networking devices.
# It helps to prevent attacks on a network by blocking Bridge Protocol Data Units (BPDUs) that are sent from unauthorized devices. 
# When BPDU Guard is enabled, it will immediately disable any port that receives a BPDU, reducing the risk of attacks on the network. 
# In order for this feature to work properly, it should only be enabled on edge ports or those that connect to external networks, as disabling BPDUs on internal ports can disrupt communication within the network itself. 
# Generally speaking, it is recommended to enable BPDU Guard as an added layer of security for your network.


/interface bridge port
add bpdu-guard=yes bridge=bridge_lan comment=defconf interface=ether2
add bpdu-guard=yes bridge=bridge_lan comment=defconf interface=ether3
add bpdu-guard=yes bridge=bridge_lan comment=defconf interface=ether4
add bpdu-guard=yes bridge=bridge_lan comment=defconf interface=ether5
add bpdu-guard=yes bridge=bridge_lan comment=defconf interface=ether6
add bpdu-guard=yes bridge=bridge_lan comment=defconf interface=ether7
add bpdu-guard=yes bridge=bridge_lan comment=defconf interface=ether8
add bpdu-guard=yes bridge=bridge_lan comment=defconf interface=sfp-sfpplus1
