ARCH=`uname -m`
ARCH_SYS=`uname -s | tr "[A-Z]" "[a-z]"`
VERSION=1.5.1pre3069_8057a19
NAME=nix-${VERSION}-${ARCH}-${ARCH_SYS}

if [ "$ARCH" = "i686" -a "$ARCH_SYS" = "freebsd" ]
then
    DOWNLOAD_URL=http://hydra.nixos.org/build/4256488/download/1/${NAME}.tar.bz2
elif [ "$ARCH" = "i686" -a "$ARCH_SYS" = "linux" ]
then
    DOWNLOAD_URL=http://hydra.nixos.org/build/4256480/download/1/${NAME}.tar.bz2
elif [ "$ARCH" = "i686" -a "$ARCH_SYS" = "linux" ]
then
    DOWNLOAD_URL=
elif [ "$ARCH" = "x86_64" -a "$ARCH_SYS" = "darwin" ]
then
    DOWNLOAD_URL=http://hydra.nixos.org/build/4256485/download/1/${NAME}.tar.bz2
elif [ "$ARCH" = "x86_64" -a "$ARCH_SYS" = "freebsd" ]
then
    DOWNLOAD_URL=http://hydra.nixos.org/build/4256487/download/1/${NAME}.tar.bz2
elif [ "$ARCH" = "x86_64" -a "$ARCH_SYS" = "linux" ]
then
    DOWNLOAD_URL=http://hydra.nixos.org/build/4256479/download/1/${NAME}.tar.bz2
else
    echo "Platform detected: ${ARCH_SYS} ${ARCH}"
    echo "Platform not supported!"
    exit 1
fi

echo "Platform detected: ${ARCH_SYS} ${ARCH}"
echo "Downloading Nix for your platform..."
WORK_DIR=`pwd`
curl -O $DOWNLOAD_URL
#echo "There are XXX steps to install Nix, you will be prompt for each step to confirm it"
#echo "[1/XXX] sudo tar xfj -C / $WORK_DIR/${NAME}.tar.bz2"
#read confirm
sudo tar xfj -C / $WORK_DIR/${NAME}.tar.bz2
sudo chown -R $USER /nix
/usr/bin/nix-finish-install
sudo rm /usr/bin/nix-finish-install
echo "source $HOME/.nix-profile/etc/profile.d/nix.sh" >> ~/.profile
source $HOME/.nix-profile/etc/profile.d/nix.sh
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
