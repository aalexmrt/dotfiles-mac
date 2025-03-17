eval "$(/opt/homebrew/bin/brew shellenv)"
echo "✅ Initialized Homebrew environment"

# PostgreSQL binaries
export PATH="/opt/local/lib/postgresql14/bin:$PATH"
echo "✅ Added PostgreSQL binaries to PATH"

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init.zsh 2>/dev/null || :
echo "✅ Initialized OrbStack"

# Created by `pipx` on 2024-11-26 03:55:29
export PATH="$PATH:/Users/alexmartinez/.local/bin"
echo "✅ Added local bin to PATH"

# Define nvm function that will load NVM only when first used
nvm() {
    echo "🔄 Loading NVM..."
    unset -f nvm
    export NVM_DIR="$HOME/.nvm"
    # Try MacPorts nvm first, then fall back to Homebrew if needed
    if [ -s "/opt/local/share/nvm/init-nvm.sh" ]; then
        source /opt/local/share/nvm/init-nvm.sh
    elif [ -s "/opt/homebrew/opt/nvm/nvm.sh" ]; then
        \. "/opt/homebrew/opt/nvm/nvm.sh"
        \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"
    fi
    echo "✅ NVM loaded"
    # Call nvm with the provided arguments
    nvm "$@"
}

# Django invoices app shortcut
alias run-invoices='echo "🚀 Starting Django invoices app..." && cd /Users/alexmartinez/Documents/django-invoices-generator && export DYLD_LIBRARY_PATH=/opt/local/lib:$DYLD_LIBRARY_PATH && poetry run python manage.py runserver'

# Docker compose shortcuts
alias dc='echo "Checking if OrbStack is running..." && manage_orbstack && echo "🐳 Running docker compose command:" && docker compose'
alias dcu='echo "Checking if OrbStack is running..." && manage_orbstack && echo "🚀 Starting docker compose services..." && docker compose up'
alias dcd='echo "🛑 Stopping docker compose services..." && docker compose down && stop_orbstack'

# Docker cleanup - removes all containers, volumes, and prunes the system
alias docker-clean='echo "🧹 Starting Docker cleanup..." && \
  echo "⏳ Stopping containers..." && \
  docker stop $(docker ps -aq) 2>/dev/null && \
  echo "⏳ Removing containers..." && \
  docker rm $(docker ps -aq) 2>/dev/null && \
  echo "⏳ Pruning system..." && \
  docker system prune -f --volumes && \
  echo "⏳ Removing volumes..." && \
  docker volume rm $(docker volume ls -q) 2>/dev/null && \
  echo "✨ Docker cleanup complete"'

# Clean node_modules with verbose output
alias clean-modules='echo "🔍 Searching for node_modules directories..." && \
  find . -name "node_modules" -type d -prune -print -exec sh -c '\''echo "🗑️  Removing: {}" && rm -rf "{}"'\'' \; && \
  echo "✨ Finished cleaning node_modules directories"'

# Reload shell configuration - fixed version
alias reload='echo "🔄 Reloading shell configuration..." && source ~/.zprofile && echo "✅ Shell configuration reloaded"'

# PNPM shortcuts with logging
alias dev='echo "🚀 Starting development server..." && pnpm dev'
alias build='echo "🏗️  Building project..." && pnpm build'
alias start='echo "🚀 Starting production server..." && pnpm start'
alias test='echo "🧪 Running tests..." && pnpm test'
alias lint='echo "🔍 Running linter..." && pnpm lint'
alias format='echo "✨ Formatting code..." && pnpm format'

# Helper function to display all aliases and their descriptions
alias_help() {
  echo "\n🔍 Available Aliases and Commands:\n"
  
  echo "📦 Package Management:"
  echo "  dev        🚀 Start development server using pnpm"
  echo "  build      🏗️  Build the project using pnpm"
  echo "  start      🚀 Start production server using pnpm"
  echo "  test       🧪 Run tests using pnpm"
  echo "  lint       🔍 Run linter using pnpm"
  echo "  format     ✨ Format code using pnpm"
  
  echo "\n🐳 Docker Commands:"
  echo "  manage_orbstack 🚀 Manage OrbStack"
  echo "  dc         🐳 Run docker compose command"
  echo "  dcu        🚀 Start docker compose services"
  echo "  dcd        🛑 Stop docker compose services"
  echo "  docker-clean 🧹 Remove all containers, volumes, and prune system"
  
  echo "\n🧹 Cleanup Commands:"
  echo "  clean-modules 🗑️  Remove all node_modules directories recursively"
  
  echo "\n🔄 System Commands:"
  echo "  reload     🔄 Reload shell configuration"
  echo "  crontasks  📋 List all your scheduled cron tasks"
  
  echo "\n🚀 Application Shortcuts:"
  echo "  run-invoices 📊 Start Django invoices application"
  
  echo "\n💡 Help:"
  echo "  help       📚 Display this help message"
  
  echo "\n🐋 OrbStack Commands:"
  echo "  orbstack-stop 🛑 Stop OrbStack if no containers are running"
}

# Add help alias
alias help="alias_help"

echo "✅ All aliases and configurations loaded successfully"
echo "💡 Type 'help' to see all available commands"

# MacPorts Installer addition on 2025-03-15_at_00:47:56: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.

# Run fastfetch on terminal start
if command -v fastfetch &> /dev/null; then
    echo "🖥️  Running system info..."
    fastfetch
else
    echo "⚠️  fastfetch is not installed. Install it with: sudo port install fastfetch"
fi
# Function to manage OrbStack
manage_orbstack() {
    # Check if OrbStack is running
    if ! pgrep -q "OrbStack"; then
        echo "🚀 Starting OrbStack in background..."
        # Start OrbStack without showing the window
        open -gj -a OrbStack
        # Wait for OrbStack to fully start
        sleep 5
    fi
}

# Function to stop OrbStack if no containers are running
stop_orbstack() {
    if [ "$(docker ps -q 2>/dev/null)" = "" ]; then
        if pgrep -q "OrbStack"; then
            echo "🛑 No active containers, stopping OrbStack..."
            pkill OrbStack
            return 0
        else
            echo "ℹ️ OrbStack is not running"
            return 1
        fi
    else
        echo "⚠️ Active containers found, keeping OrbStack running"
        return 1
    fi
}

# Add OrbStack stop alias
alias orbstack-stop='stop_orbstack'

# Add crontab listing alias
alias crontasks='echo "📋 Your scheduled cron tasks:" && crontab -l'
