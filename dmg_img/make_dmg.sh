if [ $# -lt 1 ]; then
  echo "Usage: bash \"$0\" \"path/to/dmg.dmg\""
  exit 1
fi

dmgFile="$1"

# find split .dmg files, and merge them
# Example:
# - .dmg file: SF-Symbols.dmg
# - .url file: SF-Symbols.url
# - split .dmg files: SF-Symbols.dmg{00,01,...}
function merge_splits {
  local dmgFile="$1"
  local splitFiles=$(find -regex ".*/$dmgFile[0-9]+" | sort)

  if [ -n "$splitFiles" ]; then
    echo "Merging these files into \"$dmgFile\":"
    echo "$splitFiles"
    cat "$splitFiles" > "$dmgFile"
  fi
}

# split .dmg into smaller volumes (to avoid exceeding GitHub file size limit)
# Example:
# - .dmg file: SF-Symbols.dmg
# - split .dmg files: SF-Symbols.dmg{00,01,...}
function split_dmg {
  local dmgFile="$1"
  local splitSize=49MB # just below the 50MB limit, as recommended by GitHub

  # delete the original split .dmg files
  find -regex ".*/$dmgFile[0-9]+" -delete

  split --verbose "$dmgFile" -b $splitSize -d "$dmgFile" # use numerical suffix
}

# get the .dmg file
function get_dmg_file {
  local dmgFile="$1"
  local urlFile="${dmgFile%.*}.url"

  # merge .dmg files
  merge_splits "$dmgFile"

  # wget the .dmg file (check on server if it is newest)
  wget -N -i "$urlFile"

  # split the .dmg files into volumes
  split_dmg "$dmgFile"
}

get_dmg_file "$dmgFile"