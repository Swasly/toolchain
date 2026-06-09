mkdir -p ./fonts
mkdir -p ~/.local/share/fonts
cd fonts
wget https://download.jetbrains.com/fonts/JetBrainsMono-2.304.zip
unzip JetBrainsMono-2.304.zip -d ~/.local/share/
cd ../ && rm -rf fonts
