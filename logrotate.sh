#!/bin/bash
echo "It's a simple log rotate script"
######################################################
# HOW TO --->
### 1.Specify log directory in DIRECTORIES variables
### 2.Do you want to compress (gzip) log files? Set compress=1
### 3.How many days you want to keep log files? Set retain=30 (It will keep 30 days)
######################################################
#### VARIABLES #####
DIRECTORIES="/var/log/nginx
/var/log/apache2"
compress="1"
retain="60"
####################

for dir in $DIRECTORIES
do
	files=`find $dir -maxdepth 1 -type f| grep -Ev "/\.|.gz"`
	for file in $files
	do
	        if [[ "compress" = "1" ]]; then
		 	mv $file $file.`date +%Y-%m-%d`.log
			gzip -9 $file.`date +%Y-%m-%d`.log
		else
			mv $file $file.`date +%Y-%m-%d`.log
		fi	
	done


	find $dir -maxdepth 1 -type f -name "*.log.gz" -mtime +$retain -exec rm -rf {} +
done

