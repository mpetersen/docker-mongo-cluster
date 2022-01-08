# docker-mongo-cluster

This repository sets up a MongoDB Cluster on your local machine using Docker.

The idea is taken from [Giorgos Dimtsas' excellent post](https://gedim21.github.io/devops/tutorial/mongodb-cluster-docker-compose/#connecting-to-the-replica-set).

To set up the cluster, you just need to run

    ./setup.sh

This command uses Docker Compose to run three MongoDB instances on the local machine and creates a replica set.

To shut it down with all volumes run:

    docker-compose down -v
