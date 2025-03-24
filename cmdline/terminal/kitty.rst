=====
Kitty
=====

Login Shell and Startup RC Files
--------------------------------

Looks like `macOS
<https://sw.kovidgoyal.net/kitty/conf/?highlight=login%20shell#advanced>`_
does not read the shell's RC startup files by default. Even *without* changing
the default, starting Kitty from the GUI (Spotlight, for example) causes the
shell inside kitty not to read RC files. What I do is to launch kitty from
Terminal.app or iTerm2.app. I don't remember having such problems on Arch
Linux.

Single vs Multiple Kitty Windows
--------------------------------

If we have a running kitty instance windows, and open another one from the
running instance, perhaps by running `Ctrl+n` or `Cmd+n`, this new window
seems to share some main process because setting a new window tittle to this
window also changes the window title on the other window and vice-versa. Also,
in this case, there is a single Kitty icon on macOS dock.

I generally have at least two or three windows with a few tabs in each one for
each thing I am working on. For example, may day job project and at least my
personal dotfiles project. In this case, I don't want both Kitty windows to be
the same "process" or whatever. I want to set window titles independently from
each other. At least for now, in macOS, the solution seems to open Kitty from
a running shell session:

.. code-block::

    $ kitty -d ~/Projects/dotfiles --title DOTFILES &
    $ kitty -d ~/work/src/proj-x --title PROJECT-X &


Setting Title
-------------

Here's a bash script to set the a given title for all kitty windows,
which causes the current OS window to have the same title no matter
which (non-OS) window or tab is selected.

.. literalinclude:: /../src/cmdline/kitty-set-window-title.bash
   :language: bash
   :linenos:

Themes
------

Check the kitty-themes_ repository.

.. _kitty-themes: https://github.com/dexpota/kitty-themes

Vim + Kitty + Solarized Light
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The Kitty Solarized Light sets vim's background to dark (as of
2020~2021, at least). Check `this issue
<https://github.com/dexpota/kitty-themes/issues/44#issuecomment-903292415>`_
for a solution. In short, replace ``color7`` and ``color15`` with
these:

.. code-block::

   color7  #eee8d5
   color15  #fdf6e3

