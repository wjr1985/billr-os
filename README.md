# billr-os

This is a custom Fedora Atomic image based on [Bazzite](https://bazzite.gg) and [Bazzite-dx](https://dev.bazzite.gg) with some changes for my specific experience.

This is a WIP and will be changing frequently.

## Current features
- All Bazzite features
- All Bazzite-dx features
- Includes the following additional packages
  - Required libraries for building Python and Ruby locally
  - [neovim](https://neovim.io) + python3-neovim
  - [mosh](https://mosh.org)
  - plasma-workspace-x11
    - so [Synergy](https://symless.com/synergy) / [Deskflow](https://github.com/deskflow/deskflow) can run in X11 vs Wayland
  - tmux