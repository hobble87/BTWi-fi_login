#!/bin/bash

# CONFIG

Uname=""
Password=""

SCAN_FOR_BT () {
	echo "Scanning for BTWi-fi Network"
	SCAN=$(sudo iw dev wlp3s0 scan | grep -i BTWi-fi)
	if [ "$SCAN" = "SSID: BTWi-fi" ]; then
		echo "Network Found"
		TEST_CONNECTION
	else
		echo "No BT Network Found"
		echo "No Point To Continue"
		exit 0
	fi
}

TEST_CONNECTION () {
	echo "Testing Connection..."
	ping 8.8.8.8 -c 1 2>&1 >/dev/null
	if [ $? != 0 ];then
		echo "Ping Failed"
		CONNECT_TO_INTERNET
	else 
		echo "Connected"
	fi 
}

CONNECT_TO_INTERNET () {
	echo "Connecting to Network..."
	echo "sending login code"
	Login=$(wget -qO - --no-check-certificate --no-cache --post-data "username=$Uname&password=$Password&provider=tbb" "https://www.btopenzone.com:8443/tbbLogon")
	ONLINE=$(echo $Login | grep "now logged on" )
 		if [ "$ONLINE" ]; then
    			echo "You're online!"
   			exit 0
   		else
   			echo "Could not login"
   		fi
}

SCAN_FOR_BT
