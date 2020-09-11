#!/bin/bash
# https://linuxconfig.org/how-to-install-tor-browser-in-ubuntu-18-04-bionic-beaver-linux
# https://linuxize.com/post/how-to-install-tor-browser-on-ubuntu-18-04/

set -e

export DEBIAN_FRONTEND="noninteractive"

apt-get update
# apt-get install -y gnupg2 wget xz-utils
apt-get install -y file libgtk-3-0 libdbus-glib-1-2 wget xz-utils

# Download package
SHA="5d6d81db04e0a8c536c3d5e13c935c52318bac7ca44089e031c1bf7c54d66f4e"
wget https://www.torproject.org/dist/torbrowser/9.5.4/tor-browser-linux64-9.5.4_en-US.tar.xz -O /tmp/tor.tar.xz
# wget https://www.torproject.org/dist/torbrowser/9.0.4/tor-browser-linux64-9.0.4_en-US.tar.xz.asc -O /tmp/tor.asc
# gpg --keyserver pool.sks-keyservers.net --recv-keys D1483FA6C3C07136
# gpg --verify /tmp/tor.asc /tmp/tor.tar.xz

# Manual verification since key verification is borked
echo ${SHA} /tmp/tor.tar.xz | sha256sum -c

# Install package
tar xf /tmp/tor.tar.xz -C /opt
rm /tmp/tor.tar.xz
# rm /tmp/tor.tar.xz /tmp/tor.asc

# Tweak package
mv /opt/tor-browser_* /opt/tor
sed -e 's/"`id -u`" -eq 0/`false`/g' -i /opt/tor/Browser/start-tor-browser
sed -e 's/$SYSARCHITECTURE -ne $TORARCHITECTURE/"$SYSARCHITECTURE" != "$TORARCHITECTURE"/g' -i /opt/tor/Browser/start-tor-browser
