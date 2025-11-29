#!/bin/bash

clear

# bash debug on
set -euo pipefail

export APP_NAME="PrettyBash Template Demo"
export APP_SLUG="prettybash_template_demo"
export APP_VERSION="25.10.0"
# export APP_ROOT=$(pwd)
# export APP_ROOT=$(dirname "$0")
# These method ensure you get the directory of the script, even if it's executed from a different location.
# this option is more robust handling of symbolic links.
export APP_ROOT=$(dirname "$(realpath "$0")")
export APP_HOME=$HOME/.config/$APP_SLUG

declare -A app_configuration=(
  ["app_url"]="https://github.com/prettybash/template"
  ["app_license"]="Open Software License (OSL) v3.0 License"
  ["app_license_url"]="https://github.com/prettybash/template?tab=OSL-3.0-1-ov-file"
  ["app_author"]="I am Programmer"
  ["app_author_url"]="https://iamprogrammer.lk"
)

demo_string_to_be_format="This string formatting is applied by calling the function "

cd $HOME
if [ ! -d "$APP_HOME" ]; then
  mkdir "$APP_HOME"
fi

echo $APP_ROOT

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
    "   Developer : ${app_configuration["app_author"]} [${app_configuration["app_author_url"]}]"
    "     License : ${app_configuration["app_license"]}"
    " License URL : ${app_configuration["app_license_url"]}"
    "     Version : $APP_VERSION"
  )
  ui_message_box "${footer_title[@]}"
}

# demo_style_text_format -----------------------------------------------------------------------------------------------
demo_style_text_format(){
  style_normal "$demo_string_to_be_format style_normal"
  new_line
  style_bold "$demo_string_to_be_format style_bold"
  new_line
  style_italic "$demo_string_to_be_format style_italic"
  new_line
  style_underline "$demo_string_to_be_format style_underline"
  new_line
  style_blinking "$demo_string_to_be_format style_blinking"
  new_line
  style_reverse_video "$demo_string_to_be_format style_reverse_video"
  new_line
}

# demo_style_text_foreground -------------------------------------------------------------------------------------------
demo_style_text_foreground(){
  style_foreground_black "$demo_string_to_be_format style_foreground_black"
  new_line
  style_foreground_blue "$demo_string_to_be_format style_foreground_blue"
  new_line
  style_foreground_blue_bold "$demo_string_to_be_format style_foreground_blue_bold"
  new_line
  style_foreground_brown "$demo_string_to_be_format style_foreground_brown"
  new_line
  style_foreground_brown_bold "$demo_string_to_be_format style_foreground_brown_bold"
  new_line
  style_foreground_cyan "$demo_string_to_be_format style_foreground_cyan"
  new_line
  style_foreground_cyan_bold "$demo_string_to_be_format style_foreground_cyan_bold"
  new_line
  style_foreground_gray "$demo_string_to_be_format style_foreground_gray"
  new_line
  style_foreground_gray_bold "$demo_string_to_be_format style_foreground_gray_bold"
  new_line
  style_foreground_green "$demo_string_to_be_format style_foreground_green"
  new_line
  style_foreground_green_bold "$demo_string_to_be_format style_foreground_green_bold"
  new_line
  style_foreground_purple "$demo_string_to_be_format style_foreground_purple"
  new_line
  style_foreground_purple_bold "$demo_string_to_be_format style_foreground_purple_bold"
  new_line
  style_foreground_red "$demo_string_to_be_format style_foreground_red"
  new_line
  style_foreground_red_bold "$demo_string_to_be_format style_foreground_red_bold"
  new_line
  style_foreground_white "$demo_string_to_be_format style_foreground_white"
  new_line
}

# demo_style_text_background -------------------------------------------------------------------------------------------
demo_style_text_background(){
  style_background_black "$demo_string_to_be_format style_background_black"
  new_line
  style_background_blue "$demo_string_to_be_format style_background_blue"
  new_line
  style_background_blue_bold "$demo_string_to_be_format style_background_blue_bold"
  new_line
  style_background_brown "$demo_string_to_be_format style_background_brown"
  new_line
  style_background_brown_bold "$demo_string_to_be_format style_background_brown_bold"
  new_line
  style_background_cyan "$demo_string_to_be_format style_background_cyan"
  new_line
  style_background_cyan_bold "$demo_string_to_be_format style_background_cyan_bold"
  new_line
  style_background_gray "$demo_string_to_be_format style_background_gray"
  new_line
  style_background_gray_bold "$demo_string_to_be_format style_background_gray_bold"
  new_line
  style_background_green "$demo_string_to_be_format style_background_green"
  new_line
  style_background_green_bold "$demo_string_to_be_format style_background_green_bold"
  new_line
  style_background_purple "$demo_string_to_be_format style_background_purple"
  new_line
  style_background_purple_bold "$demo_string_to_be_format style_background_purple_bold"
  new_line
  style_background_red "$demo_string_to_be_format style_background_red"
  new_line
  style_background_red_bold "$demo_string_to_be_format style_background_red_bold"
  new_line
  style_background_white "$demo_string_to_be_format style_background_white"
  new_line
}

