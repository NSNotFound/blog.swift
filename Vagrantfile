# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/vivid64"
  config.vm.network "forwarded_port", guest: 4000, host: 4000
  config.vm.network "private_network", ip: "192.168.33.10"
  config.vm.synced_folder "./", "/code"
  config.vm.provider "virtualbox" do |vb|
    vb.gui = false
    vb.memory = "1024"
    vb.cpus = 4
  end

  # See https://github.com/swiftdocker/docker-swift/blob/master/Dockerfile
  config.vm.provision "shell", inline: <<-SHELL
    sudo apt-get update
    sudo locale-gen en_US.UTF-8
    sudo apt-get install -y \
      build-essential wget clang libedit-dev python2.7 python2.7-dev \
      libicu52 rsync libxml2 git
    apt-get clean
    rm -rf /var/lib/apt/list* /tmp/* /var/tmp/*

    wget -q -O - https://swift.org/keys/all-keys.asc | gpg --import - && \
    gpg --keyserver hkp://pool.sks-keyservers.net --refresh-keys Swift

    export SWIFT_VERSION=2.2-SNAPSHOT-2016-01-06-a
    export SWIFT_PLATFORM=ubuntu15.10
    export SWIFT_ARCHIVE_NAME=swift-$SWIFT_VERSION-$SWIFT_PLATFORM && \
    export SWIFT_URL=https://swift.org/builds/$(echo "$SWIFT_PLATFORM" | tr -d .)/swift-$SWIFT_VERSION/$SWIFT_ARCHIVE_NAME.tar.gz && \
    wget -q $SWIFT_URL && \
    wget -q $SWIFT_URL.sig && \
    gpg --verify $SWIFT_ARCHIVE_NAME.tar.gz.sig && \
    tar -xvzf $SWIFT_ARCHIVE_NAME.tar.gz --directory / --strip-components=1 && \
    rm -rf $SWIFT_ARCHIVE_NAME* /tmp/* /var/tmp/*
    cd /code/
    make
  SHELL
end
