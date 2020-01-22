#!/bin/bash

# Variáveis
ProgramasViaRepositorio=(
    sublime-text
    gimp
    whatsapp-desktop
    qbittorrent
    plank
    gitg
    zsh
    dropbox
)
    
Snaps=(
	inkscape
    spotify
    pycharm-community
    eclipse
    code
)
# Obs: precisam do --classic: pycharm, eclipse, code

ExtensoesVSCode=(
    abusaidm.html-snippets
    dracula-theme.theme-dracula
    ecmel.vscode-html-css
    emmanuelbeziat.vscode-great-icons
    felixfbecker.php-pack
    hoovercj.vscode-power-mode
    rebornix.ruby
    shd101wyy.markdown-preview-enhanced
    thekalinga.bootstrap4-vscode
    wingrunr21.vscode-ruby
)

# Diretórios
Instalacoes="$HOME/Downloads/Instalacoes"
Debs="$HOME/Downloads/Instalacoes/PontoDeb"
Outros="$HOME/Downloads/Instalacoes/Outros"
Personalizacoes="$HOME/Downloads/Instalacoes/Personalizacoes"
PontoThemes="$HOME/.themes"
PontoIcons="$HOME/.icons"

# .deb
Chrome="https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"

# .run
Xampp="https://sourceforge.net/projects/xampp/files/XAMPP%20Linux/7.4.1/xampp-linux-x64-7.4.1-0-installer.run"

# curl
ChaveRVM="--keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB"
RVM="-sSL https://get.rvm.io | bash -s stable" 

# Personalizações
TemaFlatRemix="https://github.com/daniruiz/flat-remix-gtk/archive/master.zip"
IconesFlatRemix="https://github.com/daniruiz/flat-remix/archive/master.zip"
TemaQogir="https://github.com/vinceliuice/Qogir-theme/archive/master.zip"
CursorCapitaine="https://github.com/keeferrourke/capitaine-cursors/archive/master.zip"

# INÍCIO DAS INSTALAÇÕES
echo "============================= INICIANDO INSTALAÇÕES ============================="

# Criação de diretórios
echo "============================= CRIANDO DIRETÓRIOS NECESSÁRIOS ============================="
mkdir "$Instalacoes"; mkdir "$Debs" ; mkdir "$Outros"; mkdir "$Personalizacoes"

# Instalação dos .deb
echo "============================= BAIXANDO E INSTALANDO PACOTES .DEB =============================" 
wget -c "$Chrome"   -P "$Debs"
sudo dpkg -i $Debs/*.deb

# Instalando os apt
echo "============================= INSTALANDO PROGRAMAS VIA APT =============================" 
for programa in ${ProgramasViaRepositorio[@]}; do
    if ! dpkg -l | grep -q $programa; then
        sudo apt install "$programa" -y
    else
        echo "$programa já estava instalado"
    fi
done
	
# Instalando os snaps
echo "============================= INSTALANDO PROGRAMAS VIA SNAP ============================="
sudo apt install snapd
for snap in ${Snaps[@]}; do
	if [ "$snap" == "pycharm-community" -o "$snap" == "eclipse" -o "$snap" == "code" ]; then
    	sudo snap install "$snap" --classic
	else
		sudo snap install "$snap"
	fi
done

# Xampp
wget -c "$Xampp" -O "$Outros/xampp.run"
chmod +x "$Outros/xampp.run"

# Instalação de personalizações
echo "============================= BAIXANDO TEMAS E PERSONALIZAÇÕES ============================="
wget "$TemaFlatRemix" -O "$Personalizacoes/TemaFlatRemix.zip" ; unzip "$Personalizacoes/TemaFlatRemix.zip" -d "$Personalizacoes"
wget "$TemaQogir" -O "$Personalizacoes/TemaQogir.zip" ; unzip "$Personalizacoes/TemaQogir.zip" -d "$Personalizacoes"
wget "$IconesFlatRemix" -O "$Personalizacoes/IconesFlatRemix.zip" ; unzip "$Personalizacoes/IconesFlatRemix.zip" -d "$Personalizacoes"
wget "$CursorCapitaine" -O "$Personalizacoes/CursorCapitaine.zip" ; unzip "$Personalizacoes/CursorCapitaine.zip" -d "$Personalizacoes"

cp -p -r "$Personalizacoes/flat-remix-gtk-master/Flat-Remix-GTK-Blue-Dark/" "$PontoThemes/Flat-Remix-GTK-Blue-Dark"
cd /home/testemint/Downloads/Instalacoes/Personalizacoes/Qogir-theme-master/ && sudo ./install.sh
cp -p -r "$Personalizacoes/capitaine-cursors-master/dist/" "$PontoIcons/capitaine-cursors"
cp -p -r "$Personalizacoes/flat-remix-master/Flat-Remix-Blue" "$PontoIcons/flat-remix-icons"

# Instalando extensões no VSCode 
for extensao in ${ExtensoesVSCode[@]}; do
    sudo code --user-data-dir="$HOME/.config/Code" --install-extension "$extensao"
done

# Copiando settings.json do VSCode 
rm "$HOME/.config/Code/User/settings.json"
cp "$HOME/Downloads/Pos-Instalacao-Linux-Mint/settings.json" "$HOME/.config/Code/User"

# Atualizações
#echo "============================= ATUALIZANDO SISTEMA =============================" 
sudo apt update -y ; sudo apt upgrade

echo "============================= CONSIDERAÇÕES FINAIS ============================="
echo "- Instalar Xampp com ./"
echo "- Instalar o RVM"
echo "- Configurar Oh My Zsh"
echo "- Configurar temas instalados"
echo "- Reiniciar a sessão"