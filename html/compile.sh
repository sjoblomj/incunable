#!/bin/bash

input=$1
output=$2

templatedir=html/templates/
mkdir -p ${output}
cp -r resources/* ${output}
for target in $(ls ${input}); do

  echo "Compiling $target"

  additionalfiles=${output}/${target}-files
  mkdir -p $additionalfiles
  cp -r ${input}/$target/* $additionalfiles
  mv $additionalfiles/index.md /tmp/$target

  python pre-script-runner.py ${templatedir} /tmp/$target $target $additionalfiles
  title=$(grep -oP '^# *\K.*' /tmp/$target | head -n 1)
  custom_scripts=$(awk '{if ($0 ~ "{{include-script") { sub("}}", "", $2); file = substr($2, index($2, "=") + 1); print file;}}' /tmp/$target)
  custom_css=$(    awk '{if ($0 ~ "{{include-css")    { sub("}}", "", $2); file = substr($2, index($2, "=") + 1); print file;}}' /tmp/$target)

  export INCUNABLE_TEMPLATE_DIR=${templatedir}
  ./template_substituter.awk /tmp/$target > /tmp/${target}_2 && mv /tmp/${target}_2 /tmp/$target
  cmark-gfm -e table -e strikethrough -e footnotes --table-prefer-style-attributes --unsafe /tmp/$target > /tmp/${target}_2 && mv /tmp/${target}_2 /tmp/$target
  unset INCUNABLE_TEMPLATE_DIR


  cp html/header /tmp/header
  cp html/footer /tmp/footer
  awk -v title="${title}" -v folder="${target}-files/" -v custom_css="${custom_css}" -v custom_scripts="${custom_scripts}" -i inplace '{
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
  echo -e "$(cat /tmp/header)\n$(cat /tmp/$target)\n$(cat /tmp/footer)" > ${output}/${target}.html

  rm /tmp/header /tmp/footer /tmp/$target
  rm -f ${additionalfiles}/reflist
done
