<!--
 * @Author: guroger roger.gu@thermofisher.com
 * @Date: 2022-05-11 09:20:57
 * @LastEditors: guroger roger.gu@thermofisher.com
 * @LastEditTime: 2022-05-11 09:30:39
 * @FilePath: /ics-jenkins-yocto-docker/README.md
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
-->
# Summary

This repository provides a Docker container for building Variscite software releases. These configurations have been tested:

| Container Version | ics Release     |
| ----------------- | --------------- |
| ics common        | - common base   |
| vertumnus         | - for vertumnus |
| karst             | - for karst     |

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
ics@460e5ba862b1:/workdir$ repo init -u git@github.com:roger-gu-tfs/ics-bsp-platform.git -b vertumnus_0.9.0 -m default.xml
ics@460e5ba862b1:/workdir$ repo sync -j4
ics@460e5ba862b1:/workdir$ MACHINE=var-som-mx6 DISTRO=fslc-x11 . setup-environment build_jenkins
ics@460e5ba862b1:/workdir$ bitbake vertumnus-fsl-image
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

| Username | Password     |
| -------- | ------------ |
| ics      | Therm0Fisher |
<br>

# Rebuilding Docker Image

The Docker Image will be built automatically by ./run.sh the first time. Any commits to the GIT repository will cause the image to be rebuilt with the new changes using cache (not necessarily the latest from Ubuntu)

To force the container to be rebuilt with the latest from Ubuntu, pass the `-f` argument:

```$ ./run.sh -f ...```
