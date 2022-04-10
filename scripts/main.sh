#!/bin/bash
source ./try-catch.sh
source ./terminal-colors.sh


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

    echo -e "$color>>> $1 <<<${NO} $message"
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


message="Update and upgrade of apt repositories"
print_starting_message
try
(
    sudo apt update || throw $ERR_BAD
    sudo apt upgrade -y || throw $ERR_BAD
    sudo apt autoremove -y || throw $ERR_BAD
    print_success_message


    message="Standard apt packages installation"
    print_starting_message
    try
    (
        sudo apt install acpi arandr arc-theme cloc compton docker feh font-powerline git grub-customizer i3-gaps lxappearance net-tools numlockx nemo polybar python3-pip screenfetch rofi virtualenv virtualenvwrapper vim vim-airline vlc zsh || throw $ERR_BAD

        sudo snap install code --classic || throw $ERR_BAD
        sudo snap install mailspring || throw $ERR_BAD

        print_success_message
    )

    catch || {
        print_error_message
    }
)

catch || (
    print_error_message
    exit 1
)

