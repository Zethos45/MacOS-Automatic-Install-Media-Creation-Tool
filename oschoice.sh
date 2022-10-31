## Declare Initial Variables
	
	## OS Choice, Current Version List Ventura - High Sierra, planned to add Sierra & El Capitan
		VERCHOICE=("Ventura" "Monterey" "Big Sur" "Catalina" "Mojave" "High Sierra" "Proceed" "All")
	
	## Selected Versions to Install, Unset Initally
		unset VERINSTALL

	## Total Required Size for USB Drive, Unset Initally
		unset USBSIZE
	
	## Default Installer Locations
		INSTALLERLOCATION="/Applications/Install macOS "
		VENTURAINSTALLERLOCATION="/Applications/Install macOS Ventura.app"
		MONTEREYINSTALLERLOCATION="/Applications/Install macOS Monterey.app"
		BIGSURINSTALLERLOCATION="/Applications/Install macOS Big Sur.app"
		CATALINAINSTALLERLOCATION="/Applications/Install macOS Catalina.app"
		MOJAVEINSTALLERLOCATION="/Applications/Install MacOS Mojave.app"
		HIGHSIERRAINSTALLERLOCATION="/Applications/Install macOS High Sierra.app/"
	
	## Create Install Media Command
		CREATEINSTALLMEDIA="/Contents/Resources/createinstallmedia"
	
	## Volume Names used like: (/Volume/$VAR)
		VENTURAVOL="Ventura"
		MONTEREYVOL="Monterey"
		BIGSURVOL="Big Sur"
		CATALINAVOL="Catalina"
		MOJAVEVOL="Mojave"
		HIGHSIERRAVOL="High Sierra"

	## USB Drive Formatting & Detection Variables
		## Find and store all external disks in variable/array 'extdisks'
			extdisks=($(diskutil list | grep external | awk '{ print $1}'))
		## Declare total number of external disks
			extnum="${#extdisks[@]}"
		## Deprecated
			#DISK=$1

	## To be Added, Arguments Detection for Faster Usage

## Introduction
	clear
	echo "Welcome to the Automatic MacOS Install Media Creation Tool"
	sleep 3
	echo ""
	echo "Currently supported MacOS Versions:"
	echo "High Sierra (10.13) >> Ventura (13.0)"
	sleep 3
	echo ""
	echo "This tool can be used to ceate a bootable drive with a single MacOS Version"
	echo "or for multiple MacOS versions on a single external drive"
	sleep 3
	echo ""
	echo "It is recommended to have the drive you wish to install to connected now"
	echo "If no drives are detected the script will exit"
	echo "If you have multiple external drives connected you will be asked to chose which one to use later in the script"
	sleep 3
	echo ""
	echo "You will be asked which versions of MacOS you wish to use on your external drive shortly"
	sleep 5

## Ask User which versions of MacOS they would like to install
	echo ""
	echo 'Please select which versions of MacOS you wish to add to your external drive'
	echo 'Please use "All" to Select All Options and "Proceed" once you have manually selected the Operating Systems you require'
	sleep 3
	echo 'Press the number that corrosponds to your desired choice from the following options:'
	echo ""
	select sel in "${VERCHOICE[@]}"; do
		case $sel in

			## Adding Individual Operating Systems
				"Ventura" ) VERINSTALL+=("Ventura") ;;

				"Monterey" ) VERINSTALL+=("Monterey") ;;		

				"Big Sur" ) VERINSTALL+=("Big Sur") ;;		

				"Catalina" ) VERINSTALL+=("Catalina") ;;		

				"Mojave" ) VERINSTALL+=("Mojave") ;;		

				"High Sierra" ) VERINSTALL+=("High Sierra") ;;

			## Adding All Avaliable Operating Systems
				"All" )
						unset VERINSTALL
						VERINSTALL=("Ventura" "Monterey" "Big Sur" "Catalina" "Mojave" "High Sierra") 
						echo "All Operating Systems selected"
						break ;;	
			## Proceed to Next Step, Once User has Selected All Required Operating Systems
				"Proceed" )
						echo "You have chosen the following versions to install: "${VERINSTALL[@]}""
						read -p 'Would you like to proceed with these selected operating systems? (Y/N)' yn
						case $yn in
							[Nn]* ) unset VERINSTALL
									echo 'Returning to OS Selection'
									sleep 1  ;;
							[Yy]* ) break ;;
							*) echo "invalid option $REPLY";;
						esac ;;
			## For Any Invalid replies
				*) echo "invalid option $REPLY";;
		esac             
	done
	clear
	echo "Your versions have been selected, proceeding to drive formatting & installation media creation tool..."
	sleep 5

