#!/bin/bash
###Description:To copy /opt/lampp/htdocs/domains in tar file to s3 on every day at ### 
###Author: PAVAN PRASAD###

echo "\n--------------------------------------------------------"
echo "Starting PID =>  $$"
echo "Backup started at $(date +%F_%H:%M:%S)"

cd /opt/lampp/htdocs/domains/
tar -zcvf /backup/s3filecopy/file_`date +%Y-%d-%m_%H-%M-%S`.tar.gz  backend
if [ $? -eq 0 ]; then
cd /backup/s3filecopy/


/usr/bin/aws s3 cp * s3://s3-files/
fi

if [ $? -eq 0 ];then
echo "Storage folder backup copied to S3 successfully" | mailx -s "Success-Back-alert FILE back to s3 -172.16.27.9" -a "From: user@mail" user@mail

else
echo "Storage folder backup copied to S3 failed" | mailx -s "Failure-Back-alert FILE back to s3 -172.16.27.9" -a "From: user@mail" user@mail

fi

/bin/rm -f /backup/s3filecopy/*
