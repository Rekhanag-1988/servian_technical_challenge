
### Solution Design Diagrams

[diagrams](diagrams) holds the basic high level solution design. These are hand scribled, sorry for that as I dint get time to use as AWS Icons.


## Infra Directory structure

* BuildSpecs:
	* inputs: Holds input files needed in any of the codebuild-projects
	* scripts: Common place to keep all the scripts which can be used across the codebuild-projects
	* yamls: codebuild-project yaml specs
* cloudformation:
	We are using sceptre as an abstraction layer over cloudformation.
	* config: environment specific calling template references
	* envvars: environment specific variables
	* templates: actual cloudformation templates.

## Operation Modle

We have mgmt or CICD VPC which does all the work for dev/prod workload-vpc's deployment. Actually we can have one in each AWS account as its a overhead for this demo have kept them on in each VPC.

Dev-Codepipeline:
	* This pipeline will run for every commit do on the development branch. Build-->deploy(dev)-->test-->release-ami
Prod-Codepipeline:
	* Once you merge to master, this will be kicked off. Get-Ami-->manual-approvl-->deploy(prod)

For every commit complete infra will be updated, if there are no changes nothing will be done.