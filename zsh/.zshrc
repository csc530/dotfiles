export PATH=$PATH:"/opt/homebrew/opt/postgresql@17/bin"

if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
  eval "$(oh-my-posh init zsh --config $(brew --prefix oh-my-posh)/themes/negligible.omp.json)"
fi


eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(zoxide init zsh)"

# carapace completer
# because compdef do not be defined on mac idk🤷‍♂️
# https://unix.stackexchange.com/questions/339954/zsh-command-not-found-compinstall-compinit-compdef
autoload -Uz compinit
compinit

export CARAPACE_BRIDGES='zsh,fish,bash,inshellisense' # optional
zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'
source <(carapace _carapace)

   ###    ##       ####    ###     ######  ########  ######
  ## ##   ##        ##    ## ##   ##    ## ##       ##    ##
 ##   ##  ##        ##   ##   ##  ##       ##       ##
##     ## ##        ##  ##     ##  ######  ######    ######
######### ##        ##  #########       ## ##             ##
##     ## ##        ##  ##     ## ##    ## ##       ##    ##
##     ## ######## #### ##     ##  ######  ########  ######

alias omp=oh-my-posh
alias cls=clear

# bun completions
[ -s "/Users/chrissc/.bun/_bun" ] && source "/Users/chrissc/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# deno
export PATH="$PATH:/Users/chrissc/.deno/bin"

set -o allexport; source ~/Onedrive/Documents/.env; set +o allexport

export PATH="/opt/homebrew/opt/php@7.4/bin:$PATH"
export PATH="/opt/homebrew/opt/php@7.4/sbin:$PATH"
# export PATH="/opt/homebrew/opt/php@8.4/bin:$PATH"
# export PATH="/opt/homebrew/opt/php@8.4/sbin:$PATH"
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"

export JAVA_HOME="/opt/homebrew/opt/openjdk"

fetchhys=(screenfetch neofetch fastfetch cpufetch pfetch pfetch-rs macchina)
${fetchhys[$RANDOM % $#fetchhys + 1]}
# ÷${fetcchys[$(($RANDOM % $#fetchhys + 1))]}