## Once Operating Sytems Verify Installers Locations & Check the Required Size of the External Drive
	echo ""
	echo "For this tool to work, all required MacOS Installers Should be Loated in '/Applications/Install MacOS xyz.app'"
	sleep 1
	echo ""
	echo "The tool will now verify the required installers are in the correct location"
	sleep 2
	echo ""
	echo "Verifying..."
	sleep 2
	VER="Ventura"
	if [[ "${VERINSTALL[@]}" =~ "Ventura" ]]; then
		## Check MacOS Installer Location
		USBSIZE=$((USBSIZE + 14))
		while [[ ! -f "$VENTURAINSTALLERLOCATION$CREATEINSTALLMEDIA" ]]; do
			sleep 0.5
			echo "MacOS $VER Has Not Been Detected at the Set Location:"
			sleep 1
			echo "'$VENTURAINSTALLERLOCATION'"
			sleep 0.5
			read -p "Has MacOS $VER Been Downloaded?" yn
				case $yn in
					[Nn]* )
						echo "Please download MacOS $VER to the default location: /Applications/Install macOS $VER.app"
						read -p "Once MacOS $VER has been downloaded, please press enter to proceed" ;;
					[Yy]* ) 
						read -p "Would you like to specify another location for the MacOS $VER Installer?" yn
						case $yn in
							[Nn]* )
								echo "Please download or move the $VER installer to /Applictions/"
								read -p "Press enter to continue" ;;
							[Yy]* )
								read -p "Please specify the new location now (Including the name of the application, 'xyz.app'): " VENTURAINSTALLERLOCATION ;;
							*) echo "Invalid Option $REPLY" ;;
						esac ;;
					*) echo "invalid option $REPLY";;
				esac
		done
	fi
	VER="Monterey"
	if [[ "${VERINSTALL[@]}" =~ "Monterey" ]]; then
		## Check MacOS Installer Location
		USBSIZE=$((USBSIZE + 14))
		while [[ ! -f "$MONTEREYINSTALLERLOCATION$CREATEINSTALLMEDIA" ]]; do
			sleep 0.5
			echo "MacOS $VER Has Not Been Detected at the Set Location:"
			sleep 1
			echo "'$MONTEREYINSTALLERLOCATION'"
			sleep 0.5
			read -p "Has MacOS $VER Been Downloaded?" yn
				case $yn in
					[Nn]* )
						echo "Please download MacOS $VER to the default location: /Applications/Install macOS $VER.app"
						read -p "Once MacOS $VER has been downloaded, please press enter to proceed" ;;
					[Yy]* ) 
						read -p "Would you like to specify another location for the MacOS $VER Installer?" yn
						case $yn in
							[Nn]* )
								echo "Please download or move the $VER installer to /Applictions/"
								read -p "Press enter to continue" ;;
							[Yy]* )
								read -p "Please specify the new location now (Including the name of the application, 'xyz.app'): " VENTURAINSTALLERLOCATION ;;
							*) echo "Invalid Option $REPLY" ;;
						esac ;;
					*) echo "invalid option $REPLY";;
				esac
		done
	fi
	VER="Big Sur"
	if [[ "${VERINSTALL[@]}" =~ "Big Sur" ]]; then
		## Check MacOS Installer Location
		USBSIZE=$((USBSIZE + 14))
		while [[ ! -f "$BIGSURINSTALLERLOCATION$CREATEINSTALLMEDIA" ]]; do
			sleep 0.5
			echo "MacOS $VER Has Not Been Detected at the Set Location:"
			sleep 1
			echo "'$BIGSURINSTALLERLOCATION'"
			sleep 0.5
			read -p "Has MacOS $VER Been Downloaded?" yn
				case $yn in
					[Nn]* )
						echo "Please download MacOS $VER to the default location: /Applications/Install macOS $VER.app"
						read -p "Once MacOS $VER has been downloaded, please press enter to proceed" ;;
					[Yy]* ) 
						read -p "Would you like to specify another location for the MacOS $VER Installer?" yn
						case $yn in
							[Nn]* )
								echo "Please download or move the $VER installer to /Applictions/"
								read -p "Press enter to continue" ;;
							[Yy]* )
								read -p "Please specify the new location now (Including the name of the application, 'xyz.app'): " VENTURAINSTALLERLOCATION ;;
							*) echo "Invalid Option $REPLY" ;;
						esac ;;
					*) echo "invalid option $REPLY";;
				esac
		done
	fi
	VER="Catalina"
	if [[ "${VERINSTALL[@]}" =~ "Catalina" ]]; then
		USBSIZE=$((USBSIZE + 9))
		## Check MacOS Installer Location
		while [[ ! -f "$CATALINAINSTALLERLOCATION$CREATEINSTALLMEDIA" ]]; do
			sleep 0.5
			echo "MacOS $VER Has Not Been Detected at the Set Location:"
			sleep 1
			echo "'$CATALINAINSTALLERLOCATION'"
			sleep 0.5
			read -p "Has MacOS $VER Been Downloaded?" yn
				case $yn in
					[Nn]* )
						echo "Please download MacOS $VER to the default location: /Applications/Install macOS $VER.app"
						read -p "Once MacOS $VER has been downloaded, please press enter to proceed" ;;
					[Yy]* ) 
						read -p "Would you like to specify another location for the MacOS $VER Installer?" yn
						case $yn in
							[Nn]* )
								echo "Please download or move the $VER installer to /Applictions/"
								read -p "Press enter to continue" ;;
							[Yy]* )
								read -p "Please specify the new location now (Including the name of the application, 'xyz.app'): " VENTURAINSTALLERLOCATION ;;
							*) echo "Invalid Option $REPLY" ;;
						esac ;;
					*) echo "invalid option $REPLY";;
				esac
		done
	fi
	VER="Mojave"
	if [[ "${VERINSTALL[@]}" =~ "Mojave" ]]; then
		USBSIZE=$((USBSIZE + 7))
		## Check MacOS Installer Location
		while [[ ! -f "$MOJAVEINSTALLERLOCATION$CREATEINSTALLMEDIA" ]]; do
			sleep 0.5
			echo "MacOS $VER Has Not Been Detected at the Set Location:"
			sleep 1
			echo "'$MOJAVEINSTALLERLOCATION'"
			sleep 0.5
			read -p "Has MacOS $VER Been Downloaded?" yn
				case $yn in
					[Nn]* )
						echo "Please download MacOS $VER to the default location: /Applications/Install macOS $VER.app"
						read -p "Once MacOS $VER has been downloaded, please press enter to proceed" ;;
					[Yy]* ) 
						read -p "Would you like to specify another location for the MacOS $VER Installer?" yn
						case $yn in
							[Nn]* )
								echo "Please download or move the $VER installer to /Applictions/"
								read -p "Press enter to continue" ;;
							[Yy]* )
								read -p "Please specify the new location now (Including the name of the application, 'xyz.app'): " VENTURAINSTALLERLOCATION ;;
							*) echo "Invalid Option $REPLY" ;;
						esac ;;
					*) echo "invalid option $REPLY";;
				esac
		done
	fi
	VER="High Sierra"
	if [[ "${VERINSTALL[@]}" =~ "High Sierra" ]]; then
		USBSIZE=$((USBSIZE + 7))
		## Check MacOS Installer Location
		while [[ ! -f "$HIGHSIERRAINSTALLERLOCATION$CREATEINSTALLMEDIA" ]]; do
			sleep 0.5
			echo "MacOS $VER Has Not Been Detected at the Set Location:"
			sleep 1
			echo "'$HIGHSIERRAINSTALLERLOCATION'"
			sleep 0.5
			read -p "Has MacOS $VER Been Downloaded?" yn
				case $yn in
					[Nn]* )
						echo "Please download MacOS $VER to the default location: /Applications/Install macOS $VER.app"
						read -p "Once MacOS $VER has been downloaded, please press enter to proceed" ;;
					[Yy]* ) 
						read -p "Would you like to specify another location for the MacOS $VER Installer?" yn
						case $yn in
							[Nn]* )
								echo "Please download or move the $VER installer to /Applictions/"
								read -p "Press enter to continue" ;;
							[Yy]* )
								read -p "Please specify the new location now (Including the name of the application, 'xyz.app'): " VENTURAINSTALLERLOCATION ;;
							*) echo "Invalid Option $REPLY" ;;
						esac ;;
					*) echo "invalid option $REPLY";;
				esac
		done
	fi
	echo "All Required Installer Locations Verified"
	sleep 3
	clear

