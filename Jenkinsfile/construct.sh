#!/bin/bash -x
#branch_name=feature/VER-1760-148-machine-establish-jenkins-for
#mpu_version=0.6.1
#build_directory=build_jenkins
#project=vertumnus

branch_name=$1
mpu_version=$2
build_directory=$3
project=$4
currentpath=`pwd`

echo "current path is $currentpath"
echo "current branch_name is $branch_name"

#switch local branch
#cd $currentpath/var-fslc-yocto/sources/meta-ics; 
#discard revied before
cd /home/thermo/WorkDir/VerProj/yocto_build/
#git checkout .; 
#git stash save temp
#git checkout -b $branch_name origin/$branch_name;


#TODO: ssh yocto docker
#update bb file
echo "upgrade bb file"
cd sources/meta-ics/meta-$project/recipes-app
find . -name "*.bb" | xargs sed -i 's%SRCBRANCH =.*%SRCBRANCH = \"'$branch_name'\"%g'

# set bitbake environment
echo "set bitbake environment"
cd /home/thermo/WorkDir/VerProj/yocto_build/

MACHINE=var-som-mx6 DISTRO=fslc-x11 . setup-environment $build_directory;

# build image, clean first to make sure it's the latest
echo "build image"
bitbake -c cleansstate vertumnus-ui bootui vertumnus-service \
instrument-server fsl-rc-local vertumnus-specific vertumnus-daemon swupdate \
vertumnus-fsl-image && V=$mpu_version bitbake vertumnus-fsl-image && \
V=$mpu_version bitbake vertumnus-fsl-image-swupdate && V=$mpu_version bitbake vertumnus-fsl-image-swu;

# V=$mpu_version bitbake vertumnus-fsl-image-swu;

