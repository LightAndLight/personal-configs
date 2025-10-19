# `emacs` config

## Updating `.spacemacs`

1. Replace the Nix-managed `.spacemacs` with a local, mutable version

   ```
   $ cp ~/.spacemacs ~/.spacemacs.new
   $ chmod u+w ~/.spacemacs.new
   $ mv ~/.spacemacs.new ~/.spacemacs
   ```

2. Start `spacemacs` and diff against the updated new dotfile template

   `SPC f e D`

3. Save updated `~/.spacemacs` and replace the copy in this repository

  ```
  $ mv ~/.spacemacs $PROJECT_ROOT/home/emacs/spacemacs
  ```
