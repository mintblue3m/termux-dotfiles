## ~/.config/nushell/env.nu
$env.PATH = ($env.PATH | append "/data/data/com.termux/files/home/.cargo/bin")
$env.PATH = ($env.PATH | append "/data/data/com.termux/files/home/.local/bin")
$env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense' # optional
mkdir ~/.cache/carapace
carapace _carapace nushell | save --force ~/.cache/carapace/init.nu

# zoxide init nushell --no-cmd | save -f ~/.zoxide.nu 
