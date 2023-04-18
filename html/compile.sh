#!/bin/bash

input=$1
output=$2
resource_folder=$3
custom_templates=$4

templatedir="$(mktemp -d)/"
cp -r html/templates/* ${templatedir}
if [ ! -z ${custom_templates} ]; then
  cp -r ${custom_templates}/* ${templatedir}
fi

targets=$(find "${input}" -type f -name "index.md" | sed -r "s|^${input}/||" | sed -r "s|/index.md$||")

# Replicate input directory structure in output directory:
echo "${targets}" | grep -Po '(.*)/' | sort | uniq | xargs -i mkdir -p "${output}"/{}

cp -r "${resource_folder}"/* "${output}"
for target in ${targets}; do

  echo "Compiling $target"

  subdirs="${target//[^\/]}"
  nesting=""
  for (( c=1; c<=${#subdirs}; c++ )); do
    nesting="${nesting}../"
  done
  basename=$(basename $target)
  tmp_name="/tmp/${basename}"

  additionalfiles=${output}/${target}-files
  mkdir -p $additionalfiles
  cp -r ${input}/$target/* $additionalfiles
  mv $additionalfiles/index.md $tmp_name

  python pre-script-runner.py ${templatedir} $tmp_name $basename $additionalfiles $input
  title=$(grep -oP '^# *\K.*' $tmp_name | head -n 1)
  custom_scripts=$(awk '{if ($0 ~ "{{include-script") { sub("}}", "", $2); file = substr($2, index($2, "=") + 1); print file;}}' $tmp_name)
  custom_css=$(    awk '{if ($0 ~ "{{include-css")    { sub("}}", "", $2); file = substr($2, index($2, "=") + 1); print file;}}' $tmp_name)

  export INCUNABLE_TEMPLATE_DIR=${templatedir}
  ./template_substituter.awk $tmp_name > ${tmp_name}_2 && mv ${tmp_name}_2 $tmp_name
  cmark-gfm -e table -e strikethrough -e footnotes --table-prefer-style-attributes --unsafe $tmp_name > ${tmp_name}_2 && mv ${tmp_name}_2 $tmp_name
  sed -i 's/&amp;/\&/g' $tmp_name
  unset INCUNABLE_TEMPLATE_DIR


  sed -e "s|\${nesting}|${nesting}|g" ${output}/header > /tmp/header
  sed -e "s|\${nesting}|${nesting}|g" ${output}/footer > /tmp/footer
  awk -v title="${title}" -v folder="${basename}-files/" -v custom_css="${custom_css}" -v custom_scripts="${custom_scripts}" -i inplace '{
    css = "";
    scripts = "";
    split(custom_css, c, " ");
    split(custom_scripts, s, " ");

    for (i in c) css = css "  <link rel=\"stylesheet\" type=\"text/css\" href=\"" folder c[i] "\" />\n";
    for (i in s) scripts = scripts "  <script src=\"" folder s[i] "\"></script>\n";

    sub("\\${title}", title, $0);
    sub("</head>",     css "</head>", $0);
    sub("</head>", scripts "</head>", $0);
    print $0;
    }' /tmp/header
  echo -e "$(cat /tmp/header)\n$(cat $tmp_name)\n$(cat /tmp/footer)" > ${output}/${target}.html

  rm /tmp/header /tmp/footer $tmp_name
  rm -f ${additionalfiles}/reflist
done

rm -rf ${output}/header ${output}/footer ${templatedir}
