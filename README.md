# Summary

This repository provides a Docker container for building Variscite software releases. These configurations have been tested:

|Container Version   | ics Release                                                          |
|--------------------|----------------------------------------------------------------------------|
| ics common         | - common base
| vertumnus          | - for vertumnus
| karst              | - for karst

# Host Setup

From a brand new Ubuntu installation:

1. Install Docker `$ sudo apt update && sudo apt install docker.io`
2. Install Host Linux Headers (required for some Yocto versions) `$ sudo apt install linux-headers-$(uname -r)`
3. Give permissions to run docker without sudo `$ sudo usermod -aG docker ${USER}`
4. Logout and Login again for permissions to take effect
5. Clone this repository

# Usage

On Host Computer:
```
$ mkdir ~/var-fslc-yocto
$ ./run.sh -w ~/var-fslc-yocto
```
You're now running in a container with all build dependencies, and can build as normal.

Yocto Example:
```
vari@460e5ba862b1:/workdir$ repo init -u git@github.com:roger-gu-tfs/ics-bsp-platform.git -b vertumnus_0.9.0 -m default.xml
vari@460e5ba862b1:/workdir$ repo sync -j4
vari@460e5ba862b1:/workdir$ MACHINE=var-som-mx6 DISTRO=fslc-x11 . setup-environment build_x11
vari@460e5ba862b1:/workdir$ bitbake vertumnus-fsl-image
```
## Docker Privileged Mode (Debian)

When Building Debian, Docker requires access to the Host devices. To provide access, pass the -p argument to start Docker in privileged mode.

Example:
```
$ mkdir ~/var-debian
$ ./run.sh -p -w ~/var-debian
```

## Container Authentication

You may use the sudo command inside the container with these credentials:

|Username   | Password  |
|-----------|-----------|
| vari      | ubuntu
<br>

# Rebuilding Docker Image

The Docker Image will be built automatically by ./run.sh the first time. Any commits to the GIT repository will cause the image to be rebuilt with the new changes using cache (not necessarily the latest from Ubuntu)

To force the container to be rebuilt with the latest from Ubuntu, pass the `-f` argument:

```$ ./run.sh -f ...```
