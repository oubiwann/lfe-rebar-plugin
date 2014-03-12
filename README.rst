################
lfe-rebar-plugin
################


Introduction
============

A rebar plugin for common tasks of LFE-based projects, witten in LFE


Dependencies
------------

This project assumes that you have `rebar`_ installed somwhere in your
``$PATH``.

This project depends upon the following, which installed to the ``deps``
directory of this project when you run ``make deps``:

* `LFE`_ (Lisp Flavored Erlang; needed only to compile)
* `lfeunit`_ (needed only to run the unit tests)


Installation
============

Installation assumes you have created your LFE ``rebar`` plugin project
using `lfetool`_.

In order to use this plugin, you will need to do the following:

* Update your project's ``rebar.config`` to add the following:

.. code:: erlang

    {plugins, ['lfe-rebar-plugin']}.

* Update the ``deps`` section of your project's ``rebar.config`` to add the
  following:

.. code:: erlang

    {'lfe-rebar-plugin',
        ".*",
        {git, "git://github.com/lfe/lfe-rebar-plugin.git", "master"}}

After that, you'll need to ``make compile``, and you should be all set to use
it.


Usage
=====

Once you've got the sample plugin compiled, you can run the plugin's functions.
This sample plugin provides the follwoing commands (which both only print to
stdout, they don't perform any changes to the system):

* ``list-plugins``

* ``commands``


The are displayed below "in action". Note that these commands are run in the
working directory (``git clone`` of ``lfe-rebar-plugin``) after a
``make compile`` has been done:


``commands``
------------

.. code:: bash

    $ ERL_LIBS=. rebar commands
    ==> lfe (commands)
    ==> lfeunit (commands)
    ==> lfe-utils (commands)
    ==> rebar (commands)
    ==> lfe-rebar-plugin (commands)

    clean                                Clean
    compile                              Compile sources
    .
    .
    .
    Commands for the 'lfe-rebar-plugin' rebar plugin:

      list-plugins                   List all the plugins defined for the current dir
      commands                       List both the default commands and those for the plugins


``list-plugins``
----------------

.. code:: bash

    $ ERL_LIBS=. rebar list-plugins
    ==> lfe (list-plugins)
    ==> lfeunit (list-plugins)
    ==> lfe-utils (list-plugins)
    ==> rebar (list-plugins)
    ==> lfe-rebar-plugin (list-plugins)
    ['lfe-rebar-plugin']


Development
===========

To add new plugin commands, simply do the following:

#. create a command function that takes ``rebar-config`` and ``app-file`` as
   parameters

#. update the ``get-commands-help`` function with the new command function you
   added

#. submit a pull request!


.. Links
.. =====
.. _rebar: https://github.com/rebar/rebar
.. _LFE: https://github.com/rvirding/lfe
.. _lfeunit: https://github.com/lfe/lfeunit
.. _lfetool: https://github.com/lfe/lfetool
