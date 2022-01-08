#!/bin/bash

# Instructions taken from: https://gedim21.github.io/devops/tutorial/mongodb-cluster-docker-compose/

# First, you’ll need a key that the cluster nodes will use to communicate with each other.
#
# The key’s length must be between 6 and 1024 characters and may only contain characters in the base64 set. We can generate such a key using openssl:
KEY_FILE=mongo-replication.key
if test -f "$KEY_FILE";
then
  echo "$KEY_FILE already exists"
else
  echo "Creating $KEY_FILE"
  openssl rand -base64 768 > $KEY_FILE

  # Then reduce the permissions on the key, else MongoDB will complain that the key is too open.
  chmod 400 $KEY_FILE
  # sudo chown 999:999 $KEY_FILE
fi

DOCKER_NETWORK="$(basename $PWD)_default"
echo "Network: $DOCKER_NETWORK"

# Start the services using:
docker-compose up -d

# Initialize the replica set
docker run --rm --network $DOCKER_NETWORK mongo:5 mongosh --username admin --password admin --host mongodb_1:27017  --authenticationDatabase admin admin --eval "$(< init-replica-set.js)"

# Wait for primary election
sleep 5

# Create a user
docker run --rm --network $DOCKER_NETWORK mongo:5 mongosh --username admin --password admin --host mongodb_1:27017 --authenticationDatabase admin admin --eval "$(< init-user.js)"
