#version=DEVEL
# System authorization information
auth --enableshadow --passalgo=sha512
# Use CDROM installation media
# url --url="ftp://192.168.10.10/pub/rhel7" <- needs to be updated
# Use graphical install
graphical
# Run the Setup Agent on first boot
firstboot --enable
ignoredisk --only-use=vda
# Keyboard layouts
keyboard --vckeymap=us --xlayouts='us'
# System language
lang en_US.UTF-8

# Network information
network  --bootproto=static --device=eth0 --gateway=192.168.50.1 --ip=192.168.50.10 --nameserver=192.168.50.10,1.1.1.1 --netmask=255.255.255.0 --ipv6=auto --activate

# Root password
rootpw --iscrypted $1$lxXtLWD5$rZbWHoh62Tvwe/QteB1O60
# System services
services --disabled="chronyd"
# System timezone
timezone Europe/Berlin --isUtc --nontp
# System bootloader configuration
bootloader --append=" crashkernel=auto" --location=mbr --boot-drive=vda
# Partition clearing information
clearpart --none --initlabel
# Disk partitioning information
part /boot --fstype="xfs" --ondisk=vda --size=1024
part pv.156 --fstype="lvmpv" --ondisk=vda --size=50175
volgroup centos --pesize=4096 pv.156
logvol swap  --fstype="swap" --size=5119 --name=swap --vgname=centos
logvol /var  --fstype="xfs" --size=24572 --name=var --vgname=centos
logvol /  --fstype="xfs" --size=20480 --name=root --vgname=centos

# Reboot after installation
reboot

%packages
@core
kexec-tools

%end

%addon com_redhat_kdump --enable --reserve-mb='auto'

%end