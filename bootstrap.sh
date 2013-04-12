ARCH=`uname -m`
ARCH_SYS=`uname -s`
VERSION=1.5.1pre3069_8057a19
NAME=nix-${VERSION}-${ARCH}-${ARCH_SYS,,}

if [ x$ARCH = "i686" -a x$ARCH_SYS = "FreeBSD" ]
then
    DOWNLOAD_URL=http://hydra.nixos.org/build/4256488/download/1/${NAME}.tar.bz2
elif [ x$ARCH = "i686" -a x$ARCH_SYS = "Linux" ]
then
    DOWNLOAD_URL=http://hydra.nixos.org/build/4256480/download/1/${NAME}.tar.bz2
elif [ x$ARCH = "i686" -a x$ARCH_SYS = "Linux" ]
then
    DOWNLOAD_URL=
elif [ x$ARCH = "x86_64" -a x$ARCH_SYS = "Darwin" ]
then
    DOWNLOAD_URL=http://hydra.nixos.org/build/4256485/download/1/${NAME}.tar.bz2
elif [ x$ARCH = "x86_64" -a x$ARCH_SYS = "FreeBSD" ]
then
    DOWNLOAD_URL=http://hydra.nixos.org/build/4256487/download/1/${NAME}.tar.bz2
elif [ x$ARCH = "x86_64" -a x$ARCH_SYS = "Linux" ]
then
    DOWNLOAD_URL=http://hydra.nixos.org/build/4256479/download/1/${NAME}.tar.bz2
else
    echo "Platform detected: ${ARCH_SYS} ${ARCH}"
    echo "Platform not supported!"
    exit 1
fi

echo "SUCCESS"
echo $DOWNLOAD_URL
WORK_DIR=`pwd`
curl -O $DOWNLOAD_URL
cd /
sudo tar xfj $WORK_DIR/${NAME}.tar.bz2
sudo chown -R $USER /nix
/usr/bin/nix-finish-install
sudo rm /usr/bin/nix-finish-install
echo "source /Users/$USER/.nix-profile/etc/profile.d/nix.sh" >> ~/.profile
source /Users/$USER/.nix-profile/etc/profile.d/nix.sh
cd $WORK_DIR
nix-channel --add http://nixos.org/channels/nixpkgs-unstable
nix-channel --update

## TODO: check if make is availiable
#nix-env -iA nixpkgs.gnumake
#echo "export LANG=\"en_US.UTF-8\"" >> ~/.profile
#echo "export LC_COLLATE=\"en_US.UTF-8\"" >> ~/.profile
#echo "export LC_CTYPE=\"en_US.UTF-8\"" >> ~/.profile
#echo "export LC_MESSAGES=\"en_US.UTF-8\"" >> ~/.profile
#echo "export LC_MONETARY=\"en_US.UTF-8\"" >> ~/.profile
#echo "export LC_NUMERIC=\"en_US.UTF-8\"" >> ~/.profile
#echo "export LC_TIME=\"en_US.UTF-8\"" >> ~/.profile
#echo "export LC_ALL=\"en_US.UTF-8\"" >> ~/.profile
