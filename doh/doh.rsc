# CA certificates extracted from Mozilla
/tool fetch url=https://curl.se/ca/cacert.pem;

# Certificate from CloudFlare
/tool/fetch https://developers.cloudflare.com/cloudflare-one/static/documentation/connections/Cloudflare_CA.pem;

# Import certificate
/certificate import file=Cloudflare_CA.pem passphrase="";
/certificate import file-name=cacert.pem passphrase="";

/ip dns
set allow-remote-requests=yes use-doh-server=\
    https://cloudflare-dns.com/dns-query verify-doh-cert=yes

# Remove the old upstream DNS resolvers
/ip dns set servers=""

# Delete the certificate file
/file remove cacert.pem
/file remove Cloudflare_CA.pem

/ip dns static
add address=104.16.248.249 name=cloudflare-dns.com
add address=104.16.249.249 name=cloudflare-dns.com
