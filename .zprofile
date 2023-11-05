#!/bin/zsh

alias invoices_app="cd /Users/alexmartinez/Development/django-invoices-generator/ && \
source env/bin/activate && \
python3.9 manage.py runserver"

alias invoices_app_development="cd /Users/alexmartinez/Development/django-invoices-generator-development/ && \
source env/bin/activate && \
python3.9 manage.py runserver"


alias vi="nvim"
alias vim="nvim"
alias view="nvim -R"
alias vimdiff="nvim -d"

export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# Using the nvm specific version if there's a .nvmrc file on current project
# Make sure to have your default node version configured
# More information to configure it: https://dev.to/smpnjn/setting-the-default-nodejs-version-with-nvm-54c3
autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc
