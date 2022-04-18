#!/bin/bash

# Uncomment the community [multilib] repository
sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf

# Run pacman to update
pacman -Syyu --noconfirm

# Install basic packages
pacman -S --noconfirm \
                 wget nano asp kmod libelf pahole xmlto \
                 python-sphinx python-sphinx_rtd_theme graphviz imagemagick \
                 cmake svn lzip git make patchelf zip \
                 inetutils python2 lld llvm base-devel\
                 clang bc ccache multilib-devel glibc lib32-glibc z3 \
                 sudo jdk8-openjdk bison cmake flex libelf cpio unzip dpkg \
                 ninja openssl python3 uboot-tools neofetch ncurses python-pip dtc

# Fix pod2man missing error
export PATH=/usr/bin/core_perl:$PATH

# Create a symlink for z3
ln -s /usr/lib/libz3.so /usr/lib/libz3.so.4

get() {
    if [[ "$1" =~ "atomx" ]]; then
        curl -LSs https://gitlab.com/ElectroPerf/atom-x-clang/-/archive/atom-15/atom-x-clang-atom-15.zip -o "clang".zip
    else
        curl -LSs  "https://codeload.github.com/$1/zip/$2" -o "$3".zip
    fi
    unzip "$3".zip -d. && rm "$3".zip && mv -v "${1##*/}-$2" "/usr/${3}"
    find "/usr/${3}" -exec chmod +x {} \; && rem "$3"
}

get mvaisakh/gcc-arm64 gcc-master gcc64
get mvaisakh/gcc-arm gcc-master gcc32
get atom-x-clang atom-15 clang

ln -sv /usr/clang/bin/llvm-* /usr/gcc64/bin
ln -sv /usr/clang/bin/lld /usr/gcc64/bin
ln -sv /usr/clang/bin/ld.lld /usr/gcc64/bin
