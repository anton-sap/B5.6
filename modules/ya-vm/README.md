# Some info about config
## What it is?
This Terraform configuration creates two Yandex Cloud Compute Instance in Yandex Cloud. First is LAMP and the second is LEMP.\
Also will be created Yandex Load Balancer that balance http/80 between two nodes

Balancer address included in oputput called "lb_external_ip"