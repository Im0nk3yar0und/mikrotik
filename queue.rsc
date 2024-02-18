/queue tree
add disabled=yes max-limit=10M name="All Bandwidth" parent=global priority=1
add disabled=yes max-limit=10M name=Download packet-mark=client_dw_pk parent=\
    "All Bandwidth" priority=2
add disabled=yes max-limit=10M name=Upload parent="All Bandwidth"
add disabled=yes max-limit=10M name=http-dw packet-mark=http_dw_pk parent=\
    Download priority=1 queue=pcq-download-default
add disabled=yes max-limit=10M name=other_dw packet-mark=other_dw_pk parent=\
    Download priority=6 queue=pcq-download-default
add disabled=yes max-limit=10M name=http_up packet-mark=http_up_pk parent=\
    Upload priority=1 queue=pcq-upload-default
add disabled=yes max-limit=10M name=other_up packet-mark=other_up_pk parent=\
    Upload priority=6 queue=pcq-upload-default
add disabled=yes max-limit=10M name=p2p_dw packet-mark=p2p_dw_pk parent=\
    Download queue=pcq-download-default
add disabled=yes max-limit=10M name=p2p_up packet-mark=p2p_up_pk parent=\
    Upload queue=pcq-upload-default
