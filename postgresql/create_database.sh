#!/bin/bash
# create_database2.sh
for datname in 'webapp_dev' 'webapp_test' ; do 

	echo "Checking existance of database " ${datname} " ... "
	psql -U postgres -tc "SELECT 1 FROM pg_database WHERE datname = '${datname}'" | grep -q 1
	if [ $? -ne 0 ] ; then
		psql -U postgres -c "CREATE DATABASE ${datname}"
	else
		echo "OK"
	fi

done
