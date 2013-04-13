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
