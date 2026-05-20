# AIOS Desktop via Browser (VNC/noVNC)

**One-click launcher added.**

## Easiest Way to Run

```bash
cd aios
chmod +x run-vnc.sh
./run-vnc.sh
```

This script will:
1. Check for Docker
2. Build the full AIOS Desktop (XFCE + Notepad + Thunar + rich context menus + real NetworkManager)
3. Start VNC + noVNC
4. Show you the exact URLs to open

**Access it in your browser at:**
**http://localhost:6080/vnc.html**

You will have full mouse + keyboard control over the AIOS desktop.

### Features Recap
- **Notepad**: Mousepad with right-click integration
- **File Explorer**: Thunar with custom context menu (Terminal here, New File, Git, etc.)
- **WiFi/Internet**: Full NetworkManager with tray applet (real connecting)
- Dark modern theme, agent tools, autostart welcome terminal
- Persistent workspace at `./workspace` on your machine

### Alternative (Manual)
```bash
docker compose up --build
```

Then open `http://localhost:6080/vnc.html`

---

**Would you like any modifications before you run it?**
- Add a login password for VNC?
- Change screen resolution (currently 1280x800)?
- Pre-install specific software (Ollama, VS Code, etc.)?
- Add a custom background image?

Just tell me and I will update the files instantly.

The complete project is ready in the `aios/` folder. Run `./run-vnc.sh` on any machine with Docker installed.
