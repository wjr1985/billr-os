# billr-os

This is a custom Fedora Atomic image based on [Bazzite](https://bazzite.gg). This also borrows heavily from [Bazzite DX](https://github.com/ublue-os/bazzite-dx/), but doesn't include everything in Bazzite DX (namely no VSCode since I don't use it).

This is a WIP and will be changing frequently.

## Current features
- All Bazzite features
- 
- Includes the following additional packages
  - Required libraries for building Python and Ruby locally
  - [neovim](https://neovim.io) + python3-neovim
  - [mosh](https://mosh.org)
  - plasma-workspace-x11
    - so [Synergy](https://symless.com/synergy) / [Deskflow](https://github.com/deskflow/deskflow) can run in X11 vs Wayland
  - tmux