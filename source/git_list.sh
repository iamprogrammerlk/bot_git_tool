#!/bin/bash

clear

# bash debug on
set -euo pipefail

export APP_NAME="Bot GIT Tool - GIT List"
export APP_SHORT_NAME="GIT List"
export APP_SLUG="git_list"
export APP_VERSION="25.10.00"
# export APP_ROOT=$(pwd)
# export APP_ROOT=$(dirname "$0")
# These method ensure you get the directory of the script, even if it's executed from a different location.
# this option is more robust handling of symbolic links.
export APP_ROOT=$(dirname "$(realpath "$0")")
export APP_PARENT_HOME="$HOME/.config/bot_git_tool"
export APP_HOME="$APP_PARENT_HOME/$APP_SLUG"

declare -A app_configuration=(
  ["app_url"]="https://iamprogrammer.lk/bot_git_tool"
  ["app_license"]="Open Software License (OSL) v3.0 License"
  ["app_license_url"]="https://github.com/iamprogrammerlk/bot_git_tool?tab=OSL-3.0-1-ov-file"
  ["app_author"]="I am Programmer"
  ["app_author_url"]="https://iamprogrammer.lk"
)

cd "$HOME"
if [ ! -d "$APP_PARENT_HOME" ]; then
  mkdir "$APP_PARENT_HOME"
fi

cd "$HOME"
if [ ! -d "$APP_HOME" ]; then
  mkdir "$APP_HOME"
fi

if [ ! -f "$APP_ROOT/prettybash/source/config.sh" ]; then
  echo "Runtime Error : '/prettybash/source/config.sh' is require to run '$APP_NAME'." >&2
  echo ""
  exit 1
fi
. $APP_ROOT/prettybash/source/config.sh

if [ ! -f "$APP_ROOT/prettybash/source/utility.sh" ]; then
  echo "Runtime Error : '/prettybash/source/utility.sh' is require to run '$APP_NAME'." >&2
  echo ""
  exit 1
fi
. $APP_ROOT/prettybash/source/utility.sh

if [ ! -f "$APP_ROOT/prettybash/source/style.sh" ]; then
  echo "Runtime Error : '/prettybash/source/style.sh' is require to run '$APP_NAME'." >&2
  echo ""
  exit 1
fi
. $APP_ROOT/prettybash/source/style.sh

if [ ! -f "$APP_ROOT/prettybash/source/ui.sh" ]; then
  echo "Runtime Error : '/prettybash/source/ui.sh' is require to run '$APP_NAME'." >&2
  echo ""
  exit 1
fi
. $APP_ROOT/prettybash/source/ui.sh

# show_app_header ------------------------------------------------------------------------------------------------------
show_app_header()
{
  declare -a header_title=(
    "style_foreground_blue"
    "ui_message_box_text_align_center"
    "$APP_NAME v$APP_VERSION"
  )
  ui_message_box "${header_title[@]}"
}

# show_app_footer ------------------------------------------------------------------------------------------------------
show_app_footer()
{
  declare -a footer_title=(
    "style_foreground_gray"
    "ui_message_box_text_align_center"
    "Thank you!"
    "ui_message_box_text_align_left"
    "     Developer : ${app_configuration["app_author"]} [${app_configuration["app_author_url"]}]"
    "       License : ${app_configuration["app_license"]}"
    "   License URL : ${app_configuration["app_license_url"]}"
    "       Version : $APP_VERSION"
    " Documentation : https://iamprogrammer.lk/bot_git_tool"
  )
  ui_message_box "${footer_title[@]}"
}

create_app_setting_conf()
{
  if [ -z ${1+x} ]; then
    echo "Runtime Error : Invalid argument. 'create_app_setting_conf() <STRING_FILE_PATH>'" >&2
    exit 1
  fi

  if [ ! -f "$1" ]; then
    declare -A default_app_setting
    default_app_setting["app_name"]="$APP_NAME"
    default_app_setting["app_short_name"]="$APP_SHORT_NAME"
    default_app_setting["app_slug"]="$APP_SLUG"
    default_app_setting["app_version"]="$APP_VERSION"
    default_app_setting["filtered_by"]=".git"
    default_app_setting["gitconfig_path"]="$HOME/.gitconfig"
    set_config "$1" "default_app_setting"
  fi
}

create_root_directory_conf()
{
  if [ -z ${1+x} ]; then
    echo "Runtime Error : Invalid argument. 'create_root_directory() <STRING_FILE_PATH>'" >&2
    exit 1
  fi

  if [ ! -f "$1" ]; then
    declare -a default_root_directory
    default_root_directory=(
      "#"
      "# List all directory absolute paths, one per line."
      "#"
      "$HOME"
    )
    set_config_list "$1" "default_root_directory"
    msg_01="You are launching the '$APP_SHORT_NAME' for the first time. Kindly modify"
    msg_02="the '$1' file according to your preferences."
    style_foreground_purple_bold "$msg_01"
    new_line
    style_foreground_purple_bold "$msg_02"
    new_line
    empty_line
    # Copy git_list.sh to user bin to run anywhere in the system
    if [ ! -f "/usr/local/bin/gitlist" ]; then
      echo "Please enter your user password to continue:"
      script_name=$(basename "$(realpath "${BASH_SOURCE[0]}")")
      sudo ln -s "$APP_ROOT/$script_name" /usr/local/bin/gitlist
      empty_line
    fi
  fi
}

