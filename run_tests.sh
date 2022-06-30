#!/bin/bash

echo Compiling documentation...
output_dir=$(mktemp -d)

./html/compile.sh documentation/input ${output_dir} documentation/input_resources 1>/dev/null
diff -qr documentation/output ${output_dir}

if [ $? -eq 0 ]; then
  echo Tests were successfull!
  rm -rf ${output_dir}
  exit 0
else
  echo Tests failed, see error above.
  exit 1
fi
