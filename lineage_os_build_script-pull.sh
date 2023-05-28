echo "################################################################################################"
echo "####				Downloading Nala					  ####"
echo "################################################################################################"
mkdir nala/
cd nala/
wget https://gitlab.com/volian/volian-archive/uploads/b20bd8237a9b20f5a82f461ed0704ad4/volian-archive-keyring_0.1.0_all.deb
wget https://gitlab.com/volian/volian-archive/uploads/d6b3a118de5384a0be2462905f7e4301/volian-archive-nala_0.1.0_all.deb
sudo apt install ./volian-archive*.deb -y
sudo apt install nala
cd ~/Downloads/
rm -rf nala/
sudo apt install nautilus python
sudo nala update
echo "################################################################################################"
echo "####                             Installing Android Development Libraries                   ####"
echo "################################################################################################"
sudo nala update
sudo dpkg --add-architecture i386
sudo nala install libc:i386 libstdc++6:i386 libncurses5:i386 zlib1g:i386 elfutils libc6:i386 python-is-python3 bc bison build-essential ccache curl flex g++-multilib gcc-multilib git git-lfs gnupg gperf imagemagick lib32ncurses5-dev lib32readline-dev lib32z1-dev libelf-dev liblz4-tool libncurses5 libncurses5-dev libsdl1.2-dev libssl-dev libxml2 libxml2-utils lzop pngcrush rsync schedtool squashfs-tools xsltproc zip zlib1g-dev python3 curl nano
mkdir -p ~/bin
mkdir -p ~/android/lineage
echo 'Installing Repo'
curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
chmod a+x ~/bin/repo
echo "################################################################################################"
echo "####                             Prompting for Github Configuration                         ####"
echo "################################################################################################"
git config --global user.email "you@example.com"
git config --global user.name "Your Name"
echo ''
echo ''
echo ''
sleep 5
echo "################################################################################################"
echo "####                        Configuring Caching and Compression to improve building         ####"
echo "################################################################################################"
export USE_CCACHE=1
export CCACHE_EXEC=/usr/bin/ccache
ccache -M 50G
ccache -o compression=true
echo "################################################################################################"
echo "####                        Initializing and Syncing Lineage OS Source Code                 ####"
echo "################################################################################################"
cd ~/android/lineage
repo init -u https://github.com/LineageOS/android.git -b lineage-20.0 --git-lfs
repo sync -c  -j$
mkdir ~/android/device/oneplus
mkdir ~/android/device/oneplus/dre
mkdir ~/android/hardware/oneplus
mkdir ~/android/lineage/vendor/oneplus/
mkdir ~/android/lineage/vendor/oneplus/dre
mkdir ~/android/lineage/hardware/oplus
mkdir ~/android/lineage/kernel/oneplus
mkdir ~/android/lineage/kernel/oneplus/sm4350
git clone https://github.com/LineageOS/android_device_oneplus_dre.git ~/android/lineage/device/oneplus/dre
git clone https://github.com/TheMuppetts/proprietary_vendor_oneplus_dre.git ~/android/lineage/vendor/oneplus/dre
git clone https://github.com/LineageOS/android_hardware_oplus.git ~/android/lineage/hardware/oplus
git clone https://github.com/tangalbert919/android_kernel_oneplus_sm4350.git ~/android/lineage/kernel/oneplus/sm4350
echo "################################################################################################"
echo "####                        Building for OnePlus Dre			                  ####"
echo "################################################################################################"
cd ~/android/lineage
echo "################################################################################################"
echo "      Please make sure to run the following commands in the terminal at /android/lineage/   ####"
echo "################################################################################################"
echo "Please run the following commands in the terminal at /android/lineage/"
echo ". build/envsetup.sh"
echo "breakfast dre"
echo "croot"
echo "brunch dre"
cd $OUT
echo "################################################################################################"
echo "####                        Check inside of the directory that pops up for zip              ####"
echo "################################################################################################"
nautilus -- ~/android/lineage/$OUT
sleep 5
exit
