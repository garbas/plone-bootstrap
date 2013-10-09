This will get you ready for development in no time.


Install Nix
===========

You need to install Nix only once.

Quick and dirty way would be::

    ./install_nix.sh


or follow instructions `here`_:


Bootstrap Plone development environment
=======================================

::

    git clone git://github.com/garbas/plone-nix.git
    cd plone-nix
    make

You have example ``buildout.cfg`` already present, now use it as you're used to
work with ``zc.buildout``.

After ``make`` run ``bin/buildout`` as usual.

.. _`here`: http://nixos.org/nix/manual/#chap-quick-start
