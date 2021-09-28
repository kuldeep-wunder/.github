#!/bin/bash 

set -e
client=${1}
stage=${2}
project=${3}


##### These variables are for color output ("echo -e" or "printf" is required to display colored text)#########
RED='\033[0;31m'
NC='\033[0m' # No Color



multiple_client_check=`echo ${client} | grep ','| cat`

if [[ ${multiple_client_check} != "" ]]
then
	echo "multiple clients deployment ${multiple_client_check}"

	IFS=","
	for i in ${client}
	do
		
		i=$(echo ${i} | xargs)
		echo ${i}
		client_name_check=$(cat ./deployment/projects/${project}/stages/${stage}/clients.txt |grep -w "${i}"| cat)
		if [[ ${client_name_check} != "" ]] 
		then
			echo "client name matched in list"

		else
			
			echo -e "Check the name of client ${RED} \"${i}\" ${NC} and re-execute it again"
			exit 1;
		fi

	done


else
	echo "single client deployment"
	client_name_check=$(cat ./deployment/projects/${project}/stages/${stage}/clients.txt | grep -w "${client}" | cat )

	if [[ ${client_name_check} != "" ]] 
	then
		echo "client name matched in list"
	    	
	else
	    	echo "Client name ${RED} \"${client}\" ${NC} not matched in list"
	    	exit 1;
	fi
fi
