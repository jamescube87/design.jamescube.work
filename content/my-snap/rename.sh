#!/bin/bash

for file in *.jpg *.JPG; do
  [ -e "$file" ] || continue

  newname=$(exiftool -s -s -s \
    -d '%Y-%m-%d-%H%M%S' \
    -CreateDate "$file")

  if [ -z "$newname" ]; then
    echo "⚠️  CreateDate 없음 → 건너뜀: $file"
    continue
  fi

  target="${newname}.jpg"

  if [ -e "$target" ]; then
    i=1
    while [ -e "${newname}_$i.jpg" ]; do
      i=$((i + 1))
    done
    target="${newname}_$i.jpg"
  fi

  echo "✔️  $file → $target"
  mv "$file" "$target"
done