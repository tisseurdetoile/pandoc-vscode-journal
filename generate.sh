#!/bin/bash
exclude=(output pandoc)
output=docs/
jsonindex=index.json
markdown=*.md
timestamp=$(date +%s)
separator=""

# retourne les information des fichiers sous forme de flux json
writeFileInfo() {
  fileInfo=${1%.*}
  fileDestination=$2

  splitInfo=(${fileInfo//\// })
  data=""

  if [[ ${splitInfo[0]} ]] ; then
    data+="\"year\" : ${splitInfo[0]}"
  fi

  if [[ ${splitInfo[1]} ]] ; then
    data+=",\"displaymonth\" : \"${splitInfo[1]}\""
    data+=",\"month\" : ${splitInfo[1]##0}"
  fi

  if [[ ${splitInfo[2]} ]] ; then
    data+=",\"displayday\" : \"${splitInfo[2]}\""
    data+=",\"day\" : ${splitInfo[2]##0}"
  fi

  if [[ ${splitInfo[3]} ]] ; then
    data+=",\"sub\" : \"${splitInfo[3]}\""
  fi

  data+=",\"fileDestination\" : \"${fileDestination}\""

  echo "{$data}"
}

parse_folder () {
  folderName=$1
  for file in $folderName/*; do
    if [[ -f "$file" && ! -L "$file" && $file == *.md ]]; then
      normalizedFile=${file//\//\_}
      title=${normalizedFile%.*}
      destinationFile=${normalizedFile%.*}.html
      jsonData="$(writeFileInfo $file $destinationFile)"
      echo $separator$jsonData >> $output$jsonindex
      pandoc -s --metadata title="$title" --template="pandoc/template.html" --css style.css --include-before-body=pandoc/header.html -o $output$destinationFile $file
      separator=","
    fi
  done
}

# START OF THE SCRIPT
if [[ ! -d $output ]]; then
  mkdir -p $output
fi

echo "{ \"timestamp\": $timestamp, \"articles\" : [" > $output$jsonindex

for folder in * **/* **/**/*; do
  if [[ -d "$folder" && ! -L "$folder" && ! " ${exclude[@]} " =~ " ${folder} " ]]; then
    parse_folder $folder
  fi;
done

if [[ -f "README.md" ]]; then
  pandoc -s --metadata title="LisezMoi" --template="pandoc/template.html" --css style.css --include-before-body=pandoc/header.html -o ${output}index.html README.md
else
  cp pandoc/archive.html  "${output}index.html"
fi

if [[ -f "LICENSE" ]]; then
  cp LICENSE  "${output}LICENSE"
fi

cp pandoc/style.css  "${output}style.css"
cp pandoc/archive.html  "${output}archive.html"

echo "]}" >> $output$jsonindex
