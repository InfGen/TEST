FROM alpine:edge AS builder

# Install everything in one layer for small size
RUN apk add --no-cache \
    alpine-base \
    zsh curl wget git jq yq-go \
    python3 py3-pip py3-virtualenv \
    build-base linux-headers \
    neovim htop btop \
    ripgrep fd fzf bat eza starship fastfetch \
    ca-certificates tzdata openssh sudo \
    && apk add --no-cache --repository=http://dl-cdn.alpinelinux.org/alpine/edge/community uv \
    && rm -rf /var/cache/apk/* /tmp/*

FROM alpine:edge

COPY --from=builder / /

# Setup agent user
RUN adduser -D -s /bin/zsh -h /home/agent agent && \
    echo "agent ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/agent && \
    mkdir -p /home/agent/.config /etc/aios /var/log/aios

# Copy AIOS specific files (we embed them)
COPY motd /etc/motd
COPY aios-help /usr/local/bin/aios-help
RUN chmod +x /usr/local/bin/aios-help

# Starship config (cyber/AI theme)
RUN mkdir -p /root/.config /home/agent/.config && \
    cat > /root/.config/starship.toml << 'EOF'
format = """$os$username$hostname$directory$git_branch$git_status$cmd_duration$character"""

[os]
disabled = false
style = "bold magenta"
format = "[🜁 AIOS](bold magenta) "

[character]
success_symbol = "[➤](bold green)"
error_symbol = "[×](bold red)"
vimcmd_symbol = "[❮](bold green)"

[directory]
style = "bold cyan"
read_only = " 🔒"
truncation_length = 4

[git_branch]
symbol = ""
style = "bold purple"
EOF

RUN cp -a /root/.config/. /home/agent/.config/ && chown -R agent:agent /home/agent

# Fastfetch with custom AI logo
RUN mkdir -p /root/.config/fastfetch /home/agent/.config/fastfetch && \
    cat > /root/.config/fastfetch/config.jsonc << 'EOF'
{
  "$schema": "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json",
  "logo": {
    "type": "raw",
    "source": "   \u001b[36m█████╗ ██╗    ██╗ █████╗ ███████╗\u001b[0m\n  \u001b[36m██╔══██╗██║    ██║██╔══██╗██╔════╝\u001b[0m\n  \u001b[36m███████║██║ █╗ ██║███████║███████╗\u001b[0m\n  \u001b[36m██╔══██║██║███╗██║██╔══██║╚════██║\u001b[0m\n  \u001b[36m██║  ██║╚███╔███╔╝██║  ██║███████║\u001b[0m\n  \u001b[36m╚═╝  ╚═╝ ╚══╝╚══╝ ╚═╝  ╚═╝╚══════╝\u001b[0m\n        \u001b[35mAgentic Intelligence OS v0.1\u001b[0m"
  },
  "display": {
    "separator": " → ",
    "color": {
      "keys": "36",
      "title": "35"
    }
  },
  "modules": [
    "title",
    "separator",
    "os",
    "host",
    "kernel",
    "uptime",
    "packages",
    "shell",
    "separator",
    { "type": "command", "key": "Purpose", "text": "Built exclusively for autonomous AI agents" },
    { "type": "command", "key": "Philosophy", "text": "Minimal. Fast. Tool-first. Headless." },
    "separator",
    "cpu",
    "memory",
    "disk",
    "separator",
    "colors"
  ]
}
EOF
RUN cp /root/.config/fastfetch/config.jsonc /home/agent/.config/fastfetch/config.jsonc

# Environment and welcome sequence
RUN cat > /etc/profile.d/aios.sh << 'EOF'
#!/bin/sh
export PATH="$PATH:/usr/local/bin:/home/agent/.local/bin"
export PYTHONUNBUFFERED=1
export PYTHONDONTWRITEBYTECODE=1
export AGENT_MODE=true
export AIOS_VERSION="0.1.0"

alias ls="eza --icons --color=always"
alias ll="eza -lh --icons --color=always"
alias la="eza -lah --icons --color=always"
alias cat="bat --paging=never"
alias vim="nvim"
alias help="aios-help"
alias status="agent-status"

echo -e "\033[1;36m"
cat /etc/motd
echo -e "\033[0m"
fastfetch --config /root/.config/fastfetch/config.jsonc 2>/dev/null || echo "\033[1;32mAIOS Agent Runtime initialized.\033[0m"
echo ""
EOF

# Agent helper tools
RUN cat > /usr/local/bin/agent-status << 'EOF'
#!/bin/sh
echo "🤖 AIOS Agent Status Report"
echo "=========================="
echo "Version: ${AIOS_VERSION:-0.1}"
echo "Shell: $(ps -p $$ -o comm=)"
echo "Uptime: $(uptime -p)"
echo "Python: $(python3 -c 'import sys; print(sys.version.split()[0])')"
echo "Memory: $(free -h | awk '/^Mem:/ {print $3 "/" $2}')"
echo ""
echo "This container is purpose-built for agentic AI systems."
echo "Use 'install-agent langchain crewai' or similar to add frameworks."
EOF
RUN chmod +x /usr/local/bin/agent-status /usr/local/bin/aios-help

RUN cat > /usr/local/bin/aios-help << 'EOF'
#!/bin/sh
cat << 'HELP'
[1;36mAIOS Command Reference[0m
[36m═══════════════════════[0m
fastfetch     : Beautiful system overview with AI branding
agent-status  : Current agent runtime health
install-agent : Install Python agent frameworks via uv (recommended)
status        : Alias for agent-status
help          : This help

[1;33mCore Tools[0m
• Modern ls/cat: eza + bat
• Search: rg (ripgrep), fd, fzf
• Editor: neovim
• Prompt: Starship (cyber theme)

[1;32mAIOS is not for humans.[0m
It is a purpose-built runtime for *autonomous agents*.
Perfect base for Docker, Kubernetes, or bare-metal agent swarms.
HELP
EOF
RUN chmod +x /usr/local/bin/aios-help

# Make zsh default
RUN sed -i 's#/bin/ash#/bin/zsh#' /etc/passwd

ENTRYPOINT ["/bin/zsh"]
CMD ["-i"]
