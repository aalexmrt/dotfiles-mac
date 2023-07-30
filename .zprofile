#!/bin/zsh


alias peretes="cd /Users/alexmartinez/Documents/Facturas-Peretes-Fish-2022/scripts"

alias invoices_app="cd /Users/alexmartinez/Development/django_invoices_generator/ && \
source env/bin/activate && \
python3.9 manage.py runserver"

alias invoices_app_development="cd /Users/alexmartinez/Development/django_invoices_generator_development/ && \
source env/bin/activate && \
python3.9 manage.py runserver"


alias vi="nvim"
alias vim="nvim"
alias view="nvim -R"
alias vimdiff="nvim -d"

export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
