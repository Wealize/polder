## CHANGELOG

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

- Fix liveness probes failing in the k8s deployment and labels missmatch
- Added envvar to orion deployment
- Added HorizontalPodAutoscaler templates for orion and draco
- Added Terraform configuration for MongoDB Orion Broker and PostgreSQL database
