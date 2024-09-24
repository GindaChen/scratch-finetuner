# Common script to check IP address of the current machine

# Show IP address of the current machine
ip addr show eth0 | grep "inet " | awk '{print $2}' | cut -d/ -f1

# Ping Google
ping -c 4 google.com

# Ping master node: 10.0.0.13
ping -c 4 10.0.0.13
ping -c 4 10.0.0.15

# Install infiniband stuff
# https://learn.microsoft.com/en-us/azure/virtual-machines/extensions/enable-infiniband
MLNX_OFED_DOWNLOAD_URL=http://content.mellanox.com/ofed/MLNX_OFED-5.0-2.1.8.0/MLNX_OFED_LINUX-5.0-2.1.8.0-rhel7.7-x86_64.tgz
# Optionally verify checksum
wget --retry-connrefused --tries=3 --waitretry=5 $MLNX_OFED_DOWNLOAD_URL
tar zxvf MLNX_OFED_LINUX-5.0-2.1.8.0-rhel7.7-x86_64.tgz

KERNEL=( $(rpm -q kernel | sed 's/kernel\-//g') )
KERNEL=${KERNEL[-1]}
# Uncomment the lines below if you are running this on a VM
#RELEASE=( $(cat /etc/redhat-release | awk '{print $4}') )
#yum -y install http://olcentgbl.trafficmanager.net/redhat/${RELEASE}/updates/x86_64/kernel-devel-${KERNEL}.rpm
sudo yum install -y kernel-devel-${KERNEL}
sudo ./MLNX_OFED_LINUX-5.0-2.1.8.0-rhel7.7-x86_64/mlnxofedinstall --kernel $KERNEL --kernel-sources /usr/src/kernels/${KERNEL} --add-kernel-support --skip-repo
