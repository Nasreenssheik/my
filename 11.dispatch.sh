color="\e[32m"
noclor="\e[0m"
logfile="/tmp/roboshop.log"
app_path="/app"

echo -e "$color Installing golang server$nocolor"
yum install golang -y &>>${logfile}
echo -e "$color Adding user and location$nocolor"
useradd roboshop &>>${logfile}
mkdir ${app_path} &>>${logfile}
cd ${app_path}
echo -e "$color Downloading new app content,dependencies and building software to dispatch server$nocolor"
curl -O https://roboshop-artifacts.s3.amazonaws.com/dispatch.zip &>>${logfile}
unzip dispatch.zip &>>${logfile}
go mod init dispatch &>>${logfile}
go get &>>${logfile}
go build &>>${logfile}
echo -e "$color creating dispatch service file$nocolor"
cp /root/practice-shell/dispatch.service /etc/systemd/system/dispatch.service
echo -e "$color Enabling and starting the dispatch service$nocolor"
systemctl daemon-reload
systemctl enable dispatch &>>${logfile}
systemctl restart dispatch

