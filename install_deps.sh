#!/bin/bash

# Uncomment the community [multilib] repository
sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf

# Fix for docker's unusal locale config
sed -i s/"#en_US.UTF-8 UTF-8"/"en_US.UTF-8 UTF-8"/g /etc/locale.gen
locale-gen

# Run pacman to update
pacman -Syyu --noconfirm

# Install basic packages
pacman -S --noconfirm \
                 wget nano kmod libelf imagemagick \
                 cmake svn lzip git make patchelf zip lld llvm base-devel\
                 clang bc ccache multilib-devel glibc lib32-glibc z3 \
                 sudo jdk-openjdk bison cmake flex libelf cpio unzip dpkg \
                 openssl python3 ncurses python-pip

# Fix pod2man missing error
export PATH=/usr/bin/core_perl:$PATH

# Create a symlink for z3
ln -s /usr/lib/libz3.so /usr/lib/libz3.so.4

get() {
    if [[ "$3" == "clang" ]]; then
        curl -LSs https://gitlab.com/dakkshesh07/neutron-clang/-/archive/Neutron-16/neutron-clang-Neutron-16.zip -o "clang".zip
    else
        curl -LSs  "https://codeload.github.com/$1/zip/$2" -o "$3".zip
    fi
    unzip "$3".zip -d. && rm "$3".zip && mv -v "${1##*/}-$2" "/usr/${3}"
    find "/usr/${3}" -exec chmod +x {} \;
}

get mvaisakh/gcc-arm64 gcc-master gcc64
get mvaisakh/gcc-arm gcc-master gcc32
get dakkshesh07/neutron-clang Neutron-16 clang
