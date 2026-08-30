# Manual tasks

## System preferences

- **Keyboard > Keyboard Shortcuts > Modifier Keys:** Map Caps Lock to Control for each keyboard.
- **Privacy & Security > Privacy > Screen Recording:** Add web browsers to allow screen sharing (must first be requested by the browser).
- **Privacy & Security > Privacy > Full Disk Access:** Add Kitty, so the `shi` function can read Safari's history database.

## Keep Vim updated

```sh
vim -c 'PlugUpgrade | PlugUpdate | CocUpdate'
```

## Speed up large repositories

Run this once per clone of a large repository. It schedules background prefetch
and repacking, so `git f` is usually instant and the repo stays packed.

```sh
git maintenance start
```

## Sign in to the App Store

`mas` can install and upgrade App Store apps listed in the Brewfile, but it
cannot sign in for you. Sign in to the App Store once, then `brew bundle
install` picks up the rest.

## Start the Herdr keep-awake watcher

Run this once after every reboot. The watcher keeps running across terminal and
Herdr restarts:

```sh
herdr plugin action invoke start --plugin herdr-wakeup
```

Check or stop it with:

```sh
herdr plugin action invoke status --plugin herdr-wakeup
herdr plugin action invoke stop --plugin herdr-wakeup
```

## Require an SSH key for remote login

First confirm that public-key login works in a second terminal. Then run:

```sh
~/.dotfiles/bin/setup-sshd.sh
```

This is kept out of the normal setup because disabling password login before a
key works can lock you out of the Mac.
