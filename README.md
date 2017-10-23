
# dokku vernemq (beta) 

[![Build Status](https://travis-ci.org/SpinifexGroup/dokku-vernemq.svg?branch=master)](https://travis-ci.org/SpinifexGroup/dokku-vernemq)
[![FOSSA Status](https://app.fossa.io/api/projects/git%2Bgithub.com%2FSpinifexGroup%2Fdokku-vernemq.svg?type=shield)](https://app.fossa.io/projects/git%2Bgithub.com%2FSpinifexGroup%2Fdokku-vernemq?ref=badge_shield)

Unofficial [VerneMQ MQTT Broker](https://vernemq.com/) plugin for [Dokku](http://dokku.viewdocs.io/dokku/). Uses latest version of the official [VerneMQ Docker Image](https://hub.docker.com/r/erlio/docker-vernemq/).

## requirements

- dokku 0.4.x+
- docker 1.8.x

## installation

```shell
# on 0.4.x+
sudo dokku plugin:install https://github.com/SpinifexGroup/dokku-vernemq
```

## commands
```
vernemq:add-user <service> [--create-flags...]      | Create a Vernemq user
vernemq:create <service> [--create-flags...]        | create a Vernemq service
vernemq:destroy <service> [-f|--force]              | delete the Vernemq service/data/container if there are no links left
vernemq:enter <service>                             | enter or run a command in a running Vernemq service container
vernemq:expose <service> <ports...>                 | expose a Vernemq service on custom port if provided (random port otherwise)
vernemq:link <service> <app>                        | link the Vernemq service to the app
vernemq:list                                        | list all Vernemq services
vernemq:logs <service> [-t|--tail]                  | print the most recent log(s) for this service
vernemq:remove-user <service> [--create-flags...]   | Remove a Vernemq user
vernemq:restart <service>                           | graceful shutdown and restart of the Vernemq service container
vernemq:start <service>                             | start a previously stopped Vernemq service
vernemq:stop <service>                              | stop a running Vernemq service
vernemq:unexpose <service>                          | unexpose a previously exposed Vernemq service
vernemq:unlink <service> <app>                      | unlink the Vernemq service from the app
```

## usage

```shell
# create a VerneMQ Broker service named lollipop
dokku vernemq:create lollipop

# you can also specify custom environment
# variables to start the VerneMQ service
# in semi-colon separated form
export VERNEMQ_CUSTOM_ENV="USER=alpha;HOST=beta"
dokku vernemq:create lollipop

# get information about the container as follows
dokku vernemq:info lollipop

# you can also retrieve a specific piece of service info via flags
dokku verne:info lollipop --data-dir
dokku vernemq:info lollipop --exposed-ports
dokku vernemq:info lollipop --id
dokku vernemq:info lollipop --internal-ip
dokku vernemq:info lollipop --links
dokku vernemq:info lollipop --service-root
dokku vernemq:info lollipop --status
dokku vernemq:info lollipop --version

# a bash prompt can be opened against a running service
# filesystem changes will not be saved to disk
dokku vernemq:enter lollipop

# you may also run a command directly against the service
# filesystem changes will not be saved to disk
dokku vernemq:enter lollipop ls -lah /

# a vernemq service can be linked to a
# container this will use native docker
# links via the docker-options plugin
# here we link it to our 'playground' app
# NOTE: this will restart your app
dokku vernemq:link lollipop playground

# the following environment variables will be set inside the app container
#
#   VERNEMQ_HOST=vernemq-host-name
#   VERNEMQ_PORT=1883
#   VERNEMQ_USER=username
#   VERNEMQ_PASSWORD=password
#   VERNEMQ_URL=tcp://username:password@vernemq-host-name:1883
#
# NOTE: The VerneMQ docker image enables password authentication by default.
# Your application will need to use the provided username and password to
# connect to the broker. If you wish to allow anonymous connections (please don't
# do this in production), this can be
# set as an environment variable when creating the service as described at
# https://github.com/erlio/docker-vernemq#start-a-vernemq-cluster-node
#
# NOTE: the host exposed here only works internally in docker containers. If
# you want your container to be reachable from outside, you should use `expose`.

# you can also unlink a vernemq service
# NOTE: this will restart your app and unset related environment variables
dokku vernemq:unlink lollipop playground

# you can tail logs for a particular service
dokku vernemq:logs lollipop
dokku vernemq:logs lollipop -t # to tail

# finally, you can destroy the container
dokku vernemq:destroy lollipop
```

## configuration

The VerneMQ docker image allows for configuration of all variables [using environment variables during creation](https://github.com/erlio/docker-vernemq#vernemq-configuration)

Alternatively, you can manually edit the config file on the host machine and restart the service. You
can find the appropriate directory using the `info` command.

```shell
dokku vernemq:info lollipop
```

## users

The VerneMQ docker image enables authentication by default. As such, when a VerneMQ dokku service is created,
a random username and password will be created and exported into the linked service as environment
variables. If you wish to add additional users, this can be managed through the `add-user` and `remove-user` commands.

*NOTE* that removing a user will not immediately break connections from this user. The service will need to
be restarted to break the connection, at which point the credentials will no longer be valid.


## License
[![FOSSA Status](https://app.fossa.io/api/projects/git%2Bgithub.com%2FSpinifexGroup%2Fdokku-vernemq.svg?type=large)](https://app.fossa.io/projects/git%2Bgithub.com%2FSpinifexGroup%2Fdokku-vernemq?ref=badge_large)

