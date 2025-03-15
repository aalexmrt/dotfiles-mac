#!/bin/bash

echo "🔧 Setting up OrbStack monitor..."

# Create the OrbStack monitor script
cat > "$HOME/.orbstack-monitor.sh" << 'EOF'
#!/bin/bash

# Check if OrbStack is running
if ! pgrep -q "OrbStack"; then
    exit 0
fi

# Check if any containers are running
if [ "$(docker ps -q 2>/dev/null)" = "" ]; then
    # Log the action with timezone-aware date
    echo "$(TZ='America/New_York' date): Stopping OrbStack due to inactivity" >> "$HOME/.orbstack-monitor.log"
    # Stop OrbStack
    pkill OrbStack
fi
EOF

# Make the script executable
chmod +x "$HOME/.orbstack-monitor.sh"

# Ask user for interval
echo "How often should OrbStack be checked? (in minutes, recommended: 10)"
read -p "Minutes: " interval

# Default to 10 minutes if no input
if [ -z "$interval" ]; then
    interval=10
fi

# Set up the cronjob to run at the specified interval
CRON_JOB="*/$interval * * * * $HOME/.orbstack-monitor.sh"
(crontab -l 2>/dev/null | grep -v "orbstack-monitor" ; echo "$CRON_JOB") | crontab -

echo "✅ OrbStack monitor set up successfully (runs every $interval minutes)"
echo "📝 Logs will be saved to $HOME/.orbstack-monitor.log"

# Add instructions
cat << 'EOF'

To check the status of the monitor:
  cat ~/.orbstack-monitor.log

To disable the monitor:
  crontab -l | grep -v "orbstack-monitor" | crontab -

To view current cron jobs:
  crontab -l
EOF 