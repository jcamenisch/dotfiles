
My DotFiles and other personal *nix configs
===========================================

Profile files for a few different *nix hosts.

Should be increasingly sharable among Linux, FreeBSD, and OS X machines. Currently gets tested first on OS X in zsh, and then on Linux in bash. Zsh & Bash have a way of being subtly different on annoying details; thus I will break Bash from time to time, and hopefully fix it when it hurts enough.

Installation
------------

1. Copy the repo:

   ```sh
   git clone https://github.com/jcamenisch/dotfiles.git ~/.jcamenisch
   ```

2. (Optional) To permanently install, call rc files from local one(s):

   ```sh
   echo '. $HOME/.jcamenisch/bash_profile' >> ~/.bash_profile
   echo '. $HOME/.jcamenisch/bashrc' >> ~/.bashrc
   echo '. $HOME/.jcamenisch/zshrc' >> ~/.zshrc
   ```

Manual invocation
-----------------

After the repo is in place, use dotfiles in zsh (or bash as fallback) with

```sh
~/.jcamenisch/shell
```

To exit immediately after session is closed (avoid need to exit twice), call

```sh
~/.jcamenisch/shexit
```

One-off use, with no files left behind
--------------------------------------

To avoid touching someone else's precious profile, but still use these dotfiles while you're there, just run

```
git clone https://github.com/jcamenisch/dotfiles.git ~/.jcamenisch && ~/.jcamenisch/shexit --clean
```

This will create the ~/.jcamenisch directory, but remove it completely when you exit the session. It will
also set `PROFILEMODE_CLEAN=1` in the shell session, to inform any apps that may want to skip setup steps
in this mode. Vim responds to this flag by not taking time to install any plugins.
