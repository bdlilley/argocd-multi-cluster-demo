#!/bin/bash

terraform destroy \
  -var-file ./demo.tfvars \
  -var-file ./common.tfvars
