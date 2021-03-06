#!/usr/bin/env bash

work_dir=$1
master_ip=$2
ip=`/sbin/ifconfig eth0|grep inet|grep -v inet6|awk '{print $2}'|cut -d : -f2`
hostname=`hostname`

#config mesos slave env
sed -i s/MESOS_IP=.*/MESOS_IP=${ip}/ ${work_dir}/docker-compose/slave/mesos_slave_env
sed -i s/MESOS_HOSTNAME=.*/MESOS_HOSTNAME=${hostname}/ ${work_dir}/docker-compose/slave/mesos_slave_env
sed -i s@MESOS_MASTER=.*@MESOS_MASTER=zk://${master_ip}@ ${work_dir}/docker-compose/slave/mesos_slave_env
