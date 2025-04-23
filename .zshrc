export ZSH="$HOME/.oh-my-zsh"
export USE_GKE_GCLOUD_AUTH_PLUGIN=True
export LANG=en_US.UTF-8

ZSH_THEME="agnoster"

setopt INC_APPEND_HISTORY
HIST_STAMPS="mm/dd/yyyy"

#python alias 
alias p='python'


# Plugins
plugins=(git fzf ssh-agent colored-man-pages docker terraform pip golang ansible kubectl helm virtualenvwrapper aws argocd alias-finder zsh-syntax-highlighting zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

alias ssh="TERM=xterm ssh"
alias vim="nvim"
export SC_USER=1000:1000
alias rm='rm -I'

source '/opt/kube-ps1/kube-ps1.sh'
PROMPT='$(kube_ps1)'$PROMPT
export SC_DOCKER_ENABLED=1
#. torsocks on
zstyle ':omz:plugins:alias-finder' autoload yes # disabled by default
zstyle ':omz:plugins:alias-finder' longer yes # disabled by default
zstyle ':omz:plugins:alias-finder' exact yes # disabled by default
zstyle ':omz:plugins:alias-finder' cheaper yes # disabled by default

function yy() {
    xclip -selection clipboard
}
export GOPATH=$HOME/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
# conda cuda setup
# XLA_FLAGS=--xla_gpu_cuda_data_dir=/opt/cuda
export XLA_FLAGS=--xla_gpu_cuda_data_dir=/opt/cuda
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"

