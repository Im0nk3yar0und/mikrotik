# Allow DNS traffic
/ip firewall filter
add chain=input action=accept in-interface-list=bridge_lan protocol=udp dst-port=53
add chain=output action=accept protocol=udp dst-port=53

# Force users to use MikroTik DNS - 10.0.0.1
/ip firewall nat
add action=dst-nat chain=dstnat comment="Force users to use MikroTik DNS" \
    dst-address=!10.0.0.1 dst-port=53 in-interface=bridge_lan protocol=\
    udp to-addresses=10.0.0.1 to-ports=53

/ip dns
set allow-remote-requests=yes

/ip dns static
add address=127.0.0.1 name=ad-g.doubleclick.net
add address=127.0.0.1 name=ad.doubleclick.net
add address=127.0.0.1 name=ad.mo.doubleclick.net
add address=127.0.0.1 name=ad.youtube.com
add address=127.0.0.1 name=ads.doubleclick.net
add address=127.0.0.1 name=ads.youtube.com
add address=127.0.0.1 name=akamaiedge.net
add address=127.0.0.1 name=akamaitechnologies.com
add address=127.0.0.1 name=analytic-google.com
add address=127.0.0.1 name=apis.google.com
add address=127.0.0.1 name=clients1.google.com
add address=127.0.0.1 name=doubleclick.net
add address=127.0.0.1 name=googleadapis.l.google.com
add address=127.0.0.1 name=googleads.g.doubleclick.net
add address=127.0.0.1 name=googleads4.g.doubleclick.net
add address=127.0.0.1 name=googleadservices.com
add address=127.0.0.1 name=i1.ytimg.com
add address=127.0.0.1 name=pagead.googlesyndication.com
add address=127.0.0.1 name=pagead.l.doubleclick.net
add address=127.0.0.1 name=pagead1.googlesyndication.com
add address=127.0.0.1 name=pagead2.googlesyndication.com
add address=127.0.0.1 name=pixel.moatads.com
add address=127.0.0.1 name=pubads.g.doubleclick.net
add address=127.0.0.1 name=r1---sn-vgqsen7z.googlevideo.com
add address=127.0.0.1 name=r1.sn-vgqsen7z.googlevideo.com
add address=127.0.0.1 name=r17---sn-vgqsenes.googlevideo.com
add address=127.0.0.1 name=r2---sn-hp57yne7.googlevideo.com
add address=127.0.0.1 name=r2---sn-vgqs7n7k.googlevideo.com
add address=127.0.0.1 name=r20---sn-vgqs7ne7.googlevideo.com
add address=127.0.0.1 name=r20.sn-vgqs7ne7.googlevideo.com
add address=127.0.0.1 name=r3---sn-hp57knsl.googlevideo.com
add address=127.0.0.1 name=r4---sn-vgqs7nez.googlevideo.com
add address=127.0.0.1 name=r4.sn-vgqs7nez.googlevideo.com
add address=127.0.0.1 name=r5---sn-hp57kn6e.googlevideo.com
add address=127.0.0.1 name=r5.sn-32o-guhl.googlevideo.com
add address=127.0.0.1 name=r6---sn-vgqseney.googlevideo.com
add address=127.0.0.1 name=r7---sn-8p8v-bg0d.googlevideo.com
add address=127.0.0.1 name=r8---sn-8p8v-bg0d.googlevideo.com
add address=127.0.0.1 name=redirector.googlevideo.com
add address=127.0.0.1 name=rtd.tubemogul.com
add address=127.0.0.1 name=s.innovid.com
add address=127.0.0.1 name=s0.2mdn.net
add address=127.0.0.1 name=secure-ds.serving-sys.com
add address=127.0.0.1 name=securepubads.g.doubleclick.net
add address=127.0.0.1 name=ssl.google-analytics.com
add address=127.0.0.1 name=static.doubleclick.net
add address=127.0.0.1 name=stats.g.doubleclick.net
add address=127.0.0.1 name=www-google-analytics.l.google.com
add address=127.0.0.1 name=www-googletagmanager.l.google.com
add address=127.0.0.1 name=www.analytic-google.com
add address=127.0.0.1 name=www.googleadservices.com
add address=127.0.0.1 name=www.googletagservices.com
add address=127.0.0.1 name=www.youtube-nocookie.com
add address=127.0.0.1 name=youtube-nocookie.com
add address=127.0.0.1 name=ads1.msads.net
add address=127.0.0.1 name=ads2.msads.net
add address=127.0.0.1 name=a.ads2.msads.net
add address=127.0.0.1 name=b.ads2.msads.net
add address=127.0.0.1 name=adtago.s3.amazonaws.com
add address=127.0.0.1 name=analyticsengine.s3.amazonaws.com
add address=127.0.0.1 name=analytics.s3.amazonaws.com
add address=127.0.0.1 name=advice-ads.s3.amazonaws.com
add address=127.0.0.1 name=advertising-api-eu.amazon.com
add address=127.0.0.1 name=adservice.google.com
add address=127.0.0.1 name=pagead2.googleadservices.com
add address=127.0.0.1 name=afs.googlesyndication.com
add address=127.0.0.1 name=m.doubleclick.net
add address=127.0.0.1 name=mediavisor.doubleclick.net
add address=127.0.0.1 name=app-measurement.com
add address=127.0.0.1 name=analytics.google.com
add address=127.0.0.1 name=click.googleanalytics.com
add address=127.0.0.1 name=google-analytics.com
add address=127.0.0.1 match-subdomain=yes name=facebook.net
add address=127.0.0.1 match-subdomain=yes name=fb.com
add address=127.0.0.1 match-subdomain=yes name=fb.gg
add address=127.0.0.1 match-subdomain=yes name=fbwat.ch
add address=127.0.0.1 match-subdomain=yes name=messenger.com
add address=127.0.0.1 match-subdomain=yes name=fb.me
add address=127.0.0.1 match-subdomain=yes name=m.me
add address=127.0.0.1 match-subdomain=yes name=facebook.com
add address=127.0.0.1 match-subdomain=yes name=fbcdn.net
add address=127.0.0.1 match-subdomain=yes name=fbsbx.com
add address=127.0.0.1 name=an.facebook.com
add address=127.0.0.1 name=static.ads-twitter.com
add address=127.0.0.1 name=ads-api.twitter.com
add address=127.0.0.1 name=ads.linkedin.com
add address=127.0.0.1 name=analytics.pointdrive.linkedin.com
add address=127.0.0.1 name=events.reddit.com
add address=127.0.0.1 name=events.redditmedia.com
add address=127.0.0.1 name=ads-api.tiktok.com
add address=127.0.0.1 name=analytics.tiktok.com
add address=127.0.0.1 name=ads-sg.tiktok.com
add address=127.0.0.1 name=analytics-sg.tiktok.com
add address=127.0.0.1 name=business-api.tiktok.com
add address=127.0.0.1 name=ads.tiktok.com
add address=127.0.0.1 name=log.byteoversea.com
