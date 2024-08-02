# cargo completions
. "$HOME/.cargo/env"
# oh-my-posh completions
. "$HOME/.config/omp/.bashrc"
# zoxide init
eval "$(zoxide init bash)"
. "$HOME/.cargo/env"


export EDITOR=/usr/bin/micro
export VISUAL="/usr/bin/code --wait"

# asdf - stuff manager :)
. "$HOME/.asdf/asdf.sh"
. "$HOME/.asdf/completions/asdf.bash"

# bun
export PATH=$BUN_INSTALL/bin:$PATH
DOTNET_ROOT=$(asdf where dotnet)
export DOTNET_ROOT