#!/bin/bash
set -e

# Parse arguments
SOURCE_PATH="$1"
DOC_PATH="$2"
DOC_FILENAME="$3"
FORMAT="$4"
GENERATE_INDEX="$5"
LOG_LEVEL="$6"
SHOW_TOC="$7"
SHOW_ALERTS="$8"
SHOW_SHELLCHECK="$9"
SHELLCHECK_DISPLAY="${10}"
HIGHLIGHT_CODE="${11}"
HIGHLIGHT_LANGUAGE="${12}"
EXAMPLE_DISPLAY="${13}"
ARGUMENTS_DISPLAY="${14}"
TRAVERSE_SYMLINKS="${15}"
LINKIFY_USERNAMES="${16}"
VERSION_PLACEMENT="${17}"
COPYRIGHT_PLACEMENT="${18}"
LICENSE_PLACEMENT="${19}"
CONFIG_FILE="${20}"

# Map GitHub workspace to Docker container
GITHUB_WORKSPACE=${GITHUB_WORKSPACE:-$(pwd)}
cd "$GITHUB_WORKSPACE"

# Create temporary config file if no custom config provided
if [ -z "$CONFIG_FILE" ] || [ ! -f "$CONFIG_FILE" ]; then
  CONFIG_FILE="/tmp/.scribeconf"
  echo "Creating temporary configuration file at $CONFIG_FILE"
  
  echo "doc_path = $DOC_PATH" > "$CONFIG_FILE"
  echo "doc_filename = $DOC_FILENAME" >> "$CONFIG_FILE"
  echo "format = $FORMAT" >> "$CONFIG_FILE"
  echo "generate_index = $GENERATE_INDEX" >> "$CONFIG_FILE"
  echo "log_level = $LOG_LEVEL" >> "$CONFIG_FILE"
  echo "show_toc = $SHOW_TOC" >> "$CONFIG_FILE"
  echo "show_alerts = $SHOW_ALERTS" >> "$CONFIG_FILE"
  echo "show_shellcheck = $SHOW_SHELLCHECK" >> "$CONFIG_FILE"
  echo "shellcheck_display = $SHELLCHECK_DISPLAY" >> "$CONFIG_FILE"
  echo "highlight_code = $HIGHLIGHT_CODE" >> "$CONFIG_FILE"
  echo "highlight_language = $HIGHLIGHT_LANGUAGE" >> "$CONFIG_FILE"
  echo "example_display = $EXAMPLE_DISPLAY" >> "$CONFIG_FILE"
  echo "arguments_display = $ARGUMENTS_DISPLAY" >> "$CONFIG_FILE"
  echo "traverse_symlinks = $TRAVERSE_SYMLINKS" >> "$CONFIG_FILE"
  echo "linkify_usernames = $LINKIFY_USERNAMES" >> "$CONFIG_FILE"
  echo "version_placement = $VERSION_PLACEMENT" >> "$CONFIG_FILE"
  echo "copyright_placement = $COPYRIGHT_PLACEMENT" >> "$CONFIG_FILE"
  echo "license_placement = $LICENSE_PLACEMENT" >> "$CONFIG_FILE"
fi

# Make sure output directory exists
mkdir -p "$DOC_PATH"

# Run Shellscribe
echo "Running Shellscribe on $SOURCE_PATH with configuration from $CONFIG_FILE"
scribe --config-file="$CONFIG_FILE" "$SOURCE_PATH"

# Print summary
echo "Documentation generated successfully in $DOC_PATH"
echo "Files generated:"
find "$DOC_PATH" -type f | sort 
