echo 'Welcome to the Ubuntu Upgrade Script, a script to upgrade everything on Ubuntu; including the overall user experience'
echo 'If you have any kind of questions, please feel free to open an issue on GitHub'
echo ''
echo ''
echo ''
echo ''
echo ''
echo 'Downloading Nala'
mkdir nala/
cd nala/
wget https://gitlab.com/volian/volian-archive/uploads/b20bd8237a9b20f5a82f461ed0704ad4/volian-archive-keyring_0.1.0_all.deb
wget https://gitlab.com/volian/volian-archive/uploads/d6b3a118de5384a0be2462905f7e4301/volian-archive-nala_0.1.0_all.deb
sudo apt install ./volian-archive*.deb -y
cd ~/Downloads/
rm -rf nala/
sudo apt update
sudo apt install nala gnome-tweaks
sudo nala update
echo 'We are installing the various file formats'
sudo nala install flatpak && sudo nala install snapd 
echo ''
echo '' 
echo ''
echo 'Removing Firefox Snap Package'
echo ''
echo ''
snap remove firefox
echo 'Installing the Firefox PPA for .deb support'
echo ''
echo ''
sudo add-apt-repository ppa:mozillateam/ppa
echo "Updating package repositories so we can find the Firefox .deb"
echo ''
echo ''
sudo nala update
echo 'Installing Firefox ESR'
echo ''
echo ''
echo 'Installing ZAP, the Appimage Package Manager'
# Installing dependencies for ZAP
sudo apt install curl grep jq wget
#Actually installing ZAP
sudo curl https://raw.githubusercontent.com/srevinsaju/zap/main/install.sh | sudo bash -s
echo ''
echo ''
echo ''
sudo nala install firefox-esr
echo 'Installing AppImageLauncher for AppImage Installing'
echo ''
echo ''
mkdir appimagelauncher
cd appimagelauncher
echo 'Downloading AppImageLauncher'
echo ''
echo ''
wget https://github.com/TheAssassin/AppImageLauncher/releases/download/v2.2.0/appimagelauncher_2.2.0-travis995.0f91801.bionic_amd64.deb
echo 'Installing AppImageLauncher'
echo ''
echo ''
sudo apt install ./appimagelauncher_2.2.0-travis995.0f91801.bionic_amd64.deb -y
cd ..
rm -rf appimagelauncher
echo ''
echo ''
echo ''
echo 'Installing a GUI Kernel Manager'
mkdir kernel-manager/
cd kernel-manager/
echo 'Downloading Kernel Manager'
wget https://github.com/bkw777/mainline/releases/download/v1.2.4/mainline_1.2.4.0001_amd64.deb
echo 'Installing Kernel Manager'
sudo apt install ./mainline_1.2.4.0001_amd64.deb -y
cd ..
rm -rf kernel-manager/
echo 'Now all you need to do is right click on an Appimage and open it with AppImageLauncher to install Appimages.'
echo ''
echo ''
echo ''
echo 'Downloading Webapp Manager'
echo ''
echo ''
mkdir webapp-manager
cd webapp-manager
wget http://packages.linuxmint.com/pool/main/w/webapp-manager/webapp-manager_1.2.8_all.deb
echo 'Installing Webapp Manager'
sudo apt inistall ./webapp-manager_1.2.8_all.deb
cd ..
rm -rf webapp-manager
echo ''
echo ''
echo ''
echo 'We are asking for permission to update your system. If you do not want to update, simply close this window'
echo ''
echo ''
echo ''
echo 'Installing GIT'
sudo nala install git
echo 'Downloading sources lists with git'
mkdir sources_list/
cd sources_list/
git clone https://github.com/Sprungles/Repository_Source_List.git
cd Repository_Source_list/
echo 'Copying sources list to system directory'
sudo cp -r * /etc/apt/sources.list.d/
rm -rf sources_list/]
echo ''
echo ''
echo ''
echo 'Installing the AUR for Ubuntu, known as Pacstall'
sudo bash -c "$(curl -fsSL https://git.io/JsADh || wget -q https://git.io/JsADh -O -)"
echo 'Use this as you would the AUR; with caution.'
echo 'Updating Repositories'
sudo nala update
echo '' 
echo ''
echo ''
echo 'Installing the Chromium Web Browser'
sudo nala install chromium
echo ''
echo ''
echo ''
echo 'Doing a last and final update check'
gnome-terminal -- sudo nala update -y && sudo nala upgrade -y && sudo apt update -y && sudo apt upgrade -y && sudo flatpak upgrade && snap refresh && update_t2_kernel
echo ''
echo ''
echo ''
echo 'System has been updated. Please close this terminal window.'

