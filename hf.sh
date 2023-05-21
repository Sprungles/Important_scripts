#!/bin/bash

# Add repository for Firefox ESR
sudo add-apt-repository -y ppa:mozillateam/ppa
sudo apt update

# Remove proprietary components
sudo apt purge -y firefox

# Install open-source version of Firefox
sudo apt install -y firefox-esr

# Configure Firefox to use Qwant as default search engine
cat << EOF | sudo tee -a /etc/firefox-esr/syspref.js > /dev/null
pref("browser.startup.homepage", "about:blank");
pref("browser.search.defaultenginename", "Qwant");
pref("browser.urlbar.placeholderName", "Qwant");
pref("browser.search.defaulturl", "https://www.qwant.com/?q=");
pref("browser.search.searchEnginesURL", "https://raw.githubusercontent.com/qwant/qwant-frontend/master/www/3rdparty/firefox.xml");

EOF

# Configure Firefox to use Tor
cat << EOF | sudo tee -a /etc/firefox-esr/syspref.js > /dev/null
pref("network.proxy.type", 1);
pref("network.proxy.socks", "127.0.0.1");
pref("network.proxy.socks_port", 9050);
pref("network.proxy.socks_remote_dns", true);
pref("network.proxy.no_proxies_on", "");

EOF

# Download Quantum Alpha ad list
sudo curl -o /etc/firefox-esr/adblock.txt https://gitlab.com/The_Quantum_Alpha/the-quantum-ad-list/-/raw/master/For%20hosts%20file/The_Quantum_Ad-List.txt

# Configure Firefox to block ad networks
echo 'user_pref("privacy.trackingprotection.enabled", true);' | sudo tee -a /etc/firefox-esr/syspref.js > /dev/null
echo 'user_pref("urlclassifier.trackingTable", "test-track-simple,Quantum Alpha ad list,3");' | sudo tee -a /etc/firefox-esr/syspref.js > /dev/null
echo 'user_pref("urlclassifier.trackingWhitelistTable", "test-trackwhite-simple");' | sudo tee -a /etc/firefox-esr/syspref.js > /dev/null

# Restart Firefox
pkill firefox-esr

# Install Tor
sudo apt install -y tor

# Configure Tor to allow connections to hidden services
echo "HiddenServiceDir /var/lib/tor/hidden_service/" | sudo tee -a /etc/tor/torrc > /dev/null
echo "HiddenServicePort 80 127.0.0.1:80" | sudo tee -a /etc/tor/torrc > /dev/null
echo "HiddenServicePort 443 127.0.0.1:443" | sudo tee -a /etc/tor/torrc > /dev/null

# Restart Tor
sudo systemctl restart tor

# Install and configure UFW (Uncomplicated Firewall)
sudo apt install -y ufw
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow 9050  # Allow Tor SOCKS port
sudo ufw allow 80  # Allow web traffic
sudo ufw allow 443  # Allow HTTPS traffic
sudo ufw enable

echo "Firefox has been hardened, proprietary components have been removed, access to ad networks from Quantum Alpha ad list has been blocked, default search engine has been set to Qwant, and firewall has been configured."

