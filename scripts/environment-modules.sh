#!/bin/bash
# Modules used for environment setup script
source ../utils/bin/try-catch.sh


ERROR="ERROR"
STARTING="STARTING"
SUCCESS="SUCCESS"


function print_base_message()
{
  case $1 in
    $ERROR)
      color=$RED
    ;;
    $STARTING)
      color=$YELLOW
    ;;
    $SUCCESS)
      color=$GREEN
    ;;
  esac

  echo -e "$color>>> $1 <<<${UNCOLORED} $message"
}

function print_error_message()
{
  print_base_message $ERROR
}

function print_starting_message()
{
  print_base_message $STARTING
}

function print_success_message()
{
  print_base_message $SUCCESS
}


function update_apt_repositories()
{

  message="Update and upgrade of apt repositories"
  print_starting_message
  try
  (
    sudo apt update || throw $ERR_BAD
    sudo apt upgrade -y || throw $ERR_BAD
    sudo apt autoremove -y || throw $ERR_BAD
    print_success_message
  )
  catch || (
    print_error_message
    exit 1
  )

}

function apt_install_packages()
{
  message="Standard apt packages installation"
  print_starting_message
  try
  (
    sudo apt install acpi arandr arc-theme cloc compton docker feh firefox \
      fonts-firacode fonts-powerline git grub-customizer i3-gaps lxappearance \
      net-tools numlockx nemo npm polybar pycodestyle python3-pip screenfetch \
      tor rofi virtualenv virtualenvwrapper vim vim-airline vlc zsh \
      || throw $ERR_BAD

    sudo snap install code --classic || throw $ERR_BAD
    sudo snap install mailspring || throw $ERR_BAD

    print_success_message
  )

  catch || {
    print_error_message
    exit 1
  }
}

function node_install_packages()
{
  message="Node packages installation"
  print_starting_message
  try
  (
    npm install --global yarn || throw $ERR_BAD

    print_success_message
  )
  catch || {
    print_error_message
    exit 1
  }
}

function python_install_packages()
{
  message="Python packages installation"
  print_starting_message
  try(
    pip install virtualenvwrapper || throw $ERR_BAD

    print_success_message
  )
  catch || {
    print_error_message
    exit 1
  }
}

function create_tmp_directory()
{
  message="Create temporary installation directory"
  print_starting_message
  try
  (
    CURRENT_DIRECTORY=$(pwd)
    TMP_DIRECTORY="~/.installation_tmp"
    mkdir $TMP_DIRECTORY -pv

    print_success_message
  )
  catch || {
    print_error_message
    rm -rf $TMP_DIRECTORY
    cd $CURRENT_DIRECTORY
    exit 1
  }
}

function google_chrome_installation()
{
  message="Google Chrome installation"
  print_starting_message
  try
  (
    cd $TMP_DIRECTORY || throw $ERR_BAD
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb \
    throw $ERR_BAD
    sudo dpkg -i google-chrome-stable_current_amd64.deb || throw $ERR_BAD
    cd $CURRENT_DIRECTORY || throw $ERR_BAD

    print_success_message
  )
  catch || {
    print_error_message
    exit 1
  }
}

function nordvpn_installation()
{
  message="NordVPN installation"
  print_starting_message
  try
  (
    sudo wget -qnc \
      https://repo.nordvpn.com/deb/nordvpn/debian/pool/main/nordvpn-release_1.0.0_all.deb \
      || throw $ERR_BAD
    sudo dpkg -i nordvpn-release_1.0.0_all.deb  || throw $ERR_BAD

    sudo apt update || throw $ERR_BAD
    sudo apt install nordvpn || $ERR_BAD

    nordvpn whitelist add subnet 192.168.0.0/24 || throw $ERR_BAD
    nordvpn set autoconnect enabled Netherlands || throw $ERR_BAD

    print_success_message
  )
  catch || {
    print_error_message
    exit 1
  }
}

function oh-my-zsh_installation()
{
  sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k
}

function signal_messenger_installation()
{
  message="Signal Messenger installation"
  print_starting_message
  try
  (
    curl -s https://updates.signal.org/desktop/apt/keys.asc \
      | sudo apt-key add - || throw $ERR_BAD
    echo "deb [arch=amd64] https://updates.signal.org/desktop/apt xenial main" \
      | sudo tee -a /etc/apt/sources.list.d/signal-xenial.list \
      || throw $ERR_BAD
    sudo apt update && sudo apt install signal-desktop || throw $ERR_BAD

    print_success_message
  )
  catch || {
    print_error_message
    exit 1
  }
}

