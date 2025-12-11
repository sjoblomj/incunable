#!/bin/bash

incunable_folder="$(readlink -f "$0")"
input="$(           readlink -f "$1")"
output="$(          readlink -f "$2")"
resource_folder="$( readlink -f "$3")"
custom_templates="$(readlink -f "$4")"

prev_dir="$(pwd)"
cd "$(dirname "$incunable_folder")/.." || exit 1

templatedir="$(mktemp -d)/"
cp -r html/templates/* "$templatedir"
if [ -n "$custom_templates" ]; then
  cp -r "$custom_templates"/* "$templatedir"
fi

targets=$(find "${input}" -type f -name "index.md" | sed -r "s|^${input}/||" | sed -r "s|/index.md$||")

# Replicate input directory structure in output directory:
mkdir -p "$output"
echo "${targets}" | grep -Po '(.*)/' | sort | uniq | xargs -I {} mkdir -p "$output"/{}

cp -r "$resource_folder"/* "$output"
for target in ${targets}; do

  echo "Compiling $target"

  subdirs="${target//[^\/]}"
  nesting=""
  for (( c=1; c<=${#subdirs}; c++ )); do
    nesting="${nesting}../"
  done
  basename=$(basename "$target")
  tmp_name="/tmp/${basename}"

  additionalfiles=${output}/${target}-files
  mkdir -p "$additionalfiles"
  cp -r "$input/$target"/* "$additionalfiles"
  mv "$additionalfiles"/index.md "$tmp_name"

  if command -v python3 &>/dev/null; then
    PYTHON=python3
  elif command -v python &>/dev/null; then
    PYTHON=python
  else
    echo "Error: Python is not installed." >&2
    exit 1
  fi
  $PYTHON pre-script-runner.py "$templatedir" "$tmp_name" "$basename" "$additionalfiles" "$input"
  title=$(grep -oP '^# *\K.*' "$tmp_name" | head -n 1)
  custom_scripts=$(awk '{if ($0 ~ "{{include-script") { sub("}}", "", $2); file = substr($2, index($2, "=") + 1); print file;}}' "$tmp_name")
  custom_css=$(    awk '{if ($0 ~ "{{include-css")    { sub("}}", "", $2); file = substr($2, index($2, "=") + 1); print file;}}' "$tmp_name")

  export INCUNABLE_TEMPLATE_DIR="$templatedir"
  ./template_substituter.awk "$tmp_name" > "${tmp_name}_2" && mv "${tmp_name}_2" "$tmp_name"
  cmark-gfm -e table -e strikethrough -e footnotes --table-prefer-style-attributes --unsafe "$tmp_name" > "${tmp_name}_2" && mv "${tmp_name}_2" "$tmp_name"
  sed -i 's/&amp;/\&/g' "$tmp_name"
  unset INCUNABLE_TEMPLATE_DIR


  sed -e "s|\${nesting}|${nesting}|g" "$output"/header > /tmp/header
  sed -e "s|\${nesting}|${nesting}|g" "$output"/footer > /tmp/footer
  awk -v title="${title}" -v filename="${basename}" -v sourcedir="${additionalfiles}" -v folder="${basename}-files/" -v custom_css="${custom_css}" -v custom_scripts="${custom_scripts}" -i "utils.awk" -i inplace '{
    css = ""
    scripts = ""
    split(custom_css, c, " ")
    split(custom_scripts, s, " ")

    for (i in c) css = css "  <link rel=\"stylesheet\" type=\"text/css\" href=\"" folder c[i] "\" />\n"
    for (i in s) scripts = scripts "  <script src=\"" folder s[i] "\"></script>\n"
    sub("</head>", css scripts "</head>", $0)

    if (match($0, /\$\{include-header-([0-9]+)\}/, arr)) {
        sub("\\${include-header-" arr[1] "}", read_file(sourcedir "/_include-header-" arr[1]))
    }
    sub("\\${title}",    title,    $0)
    sub("\\${filename}", filename, $0)
    print $0
    }' /tmp/header

  awk -v title="${title}" -v filename="${basename}" -v sourcedir="${additionalfiles}" -i "utils.awk" -i inplace '{
    if (match($0, /\$\{include-footer-([0-9]+)\}/, arr)) {
        sub("\\${include-footer-" arr[1] "}", read_file(sourcedir "_include-footer-" arr[1]))
    }
    sub("\\${title}",    title,    $0)
    sub("\\${filename}", filename, $0)
    print $0
    }' /tmp/footer
  echo -e "$(cat /tmp/header)\n$(cat "$tmp_name")\n$(cat /tmp/footer)" > "$output/$target.html"

  rm /tmp/header /tmp/footer "$tmp_name"
  rm -f "$additionalfiles"/reflist
done
cd "$prev_dir" || exit 1

rm -rf "$output"/header "$output"/footer "$templatedir"
