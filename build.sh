#!/bin/bash

set -euo pipefail

echo "* Fetching Qubes Builder V2"
git clone https://github.com/QubesOS/qubes-builderv2.git
cd qubes-builderv2 || exit
git submodule update --init

echo "* Fetching linux-intel-lts-kernel builder config"
curl -Lo linux-intel-lts-kernel.yml https://raw.githubusercontent.com/maxcable/qubes-linux-intel-lts-kernel/refs/heads/main/builder.yml

echo "* Fetching Qubes Builder V2 prereqs"
sudo dnf install -y $(cat dependencies-fedora.txt)
sudo usermod -aG docker $USER
sudo systemctl start docker

echo "* Building Qubes Builder V2 Container"
sg docker -c "./tools/generate-container-image.sh docker fedora-41-x86_64"

echo "* Fetching maxcable gpg key for linux-intel-lts-kernel repo validation"
mkdir -p artifacts/gpg-keys
curl -Lo artifacts/gpg-keys/95C2C5F7D95BD6106BFB67240FCB1E55C208B8B3.asc https://github.com/maxcable.gpg

echo "* Building linux-intel-lts kernel"
sg docker -c "python ./qb --builder-conf linux-intel-lts-kernel.yml -c linux-intel-lts-kernel package fetch prep build"