create_git_config_conf()
{
  if [ -z ${1+x} ]; then
    echo "Runtime Error : Invalid argument. 'create_gitconfig_conf() <STRING>'" >&2
    exit 1
  fi

  if [ ! -f "$1" ]; then

heredoc=$(cat <<EOF
# This file is created by "$APP_SHORT_NAME - $APP_VERSION"
#
# Add all your global 'git' configurations in '$1'.
# '$APP_SHORT_NAME' will include it in to your '$HOME/.gitconfig' file's header section automatically.
# Do not edit '$HOME/.gitconfig' file directly.
# '$HOME/.gitconfig' will overwritten by the '$APP_SHORT_NAME' when every time it runs.
#
#
# Configs from the '$1'
#
#
[pull]
  rebase = false
#
[init]
  defaultBranch = main
#
[safe]
  directory = /opt/flutter
#
#
# Configs generated by the '$APP_SHORT_NAME'
#
#
EOF
)

  echo "$heredoc" > "$1"
  fi
}

set_directory_to_scan(){
  if [ -z ${1+x} ]; then
    echo "Runtime Error : Invalid argument. 'set_directory_to_scan() <ARRAY>'" >&2
    exit 1
  fi
  local -n array_reference="$1"

  echo "$(style_foreground_green "Loading Config File:") $(style_foreground_brown "$root_directory_conf")"
  new_line
  for directory_path in "${root_directory[@]}";
  do
    if [ ! -d "$directory_path" ]; then
      echo "Directory $(style_foreground_red "$directory_path") is not found."
      continue
    fi
      echo "Adding directory path $(style_foreground_green "$directory_path") to scan."
      array_reference+=("$directory_path")
  done
  new_line
  # sort root directories alphabetically
  IFS=$'\n' array_reference=($(printf "%s\n" "${array_reference[@]}" | LC_ALL=C sort -f))
  unset IFS
  total_root_directory=${#array_reference[@]}
  echo "Found a total of $(style_foreground_purple "$total_root_directory") directory paths to scan."
  new_line
}

set_gitconfig_header(){
  # Read the default gitconfig data from $APP_HOME/git_config.conf
  if [[ ! -f "$git_config_conf" ]]; then
      echo "Error: File '$git_config_conf' not found." >&2
      exit 1
  fi
  IFS= read -r -d '' git_config_conf_content < "$git_config_conf" || true
  # Write it in to header section of #HOME/.gitconfig
  echo "$git_config_conf_content" > "${app_setting["gitconfig_path"]}"
}

show_app_header
empty_line

declare -A app_setting
app_setting_conf="$APP_HOME/app_setting.conf"
create_app_setting_conf "$app_setting_conf"
get_config "$app_setting_conf" "app_setting"

declare -a root_directory
root_directory_conf="$APP_HOME/root_directory.conf"
create_root_directory_conf "$root_directory_conf"
get_config_list "$root_directory_conf" "root_directory"

git_config_conf="$APP_HOME/git_config.conf"
create_git_config_conf "$git_config_conf"

declare -a directory_to_scan
set_directory_to_scan "directory_to_scan"

set_gitconfig_header

for current_root_directory in "${directory_to_scan[@]}"
do
  echo "#" >> "${app_setting["gitconfig_path"]}"
  echo "# $current_root_directory" >> "${app_setting["gitconfig_path"]}"
  echo "#" >> "${app_setting["gitconfig_path"]}"

  repository_path=()
  # get the $filtered_by directories
  readarray -d '' directory_list < <(find $current_root_directory -name ${app_setting["filtered_by"]} -type d)
  # trim the tailing $filtered_by then add it to $repository_path
  for current_directory in ${directory_list[@]}; do
    repository_path+=(${current_directory%/${app_setting["filtered_by"]}})
  done
  # sort alphabetically
  IFS=$'\n' repository_path=($(printf "%s\n" "${repository_path[@]}" | LC_ALL=C sort -f))
  unset IFS
  echo -n "$(style_foreground_green "Root Directory:") $(style_foreground_brown "$current_root_directory")"
  new_line
  total_repository=${#repository_path[@]}
  echo -n "Containing a total of $(style_foreground_purple "$total_repository") GIT repositories."
  new_line
  empty_line
  for directory in ${repository_path[@]}; do
    echo "$directory"
    echo "	directory = $directory" >> "${app_setting["gitconfig_path"]}"
  done
  empty_line
done

show_app_footer
empty_line