## Chose External Drive Location
	
	echo "For your selected versions of MacOS you will need a "$USBSIZE"GB USB Stick"
	echo 'Scanning for external storage devices (USB Sticks)'
	sleep 5
	## Check for no external drives, exit script if none detected
		if [[ $extnum = 0 ]]; 
			then 
			echo 'No external disks have been found, please check your connections & Disk Utility then try again'
			sleep 5
			exit
			#statements
		fi
		
	## Testing/Confirming Disk Selection
		while [[ ! $diskselected = 1 ]]; do
	 
			## Confirm with user that the correct disk has been selected, Skip if disk cannot be found or is not seleted, Check if selected disk is large enough
				if [[ " ${extdisks[*]} " =~ " ${DISK} " ]]; then
					## User Information to check if the disk is correct
						sleep 1
						echo "You have chosen '$DISK'"
						diskutil info $DISK |  grep -E 'Media Name|Device Location|Protocol|Disk Size'
						read -p 'Would you like to proceed with this disk selection? (Y/N)' yn
					## Y/N Confirmation
						case $yn in
							[Nn]* ) DISK=''
									echo 'Returning to Disk Selection'
									sleep 1 ;;
							[Yy]* ) diskselected=1
									break ;;
							*) echo "Invalid Option $REPLY";;
						esac
				fi

			## Check if Disk Chosen is a Real Disk
				if [[ ! -z ${DISK} ]]; then
					#statements
					if [[ ! " ${extdisks[*]} " =~ " ${DISK} " ]]; then
						echo 'You have specified '$DISK' as your disk, however this disk has not been detected.'
						sleep 1
						echo 'Would you like to select from the detected disks?'
						echo '(Answering N/n will berak the script and will need to be re-run from the very start)'
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

			## Disk Selection Menu & Showing User Disk Properties
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

				## Menu to select disk
					select DISK in ${extdisks[@]}; do
						echo 'Disk Selected'
						sleep 1
						break
					done
		done

