#!/usr/bin/env bash
echo -n '
Please enter required version number.
WARNING: There is no imput validation.
'
read -p 'Required version: ' ver

echo "Selected version is $ver."

echo -n '
Please enter required packege type.
1. RPM for CentOS
2. DEB for AstraOS
'
read -p 'Required packets: '
case $REPLY in
	1) pack="rpm"
	;;
	2) pack="deb"
	;;
	*) echo 'Invalid entry' >&2
	exit 1
	;;
esac

echo "Selected packtet type is $pack."

url1="https://domain/$ver/1_packet.$pack"
url2="https://domain/$ver/2_packet.$pack"
url3="https://domain/$ver/3_packet.$pack"

urls_selected=()

echo -n '
Please select components you want to download:
0. Everything
1. Component1
2. Component2
3. Component3
Any other input to complite selection.
'

while true; do
	read -p "Enter selection: "
	case $REPLY in
		0) urls_selected=("$url1", "$url2", "$url3")
		echo 'Everything selected.'
		printf '%s\n' "${urls_selected[@]}"
		break
		;;
		1) if [[ " ${urls_selected[@]} " =~ " ${url1} " ]]; then
		   	echo 'Already sellected.'
		   else
			   urls_selected+=("$url1")
			   echo 'Component1 selected'
		   fi
		;;
		2) if [[ " ${urls_selected[@]} " =~ " ${url2} " ]]; then
			echo 'Already selleced.'
		   else
			urls_selected+=("$url2")
			echo 'Component2 selected'
		   fi
		;;
		3) if [[ " ${urls_selected[@]} " =~ " ${url3} " ]]; then
		   	echo 'Already sellected.'
		   else
			urls_selected+=("$url3")
			echo 'Component3 selected'
		   fi
		;;
		*) if [ ${#urls_selected[@]} -ne 0 ]; then
		   	echo 'Selection done.'
		   	echo 'Selected companent URLs:'
		   	printf '%s\n' "${urls_selected[@]}"
		   	break
		   else
			echo 'Nothing selected.'
			exit 0
		   fi
		;;
	esac
done	

for i in "${urls_selected[0]}"; do
	echo "Starting download: $i"
	wget --no-check-certificate $i
done
