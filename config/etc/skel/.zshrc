# Place this file at: config/etc/skel/.zshrc

# Path to your oh-my-zsh installation.
# Universal Blue's ucore image should include oh-my-zsh by default.
export ZSH="/usr/share/oh-my-zsh"

# Set ZSH_THEME to "robbyrussell" or any other theme you like.
# For a minimal writerdeck, a simple theme is often best.
ZSH_THEME="robbyrussell"

# Plugins for Zsh.
# Ensure these are installed as part of your RPM_OSTREE_INSTALL if you use them.
# For example, 'zsh-autosuggestions' and 'zsh-syntax-highlighting' are separate packages.
plugins=(
  git
  # zsh-autosuggestions # Add if you install the package
  # zsh-syntax-highlighting # Add if you install the package
)

source "$ZSH/oh-my-zsh.sh"

# Set Neovim as the default editor for command-line tools.
export EDITOR="nvim"
export VISUAL="nvim"

# Basic aliases for convenience.
alias ls='ls --color=auto'
alias ll='ls -lh'
alias la='ls -lha'

# Ptyxis specific settings (optional, Ptyxis has its own config file usually)
# export TERM=ptyxis # Ptyxis should set this automatically

