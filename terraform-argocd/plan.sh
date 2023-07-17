#!/bin/bash

terraform plan \
  -var-file ./demo.tfvars \
  -var-file ./common.tfvars \
  -out plan.tfplan

