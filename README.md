# Some info about config
## What it is?
This Terraform configuration creates two Yandex Cloud Compute Instance in Yandex Cloud. First is LAMP and the second is LEMP.\
Also will be created Yandex Load Balancer that balance http/80 between two nodes.

LAMP Node external IP included in ya-vm-1_internal_ip_address output.
LEMP Node external IP included in ya-vm-2_internal_ip_address output.

Balancer address included in oputput called "lb_external_ip"