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
    </property>
  </property>
</channel>
EOF

# Whisker Menu (Start button)
cat > /home/agent/.config/xfce4/panel/whiskermenu-1.rc << 'EOF'
[whiskermenu]
button-title=Start
button-icon=start-here
show-favorites=true
show-recent=true
icon-size=3
EOF

# Tasklist (window buttons)
cat > /home/agent/.config/xfce4/panel/tasklist-2.rc << 'EOF'
[tasklist]
grouping=0
show-labels=true
flat-buttons=true
show-handle=false
middle-click=close
EOF

# Separator
touch /home/agent/.config/xfce4/panel/separator-3.rc

# Systray
touch /home/agent/.config/xfce4/panel/systray-4.rc

# Separator
touch /home/agent/.config/xfce4/panel/separator-5.rc

# Clock
cat > /home/agent/.config/xfce4/panel/clock-6.rc << 'EOF'
[clock]
mode=0
show-frame=true
digital-format=%I:%M %p
EOF

chown -R agent:agent /home/agent/.config
echo "Windows 10 taskbar setup completed."