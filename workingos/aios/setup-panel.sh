#!/bin/sh
echo "Setting up Windows 10 style taskbar and desktop defaults..."

# Use /etc/xdg/xfce4/xfconf/xfce-perchannel-xml for system-wide defaults
# This ensures that when the user starts XFCE, it picks up these settings.
XFCONF_DIR="/etc/xdg/xfce4/xfconf/xfce-perchannel-xml"
mkdir -p "$XFCONF_DIR"

# 1. Panel Configuration (Windows 10 style bottom taskbar)
cat > "$XFCONF_DIR/xfce4-panel.xml" << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<channel name="xfce4-panel" version="1.0">
  <property name="configver" type="int" value="2"/>
  <property name="panels" type="array">
    <value type="int" value="1"/>
  </property>
  <property name="panel-1" type="empty">
    <property name="position" type="string" value="p=6;x=0;y=0"/>
    <property name="length" type="double" value="100"/>
    <property name="position-locked" type="bool" value="true"/>
    <property name="size" type="uint" value="40"/>
    <property name="background-style" type="uint" value="0"/>
    <property name="plugin-ids" type="array">
      <value type="int" value="1"/>
      <value type="int" value="2"/>
      <value type="int" value="3"/>
      <value type="int" value="4"/>
      <value type="int" value="5"/>
      <value type="int" value="6"/>
    </property>
  </property>
  <property name="plugins" type="empty">
    <property name="plugin-1" type="string" value="whiskermenu"/>
    <property name="plugin-2" type="string" value="tasklist">
      <property name="flat-buttons" type="bool" value="true"/>
      <property name="show-labels" type="bool" value="true"/>
      <property name="grouping" type="bool" value="true"/>
    </property>
    <property name="plugin-3" type="string" value="separator">
      <property name="expand" type="bool" value="true"/>
      <property name="style" type="uint" value="0"/>
    </property>
    <property name="plugin-4" type="string" value="systray">
      <property name="square-icons" type="bool" value="true"/>
    </property>
    <property name="plugin-5" type="string" value="pulseaudio">
      <property name="enable-keyboard-shortcuts" type="bool" value="true"/>
    </property>
    <property name="plugin-6" type="string" value="clock">
      <property name="mode" type="uint" value="2"/>
      <property name="digital-format" type="string" value="%H:%M %d-%m-%Y"/>
    </property>
  </property>
</channel>
EOF

# 2. Desktop Configuration (Windows 10 Blue Background)
cat > "$XFCONF_DIR/xfce4-desktop.xml" << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<channel name="xfce4-desktop" version="1.0">
  <property name="backdrop" type="empty">
    <property name="screen0" type="empty">
      <property name="monitor0" type="empty">
        <property name="image-path" type="string" value=""/>
        <property name="last-image" type="string" value=""/>
        <property name="color-style" type="uint" value="0"/>
        <property name="rgba1" type="array">
          <value type="double" value="0.0"/>
          <value type="double" value="0.466667"/>
          <value type="double" value="0.784314"/>
          <value type="double" value="1.0"/>
        </property>
      </property>
    </property>
  </property>
  <property name="desktop-icons" type="empty">
    <property name="file-icons" type="empty">
      <property name="show-home" type="bool" value="true"/>
      <property name="show-filesystem" type="bool" value="true"/>
      <property name="show-trash" type="bool" value="true"/>
    </property>
  </property>
</channel>
EOF

# 3. Theme Configuration (Set to Adwaita-dark for now, Papirus icons)
cat > "$XFCONF_DIR/xsettings.xml" << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<channel name="xsettings" version="1.0">
  <property name="Net" type="empty">
    <property name="ThemeName" type="string" value="Adwaita-dark"/>
    <property name="IconThemeName" type="string" value="Papirus-Dark"/>
    <property name="FontName" type="string" value="Noto Sans 10"/>
  </property>
  <property name="Xft" type="empty">
    <property name="Antialias" type="int" value="1"/>
    <property name="Hinting" type="int" value="1"/>
    <property name="HintStyle" type="string" value="hintslight"/>
    <property name="RGBA" type="string" value="rgb"/>
  </property>
</channel>
EOF

# 4. Window Manager Configuration
cat > "$XFCONF_DIR/xfwm4.xml" << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<channel name="xfwm4" version="1.0">
  <property name="general" type="empty">
    <property name="theme" type="string" value="Default"/>
    <property name="title_alignment" type="string" value="center"/>
    <property name="button_layout" type="string" value="O|HMC"/>
  </property>
</channel>
EOF

# Also set whiskermenu rc for the agent
mkdir -p /home/agent/.config/xfce4/panel
cat > /home/agent/.config/xfce4/panel/whiskermenu-1.rc << 'EOF'
[whiskermenu]
button-title=Start
button-icon=xfce4-whiskermenu
show-favorites=true
show-recent=true
icon-size=2
EOF
chown -R agent:agent /home/agent/.config

echo "Windows 10 taskbar and desktop setup completed."
