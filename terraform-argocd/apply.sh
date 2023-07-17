#!/bin/bash

terraform apply plan.tfplan

terraform output -json > eks.json
