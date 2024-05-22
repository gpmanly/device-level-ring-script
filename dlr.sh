#!/bin/sh

start(){
        fw_setenv eth1_ports 3
        fw_setenv eth1_proto dlr
        fw_setenv eth1_vlan 0x7e

        fw_setenv eth2_vlan 0x7f
        fw_setenv multi_dev 1

        fw_setenv stp 0

        fw_setenv ipaddr 192.168.1.1

        /etc/init.d/rcK
        /etc/init.d/rcS

        # Start the DLR supervisor
        # If this switch is not the supervisor, remove the command below
        echo 3 > /sys/class/net/eth0/dlrfs/node

}

stop(){
        fw_setenv eth1_ports
        fw_setenv eth1_proto
        fw_setenv eth1_vlan

        fw_setenv eth2_vlan
        fw_setenv multi_dev 0

        fw_setenv stp 0

        /etc/init.d/rcK
        /etc/init.d/rcS

}

case $1 in
start)
        start
        ;;
stop)
        stop
        ;;
*)
        echo "Usage: $0 {start|stop}"
        exit 1
        ;;
esac

exit $?