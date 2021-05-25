if [ $# -lt 2 ]; then
  echo "Usage: \"$0\" \"path/to/img.img\" \"path/to/fonts\""
  exit 1
fi

imgFile="$1"
fontsDir="$2"

function extract_fonts {
  local imgFile="$1"
  local fontsDir="$2"

  # 1. make fonts directory
  mkdir -pv "$fontsDir"

  # 2. make temporary directory
  local tempDir=$(mktemp -d)

  # 3. extract the .img file to temporary directory
  7z x "$imgFile" -o"$tempDir"

  # 4. find and extract the .pkg file in the temporary directory
  find "$tempDir" -name "*.pkg" -exec 7z x {} -o"$tempDir" ";"

  # 5. find and extract the "Payload~" file in the temporary directory
  find "$tempDir" -name "Payload~" -exec 7z x {} -o"$tempDir" ";"

  # 6. find the fonts files (.ttf and .otf), and move them to the fonts directory
  find "$tempDir" -name "*.[ot]tf" -exec mv -v {} "$fontsDir" ";"

  # 7. remove temporary directory
  rm -rf "$tempDir"
}

extract_fonts "$imgFile" "$fontsDir"