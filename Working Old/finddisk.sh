## Load in the functions and animations
#source ./bash_loading_animations/bash_loading_animations.sh
## Run BLA::stop_loading_animation if the script is interrupted
#trap BLA::stop_loading_animation SIGINT

## Declate Varaibles and Array
	## Find and store all external disks in variable/array 'extdisks'
	extdisks=($(diskutil list | grep external | awk '{ print $1}'))
	## Declare total number of external disks
	extnum="${#extdisks[@]}"
	## Declare space variable for beautification
	space='echo '''
	DISK=$1

## Padding/information for user
	echo 'Scanning for external storage devices (USB Sticks)'
	sleep 1
## Check for no external drives, exit script if none detected
	if [[ $extnum = 0 ]]; 
		then 
		echo 'No external disks have been found, please check your connections & Disk Utility then try again'
		sleep 5
		exit
		#statements
	fi

#### BS Loading Animation?
	
## Disk variable chosen by user, test if correct
while [[ ! $diskselected = 1 ]]; do

	while [[ " ${extdisks[*]} " =~ " ${DISK} " ]]; do
		sleep 1
		echo "You have chosen '$DISK'"
		diskutil info $DISK |  grep -E 'Media Name|Device Location|Protocol|Disk Size'
		read -p 'Would you like to proceed with this disk selection? (Y/N)' yn
		case $yn in
			[Nn]* ) DISK=''
					echo 'Returning to Disk Selection'
					sleep 1 ;;
			[Yy]* ) diskselected=1
					break ;;
			*) echo "invalid option $REPLY";;
		esac
		## Disk not found in array, choice to break or select disk

	done
	if [[ ! -z ${DISK} ]]; then
		#statements
		if [[ ! " ${extdisks[*]} " =~ " ${DISK} " ]]; then
			echo 'You have specified '$DISK' as your disk, however this disk has not been detected.'
			sleep 1
			echo 'Would you like to select from the detected disks?'
			echo '(Answering N/n will berak the script and allow you to retry entering a disk)'
			read -p 'Y/N: ' yn
			case $yn in
				[Nn]* ) exit;;
				[Yy]* ) 
					echo 'Proceeding to Disk Selction Menu...'
					sleep 2
					break ;;
				*) echo "invalid option $REPLY";;
			esac
		fi
	fi
	if [[ ! $diskselected = 1 ]]; then
		## Padding/Information for user
		echo "Total number of external disks found: '$extnum'"
		sleep 1
		echo 'Listing Disk Properties...'
		sleep 2

		##List detected disks, with properties
		N=0
		while [[ $N<$extnum ]];
			do
				## Title for disk
				echo "Disk '${extdisks[$N]}' Properties:"
				## Find all Properties of Disk     & List Important Properties/Identifing Features to User
				diskutil info "${extdisks[$N]}" | grep -E 'Media Name|Device Location|Protocol|Disk Size'
				let ++N;
				echo ''
			done
		## Information for user
		sleep 1
		echo 'Please use the above information to inditify the USB/external drive you would like to create the install media on'

		## User to chose disk from previous options
		select DISK in ${extdisks[@]}; do
			echo 'Disk Selected'
			sleep 1
			break
		done
		#statements
	fi
done

echo "c'est fini"
##