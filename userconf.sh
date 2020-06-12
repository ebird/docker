#!/usr/bin/with-contenv bash

# set defaults for environmental variables in case they are undefined
USER=${USER:=docker}
PASSWORD=${PASSWORD:=docker}
USERID=${USERID:=1000}
GROUPID=${GROUPID:=1000}
ROOT=${ROOT:=FALSE}
UMASK=${UMASK:=022}

# make sure r inherits the full path
echo "PATH=${PATH}" >> /usr/local/lib/R/etc/Renviron

if [ "$USER" != "rstudio" ]
  then
    cp -r /home/docker /home/$USER
    usermod -l $USER -d /home/$USER docker
    groupmod -n $USER docker
    usermod -a -G staff $USER
    chown -R $USER:$USER /home/$USER
fi

# add a password to user
# echo "$USER:$PASSWORD" | chpasswd

# add user to sudoers
if [[ ${ROOT,,} == "true" ]]
  then
    adduser $USER sudo && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
fi