# Define an alias for easily invoking Homebrew for Intel

# ---- apple m1 brew stuff ----
alias intel_brew='arch --x86_64 /usr/local/Homebrew/bin/brew'
# Default `brew` to Homebrew for Intel
alias brew=intel_brew
alias apple_brew='arch --arm64e /opt/homebrew/bin/brew'
# ---- ----

# aws
export AWS_SDK_LOAD_CONFIG=1
export AWS_PROFILE=default

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Set up the prompt
eval "$(starship init zsh)"

