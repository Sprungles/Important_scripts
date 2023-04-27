sudo apt install nautilus python
echo 'Installing Dependencies for Android Development'
sudo apt install bc bison build-essential ccache curl flex g++-multilib gcc-multilib git git-lfs gnupg gperf imagemagick lib32ncurses5-dev lib32readline-dev lib32z1-dev libelf-dev liblz4-tool libncurses5 libncurses5-dev libsdl1.2-dev libssl-dev libxml2 libxml2-utils lzop pngcrush rsync schedtool squashfs-tools xsltproc zip zlib1g-dev python3 curl nano
echo 'Making Directories for Android Development'
mkdir -p ~/bin
mkdir -p ~/android/lineage
echo 'Installing Repo'
curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
chmod a+x ~/bin/repo
echo 'You need to configure git by putting the following:
git config --global user.email "you@example.com"
git config --global user.name "Your Name"
echo ''
echo ''
echo ''
sudo dpkg --add-architecture i386
sudo apt update
sudo apt install libc6:i386 libstdc++6:i386 
libncurses5:i386 zlib1g:i386
sudo apt install elfutils
sudo apt install libc6:i386
echo 'Close the terminal that opens when you are done with it'
gnome-terminal
sleep 5
echo 'Enabling Caching, you will need an additional 15 GB for this cache'
export USE_CCACHE=1
export CCACHE_EXEC=/usr/bin/ccache
ccache -M 50G
echo 'Enabling Compression to save space'
ccache -o compression=true
echo 'Moving to android/lineage'
cd ~/android/lineage
echo 'Initializing Lineage 20.0 Lineage OS Repository'
while true; do
    read -p "Do you need to initialize the lineage 20.0 repo?" yn
    case $yn in
        [Yy]* ) repo init -u https://github.com/LineageOS/android.git -b lineage-20.0 --git-lfs; break;;
        [Nn]* ) echo 'Moving to the syncing process' && cd ~/android/lineage;;
        * ) echo "Please answer yes or no.";;
    esac
done
while true; do
    read -p "Do you wish to sync the lineage repository? If you haven't already, you need too." yn
    case $yn in
        [Yy]* ) repo sync -c; break;;
        [Nn]* ) echo 'Syncing is finished';;
        * ) echo "Please answer yes or no.";;
    esac
done
sleep 3
mkdir ~/android/device/oneplus
mkdir ~/android/device/oneplus/dre
while true; do
    read -p "Do you wish to download the device tree?" yn
    case $yn in
        [Yy]* ) git clone https://github.com/LineageOS/android_device_oneplus_dre.git ~/android/lineage/device/oneplus/dre && mkdir ~/android/lineage/device/oneplus/dre && mv android_device_oneplus_dre ~/android/lineage/device/oneplus/ ; break;;
        [Nn]* ) cd ~/android/lineage/ ;;
        * ) echo "Please answer yes or no.";;
    esac
done
mkdir ~/android/hardware/oneplus
while true; do
   read -p "Do you wish to download the android_hardware?" yn
   case $yn in
        [Yy]* ) git clone https://github.com/LineageOS/android_hardware_oneplus.git ~/android/hardware/oneplus/ && mv android_hardware_oneplus/ ~/android/lineage/hardware/oneplus   ; break;;
	[Nn]* ) cd ~/android/lineage/;;
	* ) echo "Please yes or no.";;
   esac
done
mkdir ~/android/lineage/vendor/oneplus
mkdir ~/android/lineage/vendor/oneplus/dre
while true; do
   read -p "Do you wish to download the vendor?" yn
   case $yn in
        [Yy]* ) git clone https://github.com/TheMuppets/proprietary_vendor_oneplus_dre.git ~/android/lineage/vendor/oneplus/dre && mv proprietary_vendor_oneplus_dre ~/android/lineage/vendor/oneplus/dre ; break;;
        [Nn]* ) cd ~/android/lineage/;;
        * ) echo "Please yes or no.";;
   esac
done
mkdir ~/android/lineage/hardware/oplus
while true; do
   read -p "Do you wish to download the lineage hardware oplus repo?" yn
   case $yn in
        [Yy]* ) git clone https://github.com/LineageOS/android_hardware_oplus.git ~/android/lineage/hardware/oplus && mv android_hardware_oplus ~/android/lineage/hardware/oplus break;;
        [Nn]* ) cd ~/android/lineage/;;
        * ) echo "Please yes or no.";;
   esac
done

mkdir ~/android/lineage/kernel/oneplus/
mkdir ~/android/lineage/kernel/oneplus/sm4350
while true; do
   read -p "Do you wish to download the lineage kernel?" yn
   case $yn in
        [Yy]* ) git clone https://github.com/tangalbert919/android_kernel_oneplus_sm4350.git ~/android/lineage/kernel/oneplus/sm4350 && android_kernel_oneplus_sm4350 ~/android/lineage/kernel/oneplus/sm4350 break;;
        [Nn]* ) cd ~/android/lineage/;;
        * ) echo "Please yes or no.";;
   esac
done
echo 'Sourcing the build'
source ~/android/lineage/build/envsetup.sh
breakfast dre
croot
brunch dre
cd $OUT
nautilus -- ~/android/lineage/$OUT
echo 'Build files are in this directory'
sleep 7
exit
