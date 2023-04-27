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
'
echo 'Close the terminal that opens when you are done with it'
gnome-terminal
sleep 15
echo 'Enabling Caching, you will need an additional 15 GB for this cache'
export USE_CCACHE=1
export CCACHE_EXEC=/usr/bin/ccache
ccache -M 15G
echo 'Enabling Compression to save space'
ccache -o compression=true
echo 'Moving to android/lineage'
cd ~/android/lineage
echo 'Initializing Lineage 19.1 Lineage OS Repository'
while true; do
    read -p "Do you need to initialize the lineage 19.1 repo? " yn
    case $yn in
        [Yy]* ) repo init -u https://github.com/LineageOS/android.git -b lineage-19.1 --git-lfs; break;;
        [Nn]* ) echo 'Moving to the syncing process' && cd ~/android/lineage;;
        * ) echo "Please answer yes or no.";;
    esac
done
while true; do
    read -p "Do you wish to sync the lineage repository? If you haven't already, you need too. " yn
    case $yn in
        [Yy]* ) repo sync -c; break;;
        [Nn]* ) echo 'Syncing is finished';;
        * ) echo "Please answer yes or no.";;
    esac
done
sleep 3
echo 'Plug in your android device and enable USB Debugging in the Developer Settings; accept the USB debugging popup. In the same area of settings, enable root debugging'
while true; do
    read -p "Do you wish to extract your vendor from your device? " yn
    case $yn in
        [Yy]* ) ~/android/lineage/device/oneplus/dre/extract-files.sh; break;;
        [Nn]* ) cd ~/android/lineage/;;
        * ) echo "Please answer yes or no.";;
    esac
done
echo 'Sourcing the build'
source build/envsetup.sh
breakfast dre
croot
brunch dre
cd $OUT
nautilus -- ~/android/lineage/$OUT
echo 'Build files are in this directory'
sleep 10
exit
