# Default editor
set -gx EDITOR nvim
set -gx VISUAL nvim

# Rustup
set -gx RUSTUP_DIST_SERVER "https://rsproxy.cn"
set -gx RUSTUP_UPDATE_ROOT "https://rsproxy.cn/rustup"

# PATH
fish_add_path ~/.cargo/bin
fish_add_path ~/.local/share/bob/nvim-bin
fish_add_path ~/.local/bin
