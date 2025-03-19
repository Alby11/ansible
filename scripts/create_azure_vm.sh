#!/bin/sh

for env in svi qa prod; do
  az vm create \
    --resource-group MyResourceGroup \
    --name ${env}-server \
    --image Ubuntu2404 \
    --admin-username ansiadmin \
    --authentication-type ssh \
    --generate-ssh-keys \
    --size Standard_B1s
done
