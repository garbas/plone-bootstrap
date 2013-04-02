NIX_PATH=~/.nix-defexpr/channels/

all: bootstrap
	bin/buildout

bootstrap: dev.nix
	NIX_PATH=${NIX_PATH} nix-build --out-link nixenv dev.nix
	./nixenv/bin/virtualenv --distribute --clear .
	echo ../../../nixenv/lib/python2.7/site-packages > lib/python2.7/site-packages/nixenv.pth
	./bin/easy_install -H "" zc.buildout

print-syspath:
	./bin/python -c 'import sys,pprint;pprint.pprint(sys.path)'

.PHONY: bootstrap print-syspath