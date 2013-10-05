ARCH=`uname -m`
ARCH_SYS=`uname -s | tr "[A-Z]" "[a-z]"`
VERSION=1.6
NAME=nix-${VERSION}-${ARCH}-${ARCH_SYS}

if [ "$ARCH" = "i686" -a "$ARCH_SYS" = "freebsd" ]
then
    DOWNLOAD_URL=http://hydra.nixos.org/build/6039367/download/1/nix-1.6-i686-freebsd.tar.bz2
elif [ "$ARCH" = "i686" -a "$ARCH_SYS" = "linux" ]
then
    DOWNLOAD_URL=http://hydra.nixos.org/build/6039372/download/1/nix-1.6-i686-linux.tar.bz2
elif [ "$ARCH" = "x86_64" -a "$ARCH_SYS" = "darwin" ]
then
    DOWNLOAD_URL=http://hydra.nixos.org/build/6039370/download/1/nix-1.6-x86_64-darwin.tar.bz2
elif [ "$ARCH" = "x86_64" -a "$ARCH_SYS" = "freebsd" ]
then
    DOWNLOAD_URL=http://hydra.nixos.org/build/6039364/download/1/nix-1.6-x86_64-freebsd.tar.bz2
elif [ "$ARCH" = "x86_64" -a "$ARCH_SYS" = "linux" ]
then
    DOWNLOAD_URL=http://hydra.nixos.org/build/6039398/download/1/nix-1.6-x86_64-linux.tar.bz2
else
    echo "Platform detected: ${ARCH_SYS} ${ARCH}"
    echo "Platform not supported!"
    exit 1
fi

echo "Platform detected: ${ARCH_SYS} ${ARCH}"
echo "Downloading Nix for your platform..."
WORK_DIR=`pwd`
if [ ! -f $WORK_DIR/${NAME}.tar.bz2]; then                                       
    curl -O $DOWNLOAD_URL                                                                                                                                                                                                                     
fi

#echo "There are XXX steps to install Nix, you will be prompt for each step to confirm it"
#echo "[1/XXX] sudo tar xfj $WORK_DIR/${NAME}.tar.bz2 -C /"
#read confirm
sudo tar xfj $WORK_DIR/${NAME}.tar.bz2 -C /
sudo chown -R $USER /nix
/usr/bin/nix-finish-install
sudo rm /usr/bin/nix-finish-install
source $HOME/.nix-profile/etc/profile.d/nix.sh
cd $WORK_DIR

echo "Adding and updating Nix Packages (unstable) channel."
nix-channel --add http://nixos.org/channels/nixpkgs-unstable
nix-channel --update
nix-env -u \*

if which make >/dev/null; then
  echo "'make' command detected."
else
  nix-env -iA nixpkgs.gnumake
fi

echo ""
echo ""
echo ""
echo "========================================================================"
echo ""
echo "Make sure to source Nix user profile:"
echo "  echo \"source $HOME/.nix-profile/etc/profile.d/nix.sh\" >> ~/.profile"
echo ""
echo "And to run Plone you will need to setup \$LANG/\$LC_ALL:"
echo "  echo \"export LANG=\\\"en_US.UTF-8\\\"\" >> ~/.profile"
echo "  echo \"export LC_ALL=\\\"en_US.UTF-8\\\"\" >> ~/.profile"
echo ""
echo "========================================================================"
echo "                                                      ... happy Nix-ing!"