## Format & Partition Disk
	N=0
	PARTN=2
	#exit
	while [[ ! "${#VERINSTALL[@]}" = $N ]]; do
		
		if [[ $N = 0 ]]; then
			diskutil eraseDisk JHFS+ "${VERINSTALL[0]}" $DISK
			diskutil umount force "$DISK"s"$PARTN"
			sleep 1
			diskutil splitPartition "$DISK"s"$PARTN" JHFS+ "${VERINSTALL[$N]}" 15g
		fi
		let ++N
		let ++PARTN
		if [[ ! $N = 0 ]]; then
			sleep 2
			diskutil addPartition "$DISK" JHFS+ "${VERINSTALL[$N]}" 15g
		fi
	done

## Run Installers

	## Ventura
	if [[ "${VERINSTALL[@]}" =~ "Ventura" ]]; then
		sudo "$VENTURAINSTALLERLOCATION$CREATEINSTALLMEDIA" --nointeraction --volume  /Volumes/"$VENTURAVOL"
	fi

	## Monterey
	if [[ "${VERINSTALL[@]}" =~ "Monterey" ]]; then
		sudo "$MONTEREYINSTALLERLOCATION$CREATEINSTALLMEDIA" --nointeraction --volume /Volumes/"$MONTEREYVOL"
	fi

	## Big Sur
	if [[ "${VERINSTALL[@]}" =~ "Big Sur" ]]; then
		sudo "$BIGSURINSTALLERLOCATION$CREATEINSTALLMEDIA" --nointeraction --volume /Volumes/"$BIGSURVOL"
	fi
	## Catalina
	if [[ "${VERINSTALL[@]}" =~ "Catalina" ]]; then
		sudo "$CATALINAINSTALLERLOCATION$CREATEINSTALLMEDIA" --nointeraction --volume /Volumes/"$CATALINAVOL"
	fi
	## Mojave
	if [[ "${VERINSTALL[@]}" =~ "Mojave" ]]; then
		sudo "$MOJAVEINSTALLERLOCATION$CREATEINSTALLMEDIA" --nointeraction --volume /Volumes/"$MOJAVEVOL"
	fi

	## High Sierra
	if [[ "${VERINSTALL[@]}" =~ "High Sierra" ]]; then
		sudo "$HIGHSIERRAINSTALLERLOCATION$CREATEINSTALLMEDIA" --nointeraction --volume /Volumes/"$HIGHSIERRAVOL"
	fi
echo finished