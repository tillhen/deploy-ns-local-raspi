#!/bin/bash

## from https://github.com/tillhen/deploy-ns-local-raspi/blob/master/ns-local-install.sh

## TODO: set /etc/domainname

# make me current

# parse command line options
for i in "$@"
do
case $i in
    --mongo=*)
    INSTALL_MONGO="${i#*=}"
    shift # past argument=value
    ;;
    --units=*)
    UNITS="${i#*=}"
    shift # past argument=value
    ;;
    --storage=*)
    STORAGE="${i#*=}"
    shift # past argument=value
    ;;
    --oref0=*)
    INSTALL_OREF0="${i#*=}"
    shift # past argument=value
    ;;
    *)
    # unknown option
    echo "Option ${i#*=} unknown"
    ;;
esac
done

# if ! [[ ${INSTALL_MONGO,,} =~ "yes" || ${INSTALL_MONGO,,} =~ "no"  ]]; then
#     echo ""
#    echo "Unsupported value for --mongo. Choose either 'yes' or 'no'. "
#    echo
#    INSTALL_MONGO="" # to force a Usage prompt
# fi

# if ! [[ ${UNITS,,} =~ "mmol" || ${UNITS,,} =~ "mg" ]]; then
#    echo ""
#    echo "Unsupported value for --units. Choose either 'mmol' or 'mg'"
#    echo
#    UNITS="" # to force a Usage prompt
# fi

# if ! [[ ${STORAGE,,} =~ "openaps" || ${STORAGE,,} =~ "mongo" ]]; then
#    echo ""
#    echo "Unsupported value for --storage. Choose either 'openaps' (Nightscout will use OpenAPS files) or 'mongo' (MongoDB backend store)"
#    echo
#    STORAGE="" # to force a Usage prompt
# fi


# if ! [[ ${INSTALL_OREF0,,} =~ "yes" || ${INSTALL_OREF0,,} =~ "no"  ]]; then
#    echo ""
#    echo "Unsupported value for --oref0. Choose either 'yes' or 'no'. "
#    echo
#    INSTALL_OREF0="" # to force a Usage prompt
# fi


# if [[ -z "$INSTALL_MONGO" || -z "$UNITS" || -z "$STORAGE" || -z "$INSTALL_OREF0" ]]; then
#    echo "Usage: ns-local-install.sh [--mongo=[yes|no]] [--units=[mmol|mg]] [--storage=[openaps|mongo]] [--oref0=[yes|no]]"
#    read -p "Start interactive setup? [Y]/n " -r
#    if [[ $REPLY =~ ^[Nn]$ ]]; then
#        exit
#    fi

#	while true; do
#	    read -p "Do you want to install MongoDB? [Y]/n" -r
#		case $REPLY in
#			"") INSTALL_MONGO="yes" ; break;;
#			[Yy]* ) INSTALL_MONGO="yes" ; break;;
#			[Nn]* ) INSTALL_MONGO="no" ; break;;
#			* ) echo "Please answer yes or no";;
#		esac
#	done
	
#	while true; do
#    read -p "Do you want to use mmol or mg mmol/mg]? " mmol/mg
#    case $mmol/mg in
#        mmol) UNITS="mmol"; break;;
#        mg) UNITS="mg"; break;;
#        * ) echo "Please answer mmol or mg.";;
#	esac
#	done

#	echo "Nightscout has two options for storage:"
#	echo "openaps: Nightscout will use the OpenAPS files"
#	echo "mongodb: Nightscout will use a MongoDB"
#	while true; do
#    read -p "What storage do you want to use? Choose [mongodb] / openaps " storage
#    case $storage in
#		"") STORAGE="mongo" ; break;;
#        mongodb) STORAGE="mongo"; break;;
#        openaps) STORAGE="openaps"; break;;
#        * ) echo "Please answer mongo or openaps. ";;
#	esac
#	done

#    read -p " " -r
#	=$REPLY

#	while true; do
#		read -p "Do you wish to install OpenAPS basic oref0? [Y]/n" yn
#		case $yn in
#			[Yy]* ) break;;
#			[Nn]* ) break;;
#		esac
#	done
#	INSTALL_OREF0=$yn
	
# fi



# get the right node
CPU_MODEL=$( awk '/model name/ {print $4}' < /proc/cpuinfo )
if [ "$CPU_MODEL" = "ARMv7-compatible" ]
then
  echo "ARMv6 detected"
  # install node (on ARMv6 eg. Raspberry Model A/B/B+/A+/Zero)
  curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
  sudo apt-get install -y nodejs
  # check version should be v10.19.0
  node -v
  cd ..
  # clean up
  rm node-v10.19.0-linux-armv7l.tar.xz
  rm -r node-v10.19.0-linux-armv7l
else
  echo "Assuming ARMv8 (Raspi 3))"
  # install node (on ARMv8 eg Raspberry 3 Model B)
  curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
  sudo apt-get install -y nodejs
fi

# install dependencies
sudo apt-get install -y build-essential

# get git, mongodb 2.x from apt for now,and npm


if [[ ${INSTALL_MONGO,,} =~ "yes" || ${INSTALL_MONGO,,} =~ "y"  ]]; then
	sudo apt-get install --assume-yes git mongodb-server
	# enable mongo
	sudo systemctl enable mongodb.service
	# check mongo status
	sudo systemctl status mongodb.service
	# get log of mongo
	#cat /var/log/mongodb/mongodb.log -> should contain: [initandlisten] waiting for connections on port 27017
fi

sudo npm cache clean -f
sudo npm install npm -g
sudo npm install n -g

# select matching node
sudo n 10.19.0

# go home
cd

# get start script
case $UNITS in
   mg) curl -o start_nightscout.sh https://raw.githubusercontent.com/tillhen/deploy-ns-local-raspi/master/nightscout; break;;
esac

chmod +rx start_nightscout.sh

git clone https://github.com/nightscout/cgm-remote-monitor.git

# switching to cgm-remote-monitor directory

cd cgm-remote-monitor/

# switch to dev (latest development version)
git checkout dev

# setup ns
./setup.sh


# make autoboot
cd
curl -o nightscout https://raw.githubusercontent.com/tillhen/deploy-ns-local-raspi/master/nightscout
sudo mv nightscout /etc/init.d/nightscout
sudo chmod +x /etc/init.d/nightscout
sudo /etc/init.d/nightscout start
sudo /etc/init.d/nightscout status
sudo insserv -d nightscout

sudo aptitude install nodejs-legacy

echo "deploy nightscout on raspi done :)"
echo "Dont forget to edit: /home/pi/cgm-remote-monitor/start_nightscout.sh"
echo "Nightscout logging can be found at: /var/log/openaps/nightscout.log"

case $OREF0 in
        [Yy]* ) break;;
        [Nn]* ) exit;;
esac

# Setup basis oref0 stuff
# https://openaps.readthedocs.io/en/master/docs/walkthrough/phase-2/oref0-setup.html

echo "Please continue with step 2 of http://openaps.readthedocs.io/en/2017-07-13/docs/walkthrough/phase-2/oref0-setup.html"
# echo "curl -s https://raw.githubusercontent.com/openaps/docs/master/scripts/quick-packages.sh | bash -"
# echo "mkdir -p ~/src; cd ~/src && git clone -b dev git://github.com/openaps/oref0.git || (cd oref0 && git checkout dev && git pull)"
# echo "cd ~/src/oref0 && npm run global-install"
# echo "cd && ~/src/oref0/bin/oref0-setup.sh"
# echo "cd && ~/src/oref0/bin/oref0-setup.sh
