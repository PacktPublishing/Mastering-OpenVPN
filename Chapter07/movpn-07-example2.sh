#!/bin/sh
DBFILE="/var/openvpn/movpn.sqlite3"
DBBUFFER="/var/openvpn/buffer.sql"

db_query (){
    SQL="$1"
    /usr/local/bin/sqlite3 $DBFILE "$SQL"
    if [ $? -ne 0 ];
    then
        # There was an error, write the SQL out to a buffer file
        echo "$SQL" | tr -d "\t" | tr -d "\n" | tee -a $DBBUFFER
        echo ";" | tee -a $DBBUFFER
    fi
}

logger "OpenVPN Type: $script_type"
case "$script_type" in
    client-connect)
        # do record insert
        logger "OpenVPN: client-connect"
        SQL="
INSERT INTO vpn_session (
cn, connect_time, vpn_ip4,
vpn_ip6, remote_ip4
) VALUES (
'$common_name', '$time_unix',
'$ifconfig_pool_remote_ip',
'$ipconfig_ipv6_remote',
'$untrusted_ip'
)"
        db_query "$SQL"
        ;;
    client-disconnect)
    # update the record, if it's found
        logger "OpenVPN: client-disconnect"
        SQL="
UPDATE
vpn_session
SET
disconnect_time = '$time_unix'
WHERE
cn = '$common_name'
AND disconnect_time IS NULL
AND session_id = (
SELECT MAX(session_id)
FROM vpn_session
WHERE cn = '$common_name'
)
"
        db_query "$SQL"
        ;;
esac
exit 0
