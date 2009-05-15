url --url=$tree
key $getVar('key', '49af89414d147589')

#if $getVar('system_name', '') != ''
auth  --useshadow  --enablemd5
# System bootloader configuration
bootloader --location=mbr

#if $getVar('rhts_server', '') != ''
# Use text mode install
text
#end if
$getVar('mode', '')

# Firewall configuration
#if $getVar('rhts_server', '') != ''
firewall --disabled
#end if
#if $getVar('rhts_server', '') == ''
firewall --enabled --port=22:tcp
#end if

#if $getVar('rhts_server', '') != ''
# Don't Run the Setup Agent on first boot
firstboot --disable
#end if

# System keyboard
keyboard $getVar('keyboard', 'us')
# System language
lang $getVar('lang','en_US.UTF-8')
$yum_repo_stanza
reboot
#Root password
rootpw --iscrypted $getVar('password', '\$1\$mF86/UHC\$WvcIcX2t6crBz2onWxyac.')
# SELinux configuration
selinux $getVar('selinux','--enforcing')

# Configure the X Window System
#if $getVar('rhts_server', '') != ''
skipx
#end if
#if $getVar('rhts_server', '') == '' and not $getVar('arch','').startswith('s390')
xconfig --startxonboot
#end if

# System timezone
timezone  $getVar('timezone', 'America/New_York')
# Install OS instead of upgrade
install

$SNIPPET("RedHatEnterpriseLinuxServer5")
$SNIPPET("rhts_scsi_ethdevices")
$SNIPPET("rhts_partitions")

%packages --resolvedeps --ignoremissing
#if $getVar('rhts_server', '') == ''
@admin-tools
@base
@base-x
@core
@dialup
@editors
@games
@gnome-desktop
@graphical-internet
@graphics
@java
@office
@printing
@sound-and-video
@text-internet
busybox
comps-extras
cracklib-dicts
gnome-mime-data
iso-codes
kernel-headers
nash
rmt
tzdata
xkeyboard-config
#end if
$SNIPPET("rhts_packages")

#end if
%pre
$SNIPPET("RedHatEnterpriseLinuxServer5_pre")
$SNIPPET("rhts_pre")

%post
$SNIPPET("RedHatEnterpriseLinuxServer5_post")
$SNIPPET("rhts_post")