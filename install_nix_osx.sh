WORK_DIR=`pwd`
curl -O http://hydra.nixos.org/build/4256485/download/1/nix-1.5.1pre3069_8057a19-x86_64-darwin.tar.bz2
cd /
sudo tar xfj $WORK_DIR/nix-1.5.1pre3069_8057a19-x86_64-darwin.tar.bz2
sudo chown -R $USER /nix
/usr/bin/nix-finish-install
echo "source /Users/$USER/.nix-profile/etc/profile.d/nix.sh" >> ~/.profile
source /Users/$USER/.nix-profile/etc/profile.d/nix.sh
cd $WORK_DIR
nix-channel --add http://nixos.org/channels/nixpkgs-unstable
nix-channel --update
# TODO: check if make is availiable
nix-env -iA nixpkgs.gnumake
echo "export LANG=\"en_US.UTF-8\"" >> ~/.profile
echo "export LC_COLLATE=\"en_US.UTF-8\"" >> ~/.profile
echo "export LC_CTYPE=\"en_US.UTF-8\"" >> ~/.profile
echo "export LC_MESSAGES=\"en_US.UTF-8\"" >> ~/.profile
echo "export LC_MONETARY=\"en_US.UTF-8\"" >> ~/.profile
echo "export LC_NUMERIC=\"en_US.UTF-8\"" >> ~/.profile
echo "export LC_TIME=\"en_US.UTF-8\"" >> ~/.profile
echo "export LC_ALL=\"en_US.UTF-8\"" >> ~/.profile