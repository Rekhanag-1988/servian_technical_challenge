# Servian DevOps Tech Challenge - Tech Challenge App and Infra Solution


## Overview

This repo is the mono-repo holding both the application [source code](app) and [infrastructure-as-source-code](infra).

## Solution

Have decided to go with AWS as its my daily job. Options available are:

* Auto-Scaling-Group with EC2 Fleet.
* ECS with EC2 or FarGate as backend.
* EKS 

Having Application-Load-Balancer as a front end.

To keep it simple had to weigh the decision between option1 and option2. EKS appears a bit costlier when compared to other two. Finally decided to go with option1 which is Auto-Scaling-Group with EC2 Fleet.

## App-Urls

We are accesing application via ALB dns-names. Below are the dns-names until we recreate the complete stacks.

DEV: http://alb-d-LoadB-1CS3UIVH2WU0M-2092728165.ap-southeast-2.elb.amazonaws.com/ \
PROD: http://alb-p-LoadB-MJLVA2S0A8H7-926933410.ap-southeast-2.elb.amazonaws.com/

Deployment will not be having any downtime to the application

## DEMOS

[Initial-Infra-Set-Up](https://youtu.be/REdljU6y4oA)

[Pipeline-Deployments](https://youtu.be/REdljU6y4oA)

