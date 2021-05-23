if [ $# -lt 1 ]; then
  echo "Usage: bash \"$0\" <dmg_path.dmg>"
  exit 1
fi

dmgFile=$1

# find splitted files, and merge them
# Example:
# - .dmg file: SF-Symbols.dmg
# - .url file: SF-Symbols.url
# - splitted .dmg files: SF-Symbols.dmg{00,01,...}
function merge_splits {
  dmgFile=$1
  splitFiles=$(find -regex ".*/$dmgFile[0-9]+" | sort)

  if [ -n "$splitFiles" ]; then
    echo "Merging these files into \"$dmgFile\":"
    echo $splitFiles
    cat $splitFiles > $dmgFile
  fi
}

# split .dmg into smaller volumes (to avoid exceeding GitHub file size limit)
# Example:
# - .dmg file: SF-Symbols.dmg
# - splitted .dmg files: SF-Symbols.dmg{00,01,...}
function split_dmg {
  dmgFile=$1
  splitSize=49MB # just below the 50MB limit, as recommended by GitHub

  split --verbose "$dmgFile" -b $splitSize -d "$dmgFile" # use numerical suffix
}

# get the .dmg file
function get_dmg_file {
  dmgFile=$1
  urlFile=${dmgFile%.*}.url

  # merge splitted files
  merge_splits "$dmgFile"

  # wget the .dmg file (check on server if it is newest)
  wget -N -i "$urlFile"

  # split the .dmg files into volumes
  split_dmg "$dmgFile"
}

get_dmg_file $dmgFile