function star_uml_installation()
{
  message="Star UML installation"
  print_starting_message
  try
  (
    cd $TMP_DIRECTORY || throw $ERR_BAD
    wget https://staruml.io/download/releases-v5/StarUML_5.0.1_amd64.deb \
      || throw $ERR_BAD  # TODO: Fetch last version
    sudo dpkg -i StarUML_5.0.1_amd64.deb || throw $ERR_BAD

    print_success_message
  )
  catch || {
    print_error_message
    exit 1
  }
}

function docker_setup()
{
  message="Docker and docker-compose setup"
  print_starting_message
  try
  (
    bash install-latest-docker-compose.sh || throw $ERR_BAD
    sudo groupadd docker || throw $ERR_BAD
    sudo usermod -aG docker $USER || throw $ERR_BAD
    newgrp docker || throw $ERR_BAD

    print_success_message
  )
  catch || {
    print_error_message
    exit 1
  }
}

function firefox_profile_setup()
{
  message="Firefox profiles setup"
  print_starting_message
  try
  (
    cp $CURRENT_DIRECTORY/firefox/* ~/.local/bin/ -v || throw $ERR_BAD
    chmod +x ~/.local/bin/* || throw $ERR_BAD

    print_success_message
  )
  catch || {
    print_error_message
    exit 1
  }
}

function fonts_setup()
{
  message="Fonts setup"
  print_starting_message
  try
  (
    cp $CURRENT_DIRECTORY/fonts/* ~/.fonts/ -rv || throw $ERR_BAD

    print_success_message
  )
  catch || {
    print_error_message
    exit 1
  }
}

function git_setup()
{
  message="Git configurations setup"
  print_starting_message
  try
  (
    cp $CURRENT_DIRECTORY/git/.gitconfig ~/ -v || throw $ERR_BAD

    print_success_message
  )
  catch || {
    print_error_message
    exit 1
  }
}

function nemo_setup()
{
  message="Nemo file explorer setup"
  print_starting_message
  try
  (
    xdg-mime default nemo.desktop inode/directory \
      application/x-gnome-saved-search || throw $ERR_BAD
    gsettings set org.gnome.desktop.background show-desktop-icons false \
      || throw $ERR_BAD
    gsettings set org.nemo.desktop show-desktop-icons true || throw $ERR_BAD
    xdg-open $HOME || throw $ERR_BAD
  )
  catch || {
    print_error_message
    exit 1
  }
}

function polybar_setup()
{
  message="Polybar setup"
  print_starting_message
  try
  (
    cp $CURRENT_DIRECTORY/polybar/* ~/.config/polybar/ -rv || throw $ERR_BAD
    chmod +x ~/.config/polybar/* || throw $ERR_BAD

    print_success_message
  )
  catch || {
    print_error_message
    exit 1
  }
}

function touchpad_setup()
{
  message="Touchpad tap-to-click setup"
  print_starting_message
  try
  (
    gsettings set org.gnome.desktop.peripherals.touchpad natural-scroll true \
      throw $ERR_BAD

    print_success_message
  )
  catch || {
    print_error_message
    exit 1
  }
}

function vim_setup()
{
  message="Vim setup"
  print_starting_message
  try
  (
    cp $CURRENT_DIRECTORY/vim/.vimrc ~/ -v || throw $ERR_BAD
    vim +PlugInstall  # TODO: Make it quite

    print_success_message
  )
  catch || {
    print_error_message
    exit 1
  }
}

function xrandr_setup()
{
  message="Xrandr setup"
  print_starting_message
  try
  (
    cp $CURRENT_DIRECTORY/screenlayout/main.sh ~/.screenlayout/ -rv \
     || throw $ERR_BAD

    print_success_message
  )
  catch || {
    print_error_message
    exit 1
  }
}

function xresources_setup()
{
  message="Xresources setup"
  print_starting_message
  try
  (
    cp $CURRENT_DIRECTORY/Xresources/.Xresources ~/ -v || throw $ERR_BAD

    print_success_message
  )
  catch || {
    print_error_message
    exit 1
  }
}

function zsh_complete_setup()
{
  message="zsh oh-my-zsh powerlevel10k stack installation and setup"
  print_starting_message
  try(
    chsh -s $(which zsh) || throw $ERR_BAD
    cp $CURRENT_DIRECTORY/zsh/.zshrc ~/ -v || throw $ERR_BAD
    oh-my-zsh_installation || throw $ERR_BAD
    cp $CURRENT_DIRECTORY/zsh/.p10k.zsh ~/ -v || throw $ERR_BAD
    sed "s/# env_default 'LESS' '-R'/env_default 'LESS' '-FRSX'" \
      ~/.oh-my-zsh/lib/misc/zsh || throw $ERR_BAD

    print_success_message
  )
  catch || {
    print_error_message
    exit 1
  }
}
