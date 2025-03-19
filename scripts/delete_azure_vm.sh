#!/bin/sh

for env in svi qa prod; do
  az vm delete \
    --resource-group MyResourceGroup \
    --name ${env}-server \
    --yes
done
