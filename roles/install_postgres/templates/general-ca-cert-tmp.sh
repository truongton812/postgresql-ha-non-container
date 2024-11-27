#!/bin/bash
NAME={{ inventory_hostname }}
ADDRESS=127.0.0.1,localhost,{{ inventory_hostname }},{{ ansible_host }}
echo '{"CN":"'$NAME'","hosts":[""],"key":{"algo":"rsa","size":2048}}' | ./cfssl gencert -config=ca-config.json -ca=ca.pem -ca-key=ca-key.pem -hostname="$ADDRESS" - | ./cfssljson -bare $NAME
cp *.pem /etc/etcd/
chmod 755 /etc/etcd/*-key.pem
chown etcd:etcd /etc/etcd/*.pem