# demo_style_combine_use_case ------------------------------------------------------------------------------------------
demo_style_combine_use_case()
{
  echo -n "$(style_blinking "<<-- SAMPLE -->>") Mix the Foreground Color $(style_foreground_brown "Brown") with the "
  echo -n "$(style_foreground_brown_bold "Brown Bold") and Background Color $(style_background_purple " Purple ") on "
  echo "$(style_reverse_video "$(style_underline " BASH ")")"
  # No 'new_line' need here, becurse last 'echo' don't have '-n' flag
}

# demo_ui_message_box --------------------------------------------------------------------------------------------------
demo_ui_message_box()
{
  #  default title with default options
  ui_message_box
  empty_line

  #  default title with custom color options
  ui_message_box "style_foreground_blue"
  empty_line

  #  default title with custom text alignment options
  ui_message_box "ui_message_box_text_align_left"
  empty_line

  ui_message_box "Custom title with default options"
  empty_line

  ui_message_box "style_foreground_blue" "Custom title with custom color options"
  empty_line

  options=(
    "style_foreground_green"
    "ui_message_box_text_align_left"
    "Custom title with custom color and text align options"
  )
  ui_message_box "${options[@]}"
  empty_line

  options=(
    "style_foreground_green"
    "ui_message_box_text_align_left"
    "Custom title with custom color,text align and content options"
    "after this, all arguments"
    "Will"
    "Be"
    "The Content"
  )
  ui_message_box "${options[@]}"
  empty_line

  options=(
    "style_background_cyan_bold"
    "ui_message_box_text_align_center"
    "Custom title with custom color, text align and content, align options"
    "ui_message_box_text_align_left"
    "after this, all arguments"
    "Will"
    "Be"
    "The Content"
  )
  ui_message_box "${options[@]}"
  empty_line
}

# demo_config_list -----------------------------------------------------------------------------------------------------
demo_config_list()
{
  setting_list_file="$APP_HOME/setting_list.conf"

  # Setting new list of configurations
  echo "Setting new configs to '$setting_list_file'"
  setting_list_array=(
    "$APP_NAME"
    "$APP_SLUG"
    "$APP_VERSION"
    )
  set_config_list "$setting_list_file" "setting_list_array"

  empty_line

  # Getting newly created list of configurations
  echo "Getting new configs from '$setting_list_file'"
  declare -a setting_list_data
  get_config_list "$setting_list_file" "setting_list_data"
  for element in "${setting_list_data[@]}"
  do
    echo "$element"
  done
}

# demo_config_key_value ------------------------------------------------------------------------------------------------
demo_config_key_value()
{
  setting_key_value_file="$APP_HOME/setting_key_value.conf"

  # Setting new key=value pair of configurations
  echo "Setting new key=value configs to '$setting_key_value_file'"
  # An associative array to hole newly created data
  declare -A setting_key_value_array
  setting_key_value_array["app_name"]="$APP_NAME"
  setting_key_value_array["app_slug"]="$APP_SLUG"
  setting_key_value_array["app_version"]="$APP_VERSION"
  # Pass the file path and array name to the set_config(). A new file will created if doesn't exist
  set_config "$setting_key_value_file" "setting_key_value_array"

  empty_line

  # Getting newly created key=value pair of configurations
  echo "Getting settings from '$setting_key_value_file' file"
  # An associative array to hole returned data
  declare -A setting_key_value_data
  # Pass file path and array name to the get_config()
  get_config "$setting_key_value_file" "setting_key_value_data"

  # # Iterate over the keys
  # echo "All keys:"
  # for key in "${!setting_key_value_data[@]}"; do
  #     echo "- $key"
  # done

  # # Iterate over the value
  # echo "All values:"
  # for value in "${setting_key_value_data[@]}"; do
  #     echo "- $value"
  # done

  # # Accessing the values
  echo "App Name: ${setting_key_value_data["app_name"]}"
  echo "App Slug: ${setting_key_value_data["app_slug"]}"
  echo "App Version: ${setting_key_value_data["app_version"]}"
}

show_app_header
empty_line

demo_style_text_format
empty_line

demo_style_text_foreground
empty_line

demo_style_text_background
empty_line

demo_style_combine_use_case
empty_line

demo_ui_message_box
empty_line

demo_config_list
empty_line

demo_config_key_value
empty_line

show_app_footer
empty_line
