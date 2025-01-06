#!/bin/bash

sudo apt-get update
sudo apt-get full-upgrade -y
sudo apt-get install ghidra gdb ltrace strace burpsuite git wget curl aptitude \
  snapd python3-pip vim nano net-tools eog ffmpeg sleuthkit iproute2 isc-dhcp-client net-tools cifs-utils -y
wget https://download.sublimetext.com/sublime-text_build-3211_amd64.deb
sudo apt-get install ./sublime-text_build-3211_amd64.deb -y
git clone https://github.com/apogiatzis/gdb-peda-pwndbg-gef.git
sudo apt-get -y install m4 build-essential pkg-config
wget https://www.dropbox.com/scl/fi/pdfswhf3e0kfu2cfbbiml/ida-free-pc_90sp1_x64linux.run?rlkey=2hm11lfdrsd269yo6qpeq2pd0&st=z9tac4m8&dl=1
rm wget-log
mv 'ida-free-pc_90sp1_x64linux.run?rlkey=2hm11lfdrsd269yo6qpeq2pd0' ida-install.run
chmod +x ida-install.run
echo "[global]" > ~/.config/pip/pip.conf
echo "break-system-packages = true" >> ~/.config/pip/pip.conf
pip3 install pwn pycryptodome ropgadget

echo "you'll need to do this manually: curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh" > instructions.txt
echo "then do \"cargo install rsacracker\"" >> instructions.txt
echo "remember the gdb-peda-pwndbg-gef directory" >> instructions.txt
echo "also don't forget to run ./ida-install.run" >> instructions.txt
echo "maybe try out \"mv ~/ida-free-pc-9.0 ~/ida && echo \"alias ida=\"~/ida/ida\"\" >> ~/.bashrc\"" >> instructions.txt
echo "export PATH=\"$PATH:$HOME/ida\" >> ~/.bashrc" >> instructions.txt

# Define the content for the create_ida_shortcut.sh script
SHORTCUT_SCRIPT_CONTENT=$(cat <<'EOF'
#!/bin/bash

# Define the path to IDA and desktop
IDA_PATH="$HOME/ida/ida"
DESKTOP_PATH="$HOME/Desktop/ida.desktop"

# Check if the IDA file exists
if [ ! -f "$IDA_PATH" ]; then
  echo "Error: IDA executable not found at $IDA_PATH"
  exit 1
fi

# Create the .desktop file on the Desktop
cat > "$DESKTOP_PATH" <<EOL
[Desktop Entry]
Version=1.0
Name=IDA
Comment=Run IDA from anywhere
Exec=$IDA_PATH
Icon=utilities-terminal
Terminal=false
Type=Application
Categories=Development;Utility;
EOL

# Make the .desktop file executable
chmod +x "$DESKTOP_PATH"

echo "Desktop shortcut created successfully at $DESKTOP_PATH"
EOF
)

# Path to the smaller script
CREATE_SHORTCUT_SCRIPT="$HOME/ida_shortcut.sh"

# Write the content to the file
echo "$SHORTCUT_SCRIPT_CONTENT" > "$CREATE_SHORTCUT_SCRIPT"

# Make the new script executable
chmod +x "$CREATE_SHORTCUT_SCRIPT"

# Execute the newly created script
echo "Running the script to create the desktop shortcut..."
"$CREATE_SHORTCUT_SCRIPT"


