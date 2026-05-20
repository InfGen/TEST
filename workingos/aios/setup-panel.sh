#!/bin/sh
echo "Setting up Windows 10 style taskbar..."

mkdir -p /home/agent/.config/xfce4/xfconf/xfce-perchannel-xml
mkdir -p /home/agent/.config/xfce4/panel

# Force Windows 10 style bottom panel
cat > /home/agent/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<channel name="xfce4-panel" version="1.0">
  <property name="configver" type="int" value="2"/>
  <property name="panels" type="array">
    <value type="int" value="1"/>
  </property>
  <property name="panel-1" type="empty">
    <property name="position" type="string" value="p=6;x=0;y=0"/>
    <property name="length" type="double" value="100"/>
    <property name="size" type="uint" value="42"/>
    <property name="background-style" type="uint" value="0"/>
    <property name="background-rgba" type="string" value="#001f3dff"/>
    <property name="plugin-ids" type="array">
      <value type="int" value="1"/> <!-- Whisker Menu (Start) -->
      <value type="int" value="2"/> <!-- Tasklist -->
      <value type="int" value="3"/> <!-- Spacer -->
      <value type="int" value="4"/> <!-- Systray -->
      <value type="int" value="5"/> <!-- Clock -->
    </property>
  </property>
</channel>
EOF

cat > /home/agent/.config/xfce4/panel/whiskermenu-1.rc << 'EOF'
[whiskermenu]
button-title=Start
button-icon=go-home
show-favorites=true
show-recent=true
icon-size=3
EOF

chown -R agent:agent /home/agent/.config
echo "Windows 10 taskbar setup completed."
