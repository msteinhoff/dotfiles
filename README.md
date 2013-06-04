# OS X dotfile management

Mac OS X dotfiles for the daily usage. May also be used on other operations systems but not tested.

## dotfiles

The install-files.sh script creates symlinks in `$HOME` to all entries in `files`.

Inspired  by [this blog post](http://blog.smalleycreative.com/tutorials/using-git-and-github-to-manage-your-dotfiles/).

## dotfolders

Because I am pedantic, the install-folders.sh bridges the gap between the standard OS X filesystem layout (`System`, `Library`, `Applications`, etc) and classic unix dotfiles. This is especially handy when using  a PHD-synced account.

All dotfolders in `$HOME` should point to an appropriate folder in `~Library`, so they can be synced correctly by the background sync mechanism.