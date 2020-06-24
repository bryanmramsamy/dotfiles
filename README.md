# Dotfiles for Ubuntu 20.04 LTS Focal

## Prerequisites

### Basic dependencies

- acpi
- code
- compton
- feh
- git
- grub-customizer
- i3
- lxappearance
- mailspring
- net-tools
- numlockx
- nemo
- python3-pip
- rofi
- vim
- vlc
- whatsdesk
- zsh

```bash
sudo apt install acpi git vim i3 zsh rofi compton python3-pip lxappearance nemo feh numlockx vlc net-tools grub-customizer

sudo snap install code --classic
sudo snap install mailspring whatsdesk
```

#### Docker

```bash
sudo apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common
```

#### Google chrome

```bash
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
```

#### i3-gaps

```bash
sudo apt install libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev libxcb-icccm4-dev libyajl-dev libstartup-notification0-dev libxcb-randr0-dev libev-dev libxcb-cursor-dev libxcb-xinerama0-dev libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev autoconf xutils-dev libtool automake libxcb-shape0-dev
```

### lxappearance

```bash
sudo apt install arc-theme
```

#### Polybar

```bash
sudo apt-get install cmake cmake-data libcairo2-dev libxcb1-dev libxcb-ewmh-dev libxcb-icccm4-dev libxcb-image0-dev libxcb-randr0-dev libxcb-util0-dev libxcb-xkb-dev pkg-config python3-xcbgen xcb-proto libxcb-xrm-dev i3-wm libasound2-dev libmpdclient-dev libiw-dev libcurl4-openssl-dev libpulse-dev libxcb-composite0-dev xcb libxcb-ewmh2 libjsoncpp-dev fonts-font-awesome
```

#### Tor Browser

```bash
sudo add-apt-repository ppa:micahflee/ppa

sudo apt update
sudo apt install torbrowser-launcher
```

## Installations

### Docker and Docker-compose

```bash
sudo apt-get update

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io
apt-cache madison docker-ce
sudo docker run hello-world

sudo curl -L "https://github.com/docker/compose/releases/download/1.26.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/r-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose --version
```

### Firefox profiles

Files/folders to move:

- `.local/bin/Firefox-CHARLIE` -> `home/.local/bin/Firefox-CHARLIE`
- `.local/bin/Firefox-DELTA` -> `home/.local/bin/Firefox-DELTA`

```bash
chmod +x .local/bin/Firefox-*
```

### i3-gaps

```bash
mkdir tmp
cd tmp
git clone https://github.com/Airblader/xcb-util-xrm
cd xcb-util-xrm
git submodule update --init
./autogen.sh --prefix=/usr
make
sudo make install

cd ..

git clone https://www.github.com/Airblader/i3 i3-gaps
cd i3-gaps
git checkout gaps && git pull
autoreconf --force --install
rm -rf build
mkdir build
cd build
../configure --prefix=/usr --sysconfdir=/etc --disable-sanitizers
make
sudo make install
```

### lxappearance

```bash
git clone https://github.com/horst3180/arc-icon-theme --depth 1 && cd arc-icon-theme
./autogen.sh --prefix=/usr
sudo make install
```

### Oh My Zsh and powerlevel10k

```bash
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k
```

Files/folders to move:

- `.fonts/` -> `home/`
- `.zshrc` -> `home/`
- `.p10k.zsh` -> `home/`

### Mailspring

```bash
git clone git@github.com:mjohnson8165/mailspring-arc-dark.git
```

Install the Arc Dark Theme

### Nemo

```bash
xdg-mime default nemo.desktop inode/directory application/x-gnome-saved-search
gsettings set org.gnome.desktop.background show-desktop-icons false
gsettings set org.nemo.desktop show-desktop-icons true
xdg-open $HOME
```

### NordVPN

```bash
sudo wget -qnc https://repo.nordvpn.com/deb/nordvpn/debian/pool/main/nordvpn-release_1.0.0_all.deb
sudo dpkg -i nordvpn-release_1.0.0_all.deb

sudo apt update
sudo apt install nordvpn

nordvpn login
```

### Polybar

Files/folders to move:

- `.config/polybar/config` -> `home/.config/polybar/config`

```bash
chmod +x $HOME/.config/polybar/launch.sh
```

### Rofi

Files/folders to move:

- `.fonts/` -> `home/`

```bash
xrdb ~/.Xresources  
```

### Touchpad tap-to-click

```bash
sudo mkdir -p /etc/X11/xorg.conf.d && sudo tee <<'EOF' /etc/X11/xorg.conf.d/90-touchpad.conf 1> /dev/null
Section "InputClass"
        Identifier "touchpad"
        MatchIsTouchpad "on"
        Driver "libinput"
        Option "Tapping" "on"
        Option "NaturalScrolling" "on"
EndSection

EOF
```

## Sources

### i3 rice

- **i3wm** by *Code Cast* :

  - (YouTube) <https://www.youtube.com/watch?v=j1I63wGcvU4&list=PL5ze0DjYv5DbCv9vNEzFmP6sU7ZmkGzcf>

  - (GitHub) <https://github.com/alexbooker>

### Polybar

- **Tutoriel Unix/i3wm : Configuration d'i3wm** (French) by *Grafikart.fr* :

  - (YouTube) <https://www.youtube.com/watch?v=oHbJK6r2Xwo>

- **Let's Linux** by *budlabs* :

  - (YouTube) <https://www.youtube.com/watch?v=7RNgpvBMua0&list=PLt6-rPpOpkb3XKwdUoLtUhCqkMbyqomba>

  - (GitHub) <https://github.com/budlabs/youtube>

### SSH and GPG keys

- **Generating a new SSH key pair** by *GitLab* :
  - <https://gitlab.com/help/ssh/README#generating-a-new-ssh-key-pair>

- **Signing commits with GPG** vy *GitLab* :
  - <https://gitlab.com/help/user/project/repository/gpg_signed_commits/index.md>
