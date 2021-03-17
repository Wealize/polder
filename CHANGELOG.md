## CHANGELOG

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

- Add logos volume to wirecloud to allow header image manipulation
- Change default keyrock secrets
- Added ingress network policy to broker pods
- Added mysql db for keyrock to terraform
- Added keyrock and wilma integration
- Use efs instead of ebs volume in wirecloud
- Added nginx to wirecloud deployment
- Fixed ingress path value typo
- Added wirecloud deploy tunning and corrections
- Sort k8s resources labels
- Added wirecloud deployment, service and ingress
- Added wirecloud db and a remove postgres security group from mongo
- Added k8s deployment instructions and override-values.yaml file example
- Fixed liveness probes failing in the k8s deployment and labels missmatch
- Added envvar to orion deployment
- Added HorizontalPodAutoscaler templates for orion and draco
- Added Terraform configuration for MongoDB Orion Broker and PostgreSQL database
