NIX_PATH=~/.nix-defexpr/channels/

all: install_plone
	bin/buildout

install_plone: plone.nix
	NIX_PATH=${NIX_PATH} nix-build --out-link nixenv plone.nix
	./nixenv/bin/virtualenv --distribute --clear .
	echo ../../../nixenv/lib/python2.7/site-packages > lib/python2.7/site-packages/nixenv.pth
	./bin/easy_install -H "" zc.buildout

print-python-syspath:
	./bin/python -c 'import sys,pprint;pprint.pprint(sys.path)'

.PHONY: bootstrap print-syspath
