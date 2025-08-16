#
# ~/.bashrc
#
source ~/.bash_aliases

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='[\u@\h \W]\$ '

# oh-my-posh
eval $(oh-my-posh init bash --print --config ~/.config/oh-my-posh/themes/theme.omp.json)
# carapace
source <(carapace _carapace bash)
# zoxide
source <(zoxide init bash)

set -a # automatically export all variables
#source $HOME/.shell.env
set +a

cookie=("fortune" "misfortune --all")
fetch=(pfetch macchina fastfetch screenfetch)

${fetch[$(( RANDOM % ${#fetch[@]} ))]}
${cookie[$(( $RANDOM % ${#cookie[@]} ))]}
