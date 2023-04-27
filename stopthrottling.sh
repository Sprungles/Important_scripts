
echo 'Installing the msr-tools package, which includes rdmsr and wrmsr functionality'
echo ''
echo ''
echo ''
sudo apt install msr-tools -y

echo 'Reading the 0x1FC'
echo ''
echo ''
sudo /usr/bin/rdmsr 0x1FC

echo 'I am using the 0x1FC of the MacbookPro15,1, if you decide to use this on another model, use the value that you get from the previous command in place of 6c005d'
echo ''
echo ''
echo ''
sudo /usr/bin/wrmsr 0x1FC 6c005d


echo 'Throttling has been disabled, feel free to close the window now.'
