#!/bin/bash

sudo docker run -it --rm \
  -w "$HOME" \
  -v "$HOME/.userspace":/userspace \
  -v $PWD:/cwd \
  -v $HOME/.config:/config:rw \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -u `id -u` \
  --network host \
  ghcr.io/0xB0000xDEAD/userspace:main "$@"