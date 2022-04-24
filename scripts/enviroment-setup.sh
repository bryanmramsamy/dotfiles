#!/bin/bash
# Main environment setup bash script
source ../bin/environment-modules.sh
source ../bin/utils/terminal-colors.sh
source ../bin/utils/try-catch.sh


export hostname=$(hostname)
export message="Installation process"
print_starting_message
try
(
  update_apt_repositories || throw $ERR_CRITICAL
  apt_install_packages
  node_install_packages
  python_install_packages

  create_tmp_directory || throw $ERR_CRITICAL
  google_chrome_installation
  nordvpn_installation
  signal_messenger_installation

  print_success_message

  export message="Setup process"
  print_starting_message

  fonts_setup
  polybar_setup
  touchpad_setup
  vim_setup
  xrandr_setup
  xresources_setup

  docker_setup
  firefox_profile_setup
  git_setup
  nemo_setup
  zsh_complete_setup

  print_success_message
)
catch || {
  exit 1
}
