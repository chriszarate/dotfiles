# Manual tasks

## System preferences

- **Keyboard > Modifier Keys:** Map Caps Lock to Control for each keyboard.
- **Security & Privacy > Privacy > Screen Recording:** Add web browsers to allow screen sharing (must first be requested by the browser).

## Keep Vim updated

```sh
vim -c 'PlugUpgrade | PlugUpdate | CocUpdate'
```

## Allow TouchID for sudo

```sh
sudo vim /etc/pam.d/sudo
```

Add this entry to the top of the file. Write and test before closing.

```
auth       sufficient     pam_tid.so
```
