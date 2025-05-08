# Qubes package for Linux kernel (intel/linux-lts) - r4.3

This can be used to build a qubes kernel off intel/linux-lts. This enables i915
SR-IOV support for some CPUs.

## How to use

The easiest way to create the rpms is to run build.sh on Fedora. If you're
familiar with using qubes-buidlerv2 and already have it setup you can copy the
builder.yml file into your qubes-buidlerv2 directory and use that to create the
kernel.

```bash
mkdir -p artifacts/gpg-keys
curl -Lo artifacts/gpg-keys/95C2C5F7D95BD6106BFB67240FCB1E55C208B8B3.asc https://github.com/maxcable.gpg
curl -Lo qubes-linux-intel-lts-kernel.yml https://raw.githubusercontent.com/maxcable/qubes-linux-kernel-intel/refs/heads/main/builder.yml
python ./qb --builder-conf qubes-linux-intel-lts-kernel.yml -c linux-kernel-intel-lts package fetch prep build
```
