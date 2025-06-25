## ~/.config/nushell/env.nu
$env.PREFIX = "/data/data/com.termux/files/usr"
$env.PATH = ($env.PATH | append "/data/data/com.termux/files/home/.cargo/bin")
$env.PATH = ($env.PATH | append "/data/data/com.termux/files/home/.local/bin")
## RUST ##
$env.CARGO_HOME = "~/.cargo"
$env.config.buffer_editor = "nvim"
$env.config.edit_mode = "vi"
$env.CARAPACE_BRIDGES = 'zsh' # optional
mkdir ~/.cache/carapace
carapace _carapace nushell | save --force ~/.cache/carapace/init.nu

# zoxide init nushell --no-cmd | save -f ~/.zoxide.nu 
