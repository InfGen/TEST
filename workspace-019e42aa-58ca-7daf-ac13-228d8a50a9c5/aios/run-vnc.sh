#!/bin/bash
# AIOS Desktop VNC Launcher
# One-command way to run AIOS with full desktop accessible via browser

set -e

echo "🚀 Starting AIOS Desktop with VNC/noVNC..."
echo "This will build and run a full XFCE desktop you can control in your browser."

# Check for Docker
if ! command -v docker >/dev/null 2>&1; then
    echo "❌ Docker is not installed."
    echo "Please install Docker Desktop from https://docker.com and try again."
    exit 1
fi

cd "$(dirname "$0")"

echo "→ Building AIOS Desktop with VNC support..."
docker compose -f docker-compose.yml build --no-cache

echo ""
echo "✅ Build complete! Starting AIOS Desktop..."
echo ""
echo "📍 Access URLs (after it starts):"
echo "   🌐 Web Browser (Recommended): http://localhost:6080/vnc.html"
echo "   🔌 Traditional VNC: localhost:5900 (no password)"
echo ""
echo "The desktop includes:"
echo "   • Notepad (Mousepad)"
echo "   • Thunar File Explorer with rich right-click menu"
echo "   • Working Network Manager (WiFi settings)"
echo "   • All agent tools and dark cyber theme"
echo ""
echo "Press Ctrl+C to stop."
echo ""

# Start the service
docker compose -f docker-compose.yml up
