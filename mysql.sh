#!/bin/bash

source ./common.sh

check_root()

echo "please enter DB password:"
read -s mysql_root_password

dnf install mysql-server -y &>>$LOGFILE
VALIDATE $? "installing MYSQL server"

systemctl enable mysqld &>>$LOGFILE
VALIDATE $? "enabling MYSQL server"

systemctl start mysqld &>>$LOGFILE
VALIDATE $? "sarting MYSQL server"

#mysql_secure_installation --set-root-pass ExpenseApp@1 &>>$LOGFILE
#VALIDATE $? "setting uo root password"  

mysql -h db.mydaws.online -uroot -p${mysql_root_password} -e 'show databases;' &>>$LOGFILE
if [ $? -ne 0 ]
then
    mysql_secure_installation --set-root-pass ${mysql_root_password} &>>$LOGFILE
    VALIDATE $? "mysql root password setup"
else
    echo -e "mysql root password is already setup..$Y SKIPPING $N"
fi  