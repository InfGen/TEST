#!/bin/sh
echo "Setting up Windows 10 style taskbar..."

mkdir -p /home/agent/.config/xfce4/xfconf/xfce-perchannel-xml
mkdir -p /home/agent/.config/xfce4/panel

# Windows 10 bottom panel
cat > /home/agent/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<channel name="xfce4-panel" version="1.0">
  <property name="configver" type="int" value="2"/>
  <property name="panels" type="array">
    <value type="int" value="1"/>
  </property>
  <property name="panel-1" type="empty">
    <property name="position" property="position" type="string" value="p=6;x=0;y=0"/>
    <property name="length" type="double" value="100"/>
    <property name="size" type="uint" value="40"/>
    <property name="background-style" type="uint" value="1"/>
    <property name="background-rgba" type="string" value="#1e1e1eff"/>
    <property name="plugin-ids" type="array">
      <value type="int" value="1"/>
      <value type="int" value="2"/>
      <value type="int" value="3"/>
      <value type="int" value="4"/>
      <value type="int" value="5"/>
      <value type="int" value="6"/>
      <value type="int" value="7"/>
      <value type="int" value="8"/>
      <value type="int" value="9"/>
      <value type="int" value="10"/>
      <value type="int" value="11"/>
    </property>
  </property>
  <property name="plugins" type="empty">
    <property name="plugin-1" type="empty">
      <property name="name" type="string" value="whiskermenu"/>
    </property>
    <property name="plugin-2" type="empty">
      <property name="name" type="string" value="launcher"/>
    </property>
    <property name="plugin-3" type="empty">
      <property name="name" type="string" value="launcher"/>
    </property>
    <property name="plugin-4" type="empty">
      <property name="name" type="string" value="launcher"/>
    </property>
    <property name="plugin-5" type="empty">
      <property name="name" type="string" value="launcher"/>
    </property>
    <property name="plugin-6" type="empty">
      <property name="name" type="string" value="separator"/>
    </property>
    <property name="plugin-7" type="empty">
      <property name="name" type="string" value="tasklist"/>
    </property>
    <property name="plugin-8" type="empty">
      <property name="name" type="string" value="separator"/>
    </property>
    <property name="plugin-9" type="empty">
      <property name="name" type="string" value="systray"/>
    </property>
    <property name="plugin-10" type="empty">
      <property name="name" type="string" value="separator"/>
    </property>
    <property name="plugin-11" type="empty">
      <property name="name" type="string" value="clock"/>
    </property>
  </property>
</channel>
EOF

# 1: Whisker Menu (Start button)
cat > /home/agent/.config/xfce4/panel/whiskermenu-1.rc << 'EOF'
[whiskermenu]
button-title=Start
button-icon=start-here
show-favorites=true
show-recent=true
icon-size=3
EOF

# 2: Firefox Launcher
cat > /home/agent/.config/xfce4/panel/launcher-2.rc << 'EOF'
[launcher]
items=/usr/share/applications/firefox.desktop
EOF

# 3: Thunar Launcher
cat > /home/agent/.config/xfce4/panel/launcher-3.rc << 'EOF'
[launcher]
items=/usr/share/applications/thunar.desktop
EOF

# 4: Terminal Launcher
cat > /home/agent/.config/xfce4/panel/launcher-4.rc << 'EOF'
[launcher]
items=/usr/share/applications/xfce4-terminal.desktop
EOF

# 5: Mousepad Launcher
cat > /home/agent/.config/xfce4/panel/launcher-5.rc << 'EOF'
[launcher]
items=/usr/share/applications/mousepad.desktop
EOF

# 6: Separator
cat > /home/agent/.config/xfce4/panel/separator-6.rc << 'EOF'
[separator]
style=0
expand=false
EOF

# 7: Tasklist (window buttons)
cat > /home/agent/.config/xfce4/panel/tasklist-7.rc << 'EOF'
[tasklist]
grouping=0
show-labels=true
flat-buttons=true
show-handle=false
middle-click=close
EOF

# 8: Separator (Expanding to push items to the right)
cat > /home/agent/.config/xfce4/panel/separator-8.rc << 'EOF'
[separator]
style=0
expand=true
EOF

# 9: Systray
touch /home/agent/.config/xfce4/panel/systray-9.rc

# 10: Separator
cat > /home/agent/.config/xfce4/panel/separator-10.rc << 'EOF'
[separator]
style=0
expand=false
EOF

# 11: Clock
cat > /home/agent/.config/xfce4/panel/clock-11.rc << 'EOF'
[clock]
mode=0
show-frame=true
digital-format=%I:%M %p
EOF

chown -R agent:agent /home/agent/.config
echo "Windows 10 taskbar setup completed."
