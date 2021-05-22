if [ $# -lt 1 ]; then
  echo "Usage: bash \"$0\" <file_to_split>"
  exit 1
fi

splitSize=50MB # do not exceed 50MB as recommended by GitHub

fileToSplit=$1
split --verbose "$fileToSplit" -b $splitSize -d SF-Symbols-2.1.dmg