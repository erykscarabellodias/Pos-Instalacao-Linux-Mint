#!/bin/bash

# Variáveis
ProgramasViaRepositorio=(
    sublime-text
    gimp
    whatsapp-desktop
    qbittorrent
    plank
    snapd
    gitg
    zsh
)

Snaps=(
    inkscape
    spotify
    pycharm-community --classic
    eclipse --classic
)

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
VSCode="https://go.microsoft.com/fwlink/?LinkID=760868"
Dropbox="https://linux.dropbox.com/packages/ubuntu/dropbox_2019.02.14_amd64.deb"

# .run
VirtualBox="https://download.oracle.com/virtualbox/6.0.14/VirtualBox-6.0.14-133895-Linux_amd64.run"
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
wget -c "$VSCode"   -P "$Debs"
wget -c "$Dropbox"  -P "$Debs"

sudo dpkg -i $Debs/*.deb

# Instalando os apt
echo "============================= INSTALANDO PROGRAMAS VIA APT ============================="
for programa in ${ProgramasViaRepositorio[@]}; do
    if ! dpkg -l | grep -q $programa; then
        apt install "$programa" -y
    else
        echo "$programa já estava instalado"
    fi
done

# Instalando os snaps
echo "============================= INSTALANDO PROGRAMAS VIA SNAP ============================="
for snap in ${Snaps[@]}; do
    sudo snap install "$snap"
done

echo "============================= INSTALANDO PROGRAMAS OUTROS PROGRAMAS ============================="
# Virtual Box
wget -c "$VirtualBox" -P "$Outros"
chmod +x "$Outros/virtualbox.run"
cd "$Outros"
sudo .virtualbox.run

# RVM, Ruby e Rails
gpg "$ChaveRVM"
\curl "$RVM"
source ~/.rvm/scripts/rvm
rvm install 2.6.3

# Xampp
wget -c "$Xampp" -O "$Outros/xampp.run"
chmod +x "$Outros/xampp.run"

# Instalação de personalizações
echo "============================= BAIXANDO TEMAS E PERSONALIZAÇÕES ============================="
wget "$TemaFlatRemix" -O "$Personalizacoes/TemaFlatRemix.zip" ; unzip "$Personalizacoes/emaFlatRemix.zip" -d "$Personalizacoes"
wget "$TemaQogir" -O "$Personalizacoes/TemaQogir.zip" ; unzip "$Personalizacoes/emaQogir.zip" -d "$Personalizacoes"
wget "$IconesFlatRemix" -O "$Personalizacoes/IconesFlatRemix.zip" ; unzip "$Personalizacoes/conesFlatRemix.zip" -d "$Personalizacoes"
wget "$CursorCapitaine" -O "$Personalizacoes/CursorCapitaine.zip" ; unzip "$Personalizacoes/ursorCapitaine.zip" -d "$Personalizacoes"

cp -pr "$Personalizacoes/flat-remix-gtk-master/Flat-Remix-GTK-Blue-Dark/" "$PontoThemes/lat-Remix-GTK-Blue-Dark"
cp -pr "$Personalizacoes/Qogir-theme-master/src" "$PontoThemes/Qogir-theme"
cp -pr "$Personalizacoes/capitaine-cursors-master/dist/" "$PontoIcons/capitaine-cursors"
cp -pr "$Personalizacoes/flat-remix-master/Flat-Remix-Blue" "$PontoIcons/flat-remix-icons"

# Instalando extensões no VSCode
for extensao in ${ExtensoesVSCode[@]}; do
    sudo code --user-data-dir="$HOME/.config/Code" --install-extension "$extensao"
done

# Definindo ZSH como shell padrão e instalando Oh My Zsh
sudo chsh -s $(which zsh)
sh -c " $ ( wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh ) "

# Copiando settings.json do VSCode
rm "$HOME/.config/Code/User/settings.json"
cp "$HOME/Downloads/Pos-Instalacao-Linux-Mint/settings.json" "$HOME/.config/Code/User"

# Atualizações
echo "============================= ATUALIZANDO SISTEMA ============================="
sudo apt update -y ; sudo apt upgrade

echo "============================= CONSIDERAÇÕES FINAIS ============================="
echo "- Instalar Xampp com ./"
echo "- Configurar temas instalados"