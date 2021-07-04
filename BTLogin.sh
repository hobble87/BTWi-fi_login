#!/bin/bash

# CONFIG

Uname=""
Password=""

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


TEST_CONNECTION
