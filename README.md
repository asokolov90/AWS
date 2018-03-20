# Terraform AWS environment for SpringBoot
General purpose: Set of Load Balanced VMs for Spring Boot Maven


Boxes are deployed via terraform , code deployment for the moment is pure automated git download and maven clean install.

General descitions: 
setup : public subnet , ELB , t2.micro VMs
deployment: because of unforseen issues with puppet -> pure git download and maven install for the moment
ELB monitoring and healthcheck
puppet deployment still under development.

How to start:

download the repo run terraform plan and apply.
